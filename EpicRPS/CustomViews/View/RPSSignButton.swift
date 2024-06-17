//
//  RPSSignButton.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 17.06.2024.
//

import UIKit

final class RPSSignButton: UIButton {
    
    //MARK: - Lifecycle
    
    init(image btnImage: UIImage) {
        super.init(frame: .zero)
        
        setImage(btnImage.withRenderingMode(.alwaysTemplate), for: .normal)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Internal Methods

private extension RPSSignButton {
    func configure() {
        tintColor = .white
        backgroundColor = .blueBase
        alpha = 0.75
        layer.cornerRadius = 40
        translatesAutoresizingMaskIntoConstraints = false
    }
}
