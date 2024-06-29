//
//  RPSUserView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 29.06.2024.
//

import UIKit

final class RPSUserView: UIView {

    //MARK: - UI
    
    private let userAvatarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 23
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var userAvatarButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.alien, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var userNameTextField: UITextField = {
       let txtFld = UITextField()
        txtFld.placeholder = "Username"
        txtFld.layer.cornerRadius = 20
        txtFld.layer.borderColor = UIColor.greyLight.cgColor
        txtFld.layer.borderWidth = 0.5
        txtFld.textColor = .blueLight
        txtFld.font = Font.getFont(.rubickBold, size: 16)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        txtFld.leftView = leftView
        txtFld.leftViewMode = .always
        txtFld.translatesAutoresizingMaskIntoConstraints = false
        return txtFld
    }()
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Internal Methods

private extension RPSUserView {
    func configure() {
        addSubviews(userAvatarBackgroundView,
                    userAvatarButton,
                    userNameTextField)
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            userAvatarBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            userAvatarBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            userAvatarBackgroundView.heightAnchor.constraint(equalToConstant: 46),
            userAvatarBackgroundView.widthAnchor.constraint(equalToConstant: 46),
            
            userAvatarButton.centerXAnchor.constraint(equalTo: userAvatarBackgroundView.centerXAnchor),
            userAvatarButton.centerYAnchor.constraint(equalTo: userAvatarBackgroundView.centerYAnchor),
            userAvatarButton.heightAnchor.constraint(equalToConstant: 40),
            userAvatarButton.widthAnchor.constraint(equalToConstant: 34),
            
            userNameTextField.topAnchor.constraint(equalTo: userAvatarBackgroundView.topAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: userAvatarBackgroundView.trailingAnchor, constant: 8),
            userNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55),
            userNameTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}

