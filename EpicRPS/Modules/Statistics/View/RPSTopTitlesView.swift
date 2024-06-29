//
//  RPSTopTitlesView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 29.06.2024.
//

import UIKit

final class RPSTopTitlesView: UIView {
    
    //MARK: - UI
    
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

private extension RPSTopTitlesView {
    func configure() {
        backgroundColor = .white
        layer.cornerRadius = 40
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews(playerLabel,
                    topImageView,
                    rateLabel)
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            playerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 45),
            playerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            playerLabel.widthAnchor.constraint(equalToConstant: 50),
            
            topImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topImageView.topAnchor.constraint(equalTo: topAnchor, constant: -30),
            topImageView.heightAnchor.constraint(equalToConstant: 95),
            topImageView.widthAnchor.constraint(equalToConstant: 165),
        
            rateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 45),
            rateLabel.leadingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: 25),
            rateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
    }
}
