//
//  RPSTimeView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 26.06.2024.
//

import UIKit

final class RPSTimeView: UIView {
    
    //MARK: - UI
    
    private let timeLabel = UILabel(
        text: "Время игры",
        font: .rubickRegular,
        fontSize: 20,
        color: .greyBlack,
        textAlignment: .left
    )
    
    public lazy var time30Button = RPSTimeButton(text: "30 сек.")
    public lazy var time60Button = RPSTimeButton(text: "60 сек.")
    
    
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

private extension RPSTimeView {
    func configure() {
        addSubviews(timeLabel,
                    time30Button,
                    time60Button)

        addShadowOnView()
        backgroundColor = backgroundColor
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeLabel.widthAnchor.constraint(equalToConstant: 150),
            
            time30Button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            time30Button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            time30Button.heightAnchor.constraint(equalToConstant: 40),
            time30Button.widthAnchor.constraint(equalToConstant: 140),
            
            time60Button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            time60Button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            time60Button.heightAnchor.constraint(equalToConstant: 40),
            time60Button.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
}
