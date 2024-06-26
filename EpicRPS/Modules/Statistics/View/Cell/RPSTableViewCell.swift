//
//  RPSTableViewCell.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 26.06.2024.
//

import UIKit

final class RPSTableViewCell: UITableViewCell {

    //MARK: - UI

    private let cellBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userImageView = UIImageView(image: .alien)
    
    private let userNameLabel = UILabel(text: "Username",
                                        font: .rubickBold,
                                        fontSize: 14,
                                        color: .green)
    
    private let userScoreLabel = UILabel(text: "1000",
                                         font: .rubickBold,
                                         fontSize: 13,
                                         color: .yellow)
    
    private let userPercentScoreLabel = UILabel(text: "100%",
                                                font: .rubickMedium,
                                                fontSize: 18,
                                                color: .blue)
    //MARK: - Properties
    
    static let idCell = "RPSTableViewCell"
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - External Methods

extension RPSTableViewCell {
    func configure(with: Player) {
        
    }
}


//MARK: - Internal Methods

private extension RPSTableViewCell {
    func configure() {
        addSubviews(cellBackgroundView,
                         userImageView,
                         userNameLabel,
                         userScoreLabel,
                         userPercentScoreLabel)
        
        backgroundColor = .brownBase
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            cellBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            cellBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        
            userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImageView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 15),
            userImageView.heightAnchor.constraint(equalToConstant: 36),
            userImageView.widthAnchor.constraint(equalToConstant: 32),
            
            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 20),
            userNameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            userScoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userScoreLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 50),
            userScoreLabel.widthAnchor.constraint(equalToConstant: 50),
            
            userPercentScoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userPercentScoreLabel.leadingAnchor.constraint(equalTo: userScoreLabel.trailingAnchor, constant: 20),
            userPercentScoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
