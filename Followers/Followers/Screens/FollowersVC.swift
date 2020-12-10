//
//  FollowersVC.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-01.
//

import UIKit



class FollowersVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    init(username: String){
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        
        
        configureDataSource()
        configureSearchController()
        getFollowers(username: username, page: 1)
        print("view did load")
        
    }
    
   
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 🥺"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentJBAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    @objc func addButtonTapped(){
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result{
            case .success(let user):
                let follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: follower, actionType: .add) { [weak self] (error) in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentJBAlertOnMainThread(title: "Success", message: "You have successfully added this user to your favorites 🎉", buttonTitle: "Ok")
                        return
                    }
                    
                    self.presentJBAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentJBAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}

extension FollowersVC: UICollectionViewDelegate {
   
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC(username: follower.login)
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowersVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            isSearching = false
            updateData(on: followers)
            return
            
        }
        isSearching = true
        filteredFollowers = followers.filter({ $0.login.lowercased().contains(filter.lowercased()) })
        updateData(on: filteredFollowers)
    }
}

extension FollowersVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        hasMoreFollowers = true
        isSearching = false
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
        
    }
    
    
}


#if DEBUG
//This is to enable previews.
import SwiftUI

struct FollowersVCPreview: PreviewProvider {
    
    static var previews: some View {
        VCContainerView().edgesIgnoringSafeArea(.all)
            
            
    }
    
    struct VCContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return FollowersVC(username: "dhh")
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
    
    
}
#endif
