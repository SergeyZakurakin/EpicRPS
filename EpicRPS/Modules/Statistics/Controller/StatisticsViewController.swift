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
        Player(name: "Player1", avatarName: "alien", victories: 1, loses: 8, score: 0, highscore: 0),
    Player(name: "Player2", avatarName: "wrestler", victories: 2, loses: 7, score: 0, highscore: 0),
    Player(name: "Player3", avatarName: "dcWrestler", victories: 3, loses: 6, score: 0, highscore: 0),
    Player(name: "Player4", avatarName: "marvelWrestler", victories: 4, loses: 5, score: 0, highscore: 0),
    Player(name: "Player5", avatarName: "sadWrestler", victories: 5, loses: 4, score: 0, highscore: 0),
    Player(name: "Player6", avatarName: "happyWrestler", victories: 6, loses: 3, score: 0, highscore: 0),
    Player(name: "Player7", avatarName: "lightning", victories: 7, loses: 2, score: 0, highscore: 0),
    Player(name: "Player8", avatarName: "scissorsHand", victories: 8, loses: 1, score: 0, highscore: 0)
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
    
    
    @objc func changeAvatarButton() {
        print("did tap")
    }
    
    
    //MARK: - Setup UI
    
    func configure() {
        view.addSubviews(userView,
                         titlesView,
                         tableView)
        
        view.backgroundColor = .greyWhite
        userView.userAvatarButton.addTarget(self, action: #selector(changeAvatarButton), for: .touchUpInside)

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
