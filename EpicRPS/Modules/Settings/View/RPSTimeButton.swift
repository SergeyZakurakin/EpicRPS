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
        
        setTitle(text, for: .normal)
        configure()
        changeState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
  

//MARK: - Internal Methods

private extension RPSTimeButton {
    private func configure() {
        backgroundColor = .brownBase
        layer.cornerRadius = 15
        setTitleColor(.white, for: .normal)
        configuration = UIButton.Configuration.plain()
//        titleLabel?.font = Font.getFont(.rubickBlack, size: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func changeState() {
        self.configurationUpdateHandler = { [weak self] button in
            guard let self = self else { return }
            switch button.state {
            case .highlighted:
                self.backgroundColor = .greyDarker
            default:
                self.backgroundColor = .brownBase
            }
        }
    }
}
