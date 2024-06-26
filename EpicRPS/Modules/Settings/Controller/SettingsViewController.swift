//
//  SettingsViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 26.06.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - UI
    
    private let timeView = RPSTimeView()
    private let settingsView = RPSSettingsView()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupButtons()
        setConstraints()
        setupNavBar(on: self, title: "SETTINGS", leftImage: .back, leftSelector: #selector(backButtonDidTap), rightImage: nil, rightSelector: nil)
    }
}


//MARK: - Internal Methods

private extension SettingsViewController {
    
    //MARK: - Action
    
    @objc func buttonHandler(_ button: UIButton) {
        switch ButtonTimeKeys(rawValue: button.tag) {
        case .left:
            print("30")
        case .right:
            print("60")
        default:
            break
        }
    }
    
    
    @objc func backButtonDidTap() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    //MARK: - Setup UI
    
    func configure() {
        title = "SETTINGS"
        view.backgroundColor = .white
        view.addSubviews(timeView,
                         settingsView)
    }
    
    
    func setupButtons() {
        timeView.time30Button.tag = ButtonTimeKeys.left.rawValue
        timeView.time60Button.tag = ButtonTimeKeys.right.rawValue
        
        timeView.time30Button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        timeView.time60Button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            timeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            timeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timeView.heightAnchor.constraint(equalToConstant: 130),
        
            settingsView.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 20),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsView.heightAnchor.constraint(equalToConstant: 165)
        ])
    }
}
