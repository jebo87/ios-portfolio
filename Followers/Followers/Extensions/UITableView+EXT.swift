//
//  UITableView+EXT.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-09.
//

import UIKit

extension UITableView {
    func removeExcessCells(){ tableFooterView = UIView(frame: .zero) }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
}
