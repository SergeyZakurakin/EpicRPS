//
//  StatisticsViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 26.06.2024.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var userAvatarButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.alien, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let userAvatarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 23
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var userNameTextField: UITextField = {
       let txtFld = UITextField()
        txtFld.placeholder = "Username"
        txtFld.layer.cornerRadius = 20
        txtFld.layer.borderColor = UIColor.greyLight.cgColor
        txtFld.layer.borderWidth = 0.5
        txtFld.textColor = .blueLight
        txtFld.font = Font.getFont(.rubickBold, size: 16)
        txtFld.leftView = UIView()
        txtFld.translatesAutoresizingMaskIntoConstraints = false
        return txtFld
    }()
    
    private let backgroundTableView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let playerLabel = UILabel(text: "Player",
                                      font: .rubickBold,
                                      fontSize: 13,
                                      color: .greyLight,
                                      textAlignment: .left)
    
    private let topImageView = UIImageView(image: .top10)
    
    private let rateLabel = UILabel(text: "Rate",
                                    font: .rubickBold,
                                    fontSize: 13,
                                    color: .greyLight,
                                    textAlignment: .right)
    
    private var tableView = RPSTableView()
    
    
    //MARK: - Properties
    
    private lazy var users: [Player] = [
        Player(avatarName: "alien", victories: 0, loses: 0, score: 0),
    Player(avatarName: "wrestler", victories: 0, loses: 0, score: 0),
    Player(avatarName: "dcWrestler", victories: 0, loses: 0, score: 0),
    Player(avatarName: "marvelWrestler", victories: 0, loses: 0, score: 0),
    Player(avatarName: "alien", victories: 0, loses: 0, score: 0),
    Player(avatarName: "wrestler", victories: 0, loses: 0, score: 0),
    Player(avatarName: "dcWrestler", victories: 0, loses: 0, score: 0),
    Player(avatarName: "marvelWrestler", victories: 0, loses: 0, score: 0)
    ]
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configure()
        setConstraints()
        setupNavBar(on: self, title: "Leaderboard", leftImage: .back, leftSelector: #selector(backButtonDidTap), rightImage: nil, rightSelector: nil)
    }
}


//MARK: - Internal Methods

private extension StatisticsViewController {
    
    //MARK: - Actions
    
    @objc func backButtonDidTap() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    //MARK: - Setup UI
    
    func configure() {
        view.addSubviews(userAvatarBackgroundView, userAvatarButton, userNameTextField, backgroundTableView, playerLabel, topImageView, rateLabel, tableView)
        
        view.backgroundColor = .greyWhite
    }
    
    
    func configureTableView() {
        tableView = RPSTableView(users: users)
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            userAvatarBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            userAvatarBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            userAvatarBackgroundView.heightAnchor.constraint(equalToConstant: 46),
            userAvatarBackgroundView.widthAnchor.constraint(equalToConstant: 46),
            
            userAvatarButton.centerXAnchor.constraint(equalTo: userAvatarBackgroundView.centerXAnchor),
            userAvatarButton.centerYAnchor.constraint(equalTo: userAvatarBackgroundView.centerYAnchor),
            userAvatarButton.heightAnchor.constraint(equalToConstant: 40),
            userAvatarButton.widthAnchor.constraint(equalToConstant: 34),
            
            userNameTextField.topAnchor.constraint(equalTo: userAvatarBackgroundView.topAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: userAvatarBackgroundView.trailingAnchor, constant: 8),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            userNameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            backgroundTableView.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 45),
            backgroundTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            backgroundTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            backgroundTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            
            playerLabel.topAnchor.constraint(equalTo: backgroundTableView.topAnchor, constant: 45),
            playerLabel.leadingAnchor.constraint(equalTo: backgroundTableView.leadingAnchor, constant: 35),
            playerLabel.widthAnchor.constraint(equalToConstant: 50),
            
            topImageView.centerXAnchor.constraint(equalTo: backgroundTableView.centerXAnchor),
            topImageView.topAnchor.constraint(equalTo: backgroundTableView.topAnchor, constant: -30),
            topImageView.heightAnchor.constraint(equalToConstant: 95),
            topImageView.widthAnchor.constraint(equalToConstant: 165),
        
            rateLabel.topAnchor.constraint(equalTo: backgroundTableView.topAnchor, constant: 45),
            rateLabel.leadingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: 25),
            rateLabel.trailingAnchor.constraint(equalTo: backgroundTableView.trailingAnchor, constant: -50),
            
            tableView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: backgroundTableView.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: backgroundTableView.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: backgroundTableView.bottomAnchor, constant: -15)
        ])
    }
}
