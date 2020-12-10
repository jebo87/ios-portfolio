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
}
