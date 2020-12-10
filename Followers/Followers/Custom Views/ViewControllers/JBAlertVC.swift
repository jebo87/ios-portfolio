//
//  JBAlertVCViewController.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-02.
//

import UIKit
class JBAlertVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel = JBTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = JBBodyLabel(textAlignment: .center)
    let actionButton = JBButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        view.addSubviews(containerView,titleLabel,actionButton,messageLabel)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
        
    }
    
    func configureContainerView(){
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel(){
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton(){
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel(){
        messageLabel.text = message ?? "unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
}

#if DEBUG
//This is to enable previews.
import SwiftUI

struct VCPreview: PreviewProvider {
    
    static var previews: some View {
        VCContainerView().edgesIgnoringSafeArea(.all)
            .previewLayout(.sizeThatFits)
            
    }
    
    struct VCContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return JBAlertVC(title: "Title Text", message: "This is an example message", buttonTitle: "OK")
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
    
    
}
#endif

