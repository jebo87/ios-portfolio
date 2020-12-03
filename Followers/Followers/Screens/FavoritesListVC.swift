//
//  FavoritesLIstVC.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-11-30.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
