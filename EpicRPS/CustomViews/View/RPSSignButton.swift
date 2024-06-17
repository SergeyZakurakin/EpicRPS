//
//  RPSSignButton.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 17.06.2024.
//

import UIKit

final class RPSSignButton: UIButton {
    
    //MARK: - Lifecycle
    
    init(with image: UIImage) {
        super.init(frame: .zero)
        
        configure(image)
        changeState()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Internal Methods

private extension RPSSignButton {
    func configure(_ image: UIImage) {
        configuration = UIButton.Configuration.plain()
        configuration?.image = image.withRenderingMode(.alwaysTemplate)
        alpha = 0.75
        layer.cornerRadius = 40
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func changeState() {
        self.configurationUpdateHandler = { [weak self] button in
            guard let self = self else { return }
            switch button.state {
            case .highlighted:
                self.backgroundColor = .blueDarker
                self.tintColor = .yellowLighter
                self.addTopInnerShadow()
            default:
                self.backgroundColor = .blueBase
                self.tintColor = .white
                self.removeShadow()
            }
        }
    }
}
