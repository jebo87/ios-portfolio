//
//  UIHelper.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-03.
//

import UIKit
enum UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewLayout {        
        let width = view.bounds.width
        let padding : CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    static let user = User(
        login: "jebo87",
        avatarUrl: "https://avatars2.githubusercontent.com/u/7273200?v=4",
        name: "Jorge Bautista",
        location: "Montreal",
        bio: "Developer, Serial Entrepreneur",
        publicRepos: 2,
        publicGists: 2,
        htmlUrl: "https://github.com/jebo87",
        following: 2,
        followers: 5,
        createdAt: "2014-04-12T14:09:17Z"
    )
    
}
