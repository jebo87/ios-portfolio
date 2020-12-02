//
//  FollowersVC.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-01.
//

import UIKit

class FollowersVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false

    }
    
}
