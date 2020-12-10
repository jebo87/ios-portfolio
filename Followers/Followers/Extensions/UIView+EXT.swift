//
//  UIView+EXT.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-09.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...){
        for view in views { addSubview(view) }
    }
    
    func pinToEdges(of superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        
        ])
    }
}
