//
//  FightLoadView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

final class FightLoadView: UIView {
    
    //MARK: - Properties
    
    private var playerWinScore: Int
    private var playerLoseScore: Int
    private var computerWinScore: Int
    private var computerLoseScore: Int
    
    
    //MARK: - UI
    
    private let backgroundImageView = RPSImageView(image: .blueBackground)
    
    private var computer = RPSPlayerInfoView()
    private var player = RPSPlayerInfoView()
    
    private let announcementLabel = RPSTitleLabel(text: "VS",fontSize: 56, color: .yellowDarker)
    private let readinessLabel = RPSTitleLabel(text: "Get ready...", color: .yellowDarker)
    
    private var stackView = UIStackView()
    
    
    //MARK: - Lifecycle
    
    init(playerWinScore: Int,
         playerLoseScore: Int,
         computerWinScore: Int,
         computerLoseScore: Int) 
    {
        self.playerWinScore = playerWinScore
        self.playerLoseScore = playerLoseScore
        self.computerWinScore = computerWinScore
        self.computerLoseScore = computerLoseScore
        
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Internal Methods

private extension FightLoadView {
    func configure() {
        let views = [backgroundImageView,
                     stackView,
                     readinessLabel]
        views.forEach { addSubview($0) }
        
        configureLabels()
        configureStackViews()
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
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
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            readinessLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            readinessLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            readinessLabel.heightAnchor.constraint(equalToConstant: 25),
            readinessLabel.widthAnchor.constraint(equalToConstant: 110),
            
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.bottomAnchor.constraint(equalTo: readinessLabel.topAnchor, constant: -100)
        ])
    }
}
