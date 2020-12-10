//
//  UserInfoVC.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-05.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    let dateLabel = JBBodyLabel(textAlignment: .center)
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
        
    }
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) {[weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.configureUIElements(with: user)
                
            case .failure(let error):
                self.presentJBAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureUIElements(with user: User){
        DispatchQueue.main.async {
            let repoItemVC = JBRepoItemVC(user: user)
            repoItemVC.delegate = self
            
            let followerItemVC = JBFollowerItemVC(user: user)
            followerItemVC.delegate = self
            
            self.add(childVC: JBUserInfoHeaderVC(user: user), to: self.headerView)
            self.add(childVC: repoItemVC, to: self.itemViewOne)
            self.add(childVC: followerItemVC, to: self.itemViewTwo)
            self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
        }
    }
    
    func layoutUI(){
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        
       
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
}

extension UserInfoVC: JBRepoItemVCDelegate, JBFollowerItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentJBAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentJBAlertOnMainThread(title: "No followers", message: "This user has no followers 😅", buttonTitle: "So sad")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
}




#if DEBUG
//This is to enable previews.
import SwiftUI

struct UserInfoVCPreview: PreviewProvider {
    
    static var previews: some View {
        VCContainerView().edgesIgnoringSafeArea(.all)
            
            
    }
    
    struct VCContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return UserInfoVC(username: "angelabauer")
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
    
    
}
#endif

