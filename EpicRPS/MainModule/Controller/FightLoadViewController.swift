//
//  FightLoadViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

final class FightLoadViewController: UIViewController {
    
    //MARK: - Properties
    
    private let playerWinScore = 23
    private let playerLoseScore = 1
    private let computerWinScore = 10
    private let computerLoseScore = 2
    
    
    //MARK: - UI
    
    private let backgroundImageView = RPSImageView(image: .blueBackground)
    
    private var computer = RPSPlayerInfoView()
    private var player = RPSPlayerInfoView()
    
    private let announcementLabel = RPSTitleLabel(text: "VS",fontSize: 56, color: .yellowDarker)
    private let readinessLabel = RPSTitleLabel(text: "Get ready...", color: .yellowDarker)
    
    private var stackView = UIStackView()
    
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}


//MARK: - Internal Methods

private extension FightLoadViewController {
    func configure() {
        let views = [backgroundImageView,
                     stackView,
                     readinessLabel]
        views.forEach { view.addSubview($0) }
        
        configureLabels()
        configureStackViews()
        setConstraints()
    }
    
    
    func configureLabels() {
        computer = RPSPlayerInfoView(image: .alien, winScore: "\(computerWinScore)", loseScore: "\(computerLoseScore)")
        player = RPSPlayerInfoView(image: .wrestler, winScore: "\(playerWinScore)", loseScore: "\(playerLoseScore)")
    }
    
    
    func configureStackViews() {
        stackView.addArrangedSubview(computer)
        stackView.addArrangedSubview(announcementLabel)
        stackView.addArrangedSubview(player)
        
        stackView.axis = .vertical
        stackView.spacing = 60
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            readinessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readinessLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            readinessLabel.heightAnchor.constraint(equalToConstant: 25),
            readinessLabel.widthAnchor.constraint(equalToConstant: 110),
            
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.bottomAnchor.constraint(equalTo: readinessLabel.topAnchor, constant: -100)
        ])
    }
}
