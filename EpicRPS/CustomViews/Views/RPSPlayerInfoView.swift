//
//  RPSPlayerInfoView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 11.06.2024.
//

import UIKit

final class RPSPlayerInfoView: UIView {
    
    //MARK: - UI
    
    private let characterImage = RPSImageView()
    private let statisticLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = Font.getFont(.rubickBold, size: 19)
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 2
        lbl.minimumScaleFactor = 0.9
        lbl.lineBreakMode = .byTruncatingTail
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    
    convenience init(image: UIImage,
                     winScore: String,
                     loseScore: String) {
        self.init()
        
        characterImage.image = image
        statisticLabel.attributedText = setLabels(winScore: winScore, victoryLabel: " Victories/", loseScore: loseScore, loseLabel: " Lose")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Internal Methods

private extension RPSPlayerInfoView {
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(characterImage)
        addSubview(statisticLabel)
    }
    
    
    func setLabels(winScore: String, victoryLabel: String, loseScore: String, loseLabel: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(NSAttributedString(string: winScore, attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellowDarker]))
        
        attributedString.append(NSAttributedString(string: victoryLabel, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        attributedString.append(NSAttributedString(string: loseScore, attributes: [NSAttributedString.Key.foregroundColor: UIColor.redLight]))
        
        attributedString.append(NSAttributedString(string: loseLabel, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        return attributedString
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: topAnchor),
            characterImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: 100),
            characterImage.widthAnchor.constraint(equalToConstant: 90),
            
            
            statisticLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 10),
            statisticLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            statisticLabel.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
}
