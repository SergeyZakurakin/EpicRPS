//
//  RPSTimeButton.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 26.06.2024.
//

import UIKit

enum ButtonTimeKeys: Int {
    case left = 1
    case right = 2
}


final class RPSTimeButton: UIButton {
    
    //MARK: - Lifecycle
    
    init(text: String) {
        super.init(frame: .zero)
        
        configure(title: text)
        changeState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
  

//MARK: - Internal Methods

private extension RPSTimeButton {
    private func configure(title: String) {
        layer.cornerRadius = 15
        var configuration = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = Font.getFont(.rubickBlack, size: 16)
        configuration.attributedTitle = AttributedString(title, attributes: container)
        configuration.baseBackgroundColor = .brownBase
        self.configuration = configuration
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func changeState() {
        self.configurationUpdateHandler = { [weak self] button in
            guard let self = self else { return }
            switch button.state {
            case .highlighted:
                self.backgroundColor = .greyDarker
                self.tintColor = .white
            default:
                self.backgroundColor = .brownBase
                self.tintColor = .white
            }
        }
    }
}
