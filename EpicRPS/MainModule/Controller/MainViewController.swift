//
//  MainViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    
    // MARK: - UI
    private lazy var buttonStackView: UIStackView = {
        let element = UIStackView()
        element.distribution = .fillEqually
        element.axis = .vertical
        element.alignment = .center
        element.spacing = 10
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var maleHandImageView: UIImageView = {
        let element = UIImageView()
        element.image = .mainMaleHand
        element.contentMode = .scaleAspectFit
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var femaleHandImageView: UIImageView = {
        let element = UIImageView()
        element.image = .mainFemaleHand
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainTitleLabel = UILabel(textColor: .brownLight)
    private lazy var shadowTitleLabel = UILabel(textColor: .brownDarker)
    
    private lazy var startButton = UIButton(textLabel: "START")
    private lazy var resultButton = UIButton(textLabel: "RESULT")
    
    
    // MARK: - Private methods
    @objc private func startButtonPressed(_ sender: UIButton) {
        print("START")
    }
    
    @objc private func resultButtonPressed(_ sender: UIButton) {
        print("RESULT")
    }
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .greyBase
    }
}
