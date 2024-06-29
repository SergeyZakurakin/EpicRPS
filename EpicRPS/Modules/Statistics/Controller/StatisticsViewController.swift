//
//  StatisticsViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 26.06.2024.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    //MARK: - UI
    
    private let userView = RPSUserView()
    private let titlesView = RPSTopTitlesView()
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
        view.addSubviews(userView,
                         titlesView,
                         tableView)
        
        view.backgroundColor = .greyWhite
    }
    
    
    func configureTableView() {
        tableView = RPSTableView(users: users)
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            userView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userView.heightAnchor.constraint(equalToConstant: 60),
            
            titlesView.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: 45),
            titlesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            titlesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            titlesView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            
            tableView.topAnchor.constraint(equalTo: titlesView.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: titlesView.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: titlesView.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: titlesView.bottomAnchor, constant: -15)
        ])
    }
}
