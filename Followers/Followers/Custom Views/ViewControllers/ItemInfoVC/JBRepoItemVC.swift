//
//  JBRepoItemVC.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-07.
//

import UIKit
protocol JBRepoItemVCDelegate: class {
    func didTapGitHubProfile(for user: User)    
}
class JBRepoItemVC: JBItemInfoVC {

    weak var delegate: JBRepoItemVCDelegate! //all delegates should be weak
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
    
}

#if DEBUG
//This is to enable previews.
import SwiftUI

struct JBRepoItemVCPreview: PreviewProvider {
    
    static var previews: some View {
        VCContainerView().edgesIgnoringSafeArea(.all)
            .previewLayout(.fixed(width: 400, height: 150))
            
    }
    
    struct VCContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return JBRepoItemVC(user: UIHelper.user)
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
    
    
}
#endif
