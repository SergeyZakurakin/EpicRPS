//
//  RPSTimeView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 26.06.2024.
//

import UIKit

final class RPSSettingsView: UIView {
    
    //MARK: - Music UI
    
    private let musicBackgroundView = UIView(backgroundColor: .brownBase)
    private let musicLabel = UILabel(text: "Фоновая музыка",
                                     font: .poppinsBlack,
                                     fontSize: 16,
                                     color: .white,
                                     textAlignment: .left)
    private lazy var changeMusicPickerView: UIPickerView = {
       let pckr = UIPickerView()
        pckr.layer.name = "Мелодия"
        pckr.translatesAutoresizingMaskIntoConstraints = false
        return pckr
    }()
    
    
    //MARK: - Switcher UI
    
    private let switchBackgroundView = UIView(backgroundColor: .brownBase)
    private let switchLabel = UILabel(text: "Игра с другом",
                                     font: .poppinsBlack,
                                     fontSize: 16,
                                     color: .white,
                                     textAlignment: .left)
    private lazy var switchView: UISwitch = {
       let swtchr = UISwitch()
        swtchr.isOn = false
        swtchr.translatesAutoresizingMaskIntoConstraints = false
        return swtchr
    }()
    
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

private extension RPSSettingsView {
    func configure() {
        addSubviews(musicBackgroundView,
                    musicLabel,
                    changeMusicPickerView,
                    switchBackgroundView,
                    switchLabel,
                    switchView)

        addShadowOnView()
        backgroundColor = backgroundColor
        layer.borderWidth = 1
        layer.cornerRadius = 20
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            musicBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            musicBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            musicBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            musicBackgroundView.heightAnchor.constraint(equalToConstant: 50),
            
            musicLabel.topAnchor.constraint(equalTo: musicBackgroundView.topAnchor, constant: 10),
            musicLabel.leadingAnchor.constraint(equalTo: musicBackgroundView.leadingAnchor, constant: 15),
            musicLabel.bottomAnchor.constraint(equalTo: musicBackgroundView.bottomAnchor, constant: -10),
            musicLabel.widthAnchor.constraint(equalToConstant: 150),
            
            changeMusicPickerView.topAnchor.constraint(equalTo: musicBackgroundView.topAnchor, constant: 10),
            changeMusicPickerView.trailingAnchor.constraint(equalTo: musicBackgroundView.trailingAnchor, constant: -15),
            changeMusicPickerView.bottomAnchor.constraint(equalTo: musicBackgroundView.bottomAnchor, constant: -10),
            changeMusicPickerView.widthAnchor.constraint(equalToConstant: 90),

            switchBackgroundView.topAnchor.constraint(equalTo: musicBackgroundView.bottomAnchor, constant: 20),
            switchBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            switchBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            switchBackgroundView.heightAnchor.constraint(equalToConstant: 50),

            switchLabel.topAnchor.constraint(equalTo: switchBackgroundView.topAnchor, constant: 10),
            switchLabel.leadingAnchor.constraint(equalTo: switchBackgroundView.leadingAnchor, constant: 15),
            switchLabel.bottomAnchor.constraint(equalTo: switchBackgroundView.bottomAnchor, constant: -10),
            switchLabel.widthAnchor.constraint(equalToConstant: 150),
            
            switchView.topAnchor.constraint(equalTo: switchBackgroundView.topAnchor, constant: 10),
            switchView.trailingAnchor.constraint(equalTo: switchBackgroundView.trailingAnchor, constant: -15),
            switchView.bottomAnchor.constraint(equalTo: switchBackgroundView.bottomAnchor, constant: -10),
        ])
    }
}
