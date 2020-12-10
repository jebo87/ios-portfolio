//
//  JBFollowerItemVC.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-07.
//

import UIKit
protocol JBFollowerItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}
class JBFollowerItemVC: JBItemInfoVC {
   
    weak var delegate: JBFollowerItemVCDelegate! //all delegates should be weak

        override func viewDidLoad() {
            super.viewDidLoad()
            configureItems()
        }
        
        private func configureItems(){
            itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
            itemInfoViewTwo.set(itemInfoType: .following, withCount: user.publicGists)
            actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
        }
        
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    }

#if DEBUG
//This is to enable previews.
import SwiftUI

struct JBFollowerItemVCPreview: PreviewProvider {
    
    static var previews: some View {
        VCContainerView().edgesIgnoringSafeArea(.all)
            .previewLayout(.fixed(width: 400, height: 150))
            
    }
    
    struct VCContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return JBFollowerItemVC(user: UIHelper.user)
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
    
    
}
#endif

