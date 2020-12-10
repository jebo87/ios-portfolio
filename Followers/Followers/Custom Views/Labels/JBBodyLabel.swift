//
//  JBBodyLabel.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-02.
//

import UIKit

class JBBodyLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
    }
    
}
