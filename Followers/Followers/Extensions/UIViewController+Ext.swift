//
//  UIViewController+Ext.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-02.
//

import UIKit

extension UIViewController {
    
    func presentJBAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = JBAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
}


