//
//  FightLoadView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

final class FightLoadView: UIView {
    
    //MARK: - Properties
    
    private var user: Player
    private var computer: Player
    
    
    //MARK: - UI
    
    private let backgroundImageView = UIImageView(image: .blueBackground)
    
    private lazy var userInfoView = RPSPlayerInfoView(player: user)
    private lazy var computerInfoView = RPSPlayerInfoView(player: computer)
    
    private let announcementLabel = UILabel(text: "VS", fontSize: 56, color: .yellowDarker)
    private let readinessLabel = UILabel(text: "Get ready...", color: .yellowDarker)
    
    private var stackView = UIStackView()
    
    
    //MARK: - Lifecycle
    
    init(user: Player, computer: Player) {
        self.user = user
        self.computer = computer
        
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - External methods

extension FightLoadView {
    func configureView(with user: Player, and computer: Player) {
        computerInfoView = RPSPlayerInfoView(player: computer)
        userInfoView = RPSPlayerInfoView(player: user)
    }
}


//MARK: - Internal Methods

private extension FightLoadView {
    func configure() {
        addSubviews(backgroundImageView, stackView, readinessLabel)
        
        configureStackViews()
        setConstraints()
        configureView(with: user, and: computer)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureStackViews() {
        stackView.addArrangedSubviews(computerInfoView, announcementLabel, userInfoView)
        
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
            
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.bottomAnchor.constraint(equalTo: readinessLabel.topAnchor, constant: -100)
        ])
    }
}
