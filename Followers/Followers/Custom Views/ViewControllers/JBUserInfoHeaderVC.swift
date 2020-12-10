//
//  JBUserInfoHeaderVC.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-06.
//

import UIKit
class JBUserInfoHeaderVC: UIViewController {
    
    let avatarJBView = JBAvatarImageView(frame: .zero)
    let usernameLabel = JBTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = JBSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = JBSecondaryTitleLabel(fontSize: 18)
    let bioLabel = JBBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()

    }
    
    func configureUIElements(){
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarJBView.image = image }
        }
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        locationImageView.image = Images.locationImage
        locationImageView.tintColor = .secondaryLabel
    }
    
    func addSubviews(){
        view.addSubviews(avatarJBView, usernameLabel, nameLabel, locationLabel, locationImageView, bioLabel)
    }
    
    func layoutUI(){
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarJBView.topAnchor.constraint(equalTo: view.topAnchor,constant: padding),
            avatarJBView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarJBView.widthAnchor.constraint(equalToConstant: 90),
            avatarJBView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarJBView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarJBView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),

            nameLabel.centerYAnchor.constraint(equalTo: avatarJBView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarJBView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            locationImageView.bottomAnchor.constraint(equalTo: avatarJBView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarJBView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),

            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: avatarJBView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarJBView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
        
    }
}


