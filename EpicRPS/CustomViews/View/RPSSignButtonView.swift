//
//  RPSSignButtonView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 17.06.2024.
//

import UIKit

protocol RPSSignButtonProtocol: AnyObject {
    func buttonDidTapped()
}


final class RPSSignButtonView: UIView {
    
    //MARK: - UI
    
    public let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    //MARK: - Properties
    
    weak var delegate: RPSSignButtonProtocol?
    
    public var isActive: Bool = true {
        didSet {
            if button.isTouchInside {
                backgroundColor = .blueDarker
                button.tintColor = .yellowLighter
            } else {
                backgroundColor = .blueBase
                button.tintColor = .white
            }
        }
    }
        
        
    //MARK: - Lifecycle
    
    init(image btnImage: UIImage) {
        super.init(frame: .zero)
        
        button.setBackgroundImage(btnImage.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        
        configure()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonHandler() {
        delegate?.buttonDidTapped()
    }
}


//MARK: - Internal Methods

private extension RPSSignButtonView {
    func configure() {
        addSubview(button)
        backgroundColor = .blueBase
        alpha = 0.75
        layer.cornerRadius = 40
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
