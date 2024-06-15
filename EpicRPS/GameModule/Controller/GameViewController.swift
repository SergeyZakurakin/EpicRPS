//
//  GameViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Properties
    
    lazy var user: Player = Player(character: .wrestler, victories: "\(2)", loses: "\(0)")
    lazy var computer: Player = Player(character: .alien, victories: "\(5)", loses: "\(7)")
    

    // MARK: - UI Components
    private let gameBackgroundImageView = RPSImageView(image: .gameBackground)
    private let fightLabel = RPSTitleLabel(text: "FIGHT",fontSize: 56, color: .yellowDarker)
    private var baseFameleHand = RPSImageView(image: .baseFemaleHand)
    private var baseMaleHand = RPSImageView(image: .baseMaleHand)
    private var timeScale = RPSImageView(frame: .zero)
    private var timeLabel = RPSTitleLabel(text: "0:30",fontSize: 12, color: .white)
    private let playersResultScale = RPSImageView(frame: .zero)
    private let scaleMiddleLine = RPSImageView(frame: .zero)
    private let firstPlayerScaleImage = RPSImageView(image: .alien)
    private let secondPlayerScaleImage = RPSImageView(image: .wrestler)
    private var rockButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.rockBtn.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        return button
    }()
    private var paperButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.paperBtn.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        return button
    }()
    private var scissorsButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.scissorsBtn.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var fightLoadView = FightLoadView(user: user, computer: computer)

    
    //MARK: - buttons
    
    private let rockBtnBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .blueBase
        view.alpha = 0.75
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let paperBtnBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .blueBase
        view.alpha = 0.75
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let scissorsBtnBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .blueBase
        view.alpha = 0.75
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.title = ""
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.fightLoadView.removeFromSuperview()
            self.setupNavBar(on: self, title: "Game", leftImage: .back, leftSelector: #selector(self.backToMainVC), rightImage: .pause, rightSelector: nil)
            self.updateUI(state: .start)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeScale.backgroundColor = .blueLight
        playersResultScale.backgroundColor = .blueLight
        scaleMiddleLine.backgroundColor = .white
        timeScale.layer.cornerRadius = 6
        setupUI()
        setupConstain()
        setupButtons()
    }
    
    
    //MARK: - game logic
    
    private func updateUI(state: GameState) {
        switch state {
        case .start:
            fightLabel.text = "FIGHT"
        case .win:
            fightLabel.text = "WIN"
        case .lose:
            fightLabel.text = "LOSE"
        case .draw:
            fightLabel.text = "DRAW"
        }
    }
    
    
    private func updatePlayerUI(sign: RPSSign) {
        switch sign {
        case .rock:
            baseMaleHand.image = .rockMaleHand
        case .paper:
            baseMaleHand.image = .paperMaleHand
        case .scissors:
            baseMaleHand.image = .scissorsMaleHand
        }
    }
    
    
    private func updateComputerUI(sign: RPSSign) {
        switch sign {
        case .rock:
            baseFameleHand.image = .rockFemaleHand
        case .paper:
            baseFameleHand.image = .paperFemaleHand
        case .scissors:
            baseFameleHand.image = .scissorsFemaleHand
        }
    }
    
    var userScore = 0
    var computerScore = 0
    
    private func play(sign: RPSSign) {
        let computerSign = RPSSign.randomSign()
        let gameState = sign.getGameState(computerSign: computerSign)
        
        updateUI(state: gameState)
        updatePlayerUI(sign: sign)
        updateComputerUI(sign: computerSign)
        
        if gameState == .win {
            userScore += 1
        } else if gameState == .lose {
            computerScore += 1
        }
        
        //update progress view counter
        if userScore == 3 {
            goToWinResultsVC()
        } else if computerScore == 3 {
            goToLoseResultsVC()
        }
        
        print(sign, userScore)
        print(computerSign, computerScore)
    }
    
    
    private func goToWinResultsVC() {
        let resultsVC = FightResultsViewController()
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    
    private func goToLoseResultsVC() {
        let resultsVC = FightLooseResultsViewController()
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    
    private func updateScoreProgressView() {
        
    }
    
    
    //MARK: - actions
    
    @objc private func rockButtonTapped() {
        rockButton.tintColor = .yellowLighter
        rockBtnBackground.backgroundColor = .blueDarker
        rockBtnBackground.addTopInnerShadow()
        
        play(sign: .rock)
    }
    
    
    @objc private func paperButtonTapped() {
        paperBtnBackground.addTopInnerShadow()
        play(sign: .paper)
    }
    
    
    @objc private func scissorsButtonTapped() {
        play(sign: .scissors)
    }
    
    
    private func setupButtons() {
        rockButton.addTarget(self, action: #selector(rockButtonTapped), for: .touchUpInside)
        paperButton.addTarget(self, action: #selector(paperButtonTapped), for: .touchUpInside)
        scissorsButton.addTarget(self, action: #selector(scissorsButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func backToMainVC() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    
    //MARK: - UI Setup
    private func setupUI() {
        
        view.addSubview(gameBackgroundImageView)
        view.addSubview(fightLabel)
        view.addSubview(baseFameleHand)
        view.addSubview(baseMaleHand)
        view.addSubview(timeScale)
        view.addSubview(timeLabel)
        view.addSubview(playersResultScale)
        view.addSubview(scaleMiddleLine)
        view.addSubview(firstPlayerScaleImage)
        view.addSubview(secondPlayerScaleImage)
        view.addSubview(rockBtnBackground)
        rockBtnBackground.addSubview(rockButton)
        view.addSubview(paperBtnBackground)
        paperBtnBackground.addSubview(paperButton)
        view.addSubview(scissorsBtnBackground)
        scissorsBtnBackground.addSubview(scissorsButton)
        view.addSubview(fightLoadView)
        
        fightLoadView.configureView(with: user, and: computer)
        
        gameBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        fightLabel.translatesAutoresizingMaskIntoConstraints = false
        baseFameleHand.translatesAutoresizingMaskIntoConstraints = false
        baseMaleHand.translatesAutoresizingMaskIntoConstraints = false
        timeScale.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        playersResultScale.translatesAutoresizingMaskIntoConstraints = false
        scaleMiddleLine.translatesAutoresizingMaskIntoConstraints = false
        firstPlayerScaleImage.translatesAutoresizingMaskIntoConstraints = false
        secondPlayerScaleImage.translatesAutoresizingMaskIntoConstraints = false
        rockButton.translatesAutoresizingMaskIntoConstraints = false
        paperButton.translatesAutoresizingMaskIntoConstraints = false
        scissorsButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupConstain() {
        NSLayoutConstraint.activate([
            gameBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            gameBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameBackgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            fightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fightLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            baseFameleHand.bottomAnchor.constraint(equalTo: fightLabel.topAnchor,constant: -40),
            baseFameleHand.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 90),
            baseFameleHand.widthAnchor.constraint(equalToConstant: 147),
            baseFameleHand.heightAnchor.constraint(equalToConstant: 423),
            
            baseMaleHand.topAnchor.constraint(equalTo: fightLabel.bottomAnchor,constant: 40),
            baseMaleHand.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 142),
            baseMaleHand.widthAnchor.constraint(equalToConstant: 155),
            baseMaleHand.heightAnchor.constraint(equalToConstant: 423),
            
            timeScale.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timeScale.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            timeScale.widthAnchor.constraint(equalToConstant: 10),
            timeScale.heightAnchor.constraint(equalToConstant: 166),
            
            timeLabel.topAnchor.constraint(equalTo: timeScale.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            timeLabel.widthAnchor.constraint(equalToConstant: 27),
            timeLabel.heightAnchor.constraint(equalToConstant: 14),
            
            playersResultScale.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playersResultScale.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 351),
            playersResultScale.widthAnchor.constraint(equalToConstant: 10),
            playersResultScale.heightAnchor.constraint(equalToConstant: 295),
            
            scaleMiddleLine.topAnchor.constraint(equalTo: playersResultScale.topAnchor, constant: 147),
            scaleMiddleLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 346),
            scaleMiddleLine.widthAnchor.constraint(equalToConstant: 18),
            scaleMiddleLine.heightAnchor.constraint(equalToConstant: 1),
            
            firstPlayerScaleImage.topAnchor.constraint(equalTo: playersResultScale.topAnchor, constant: -21),
            firstPlayerScaleImage.centerXAnchor.constraint(equalTo: playersResultScale.centerXAnchor),
            firstPlayerScaleImage.widthAnchor.constraint(equalToConstant: 36),
            firstPlayerScaleImage.heightAnchor.constraint(equalToConstant: 42),
            
            secondPlayerScaleImage.topAnchor.constraint(equalTo: playersResultScale.bottomAnchor, constant: -21),
            secondPlayerScaleImage.centerXAnchor.constraint(equalTo: playersResultScale.centerXAnchor),
            secondPlayerScaleImage.widthAnchor.constraint(equalToConstant: 36),
            secondPlayerScaleImage.heightAnchor.constraint(equalToConstant: 42),
            
            rockBtnBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 702),
            rockBtnBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 57),
            rockBtnBackground.widthAnchor.constraint(equalToConstant: 80),
            rockBtnBackground.heightAnchor.constraint(equalToConstant: 80),
            
            rockButton.centerXAnchor.constraint(equalTo: rockBtnBackground.centerXAnchor),
            rockButton.centerYAnchor.constraint(equalTo: rockBtnBackground.centerYAnchor),
            
            
            paperBtnBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 652),
            paperBtnBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paperBtnBackground.widthAnchor.constraint(equalToConstant: 80),
            paperBtnBackground.heightAnchor.constraint(equalToConstant: 80),
            
            
            paperButton.centerXAnchor.constraint(equalTo: paperBtnBackground.centerXAnchor),
            paperButton.centerYAnchor.constraint(equalTo: paperBtnBackground.centerYAnchor),
            
            scissorsBtnBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 702),
            scissorsBtnBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 249),
            scissorsBtnBackground.widthAnchor.constraint(equalToConstant: 80),
            scissorsBtnBackground.heightAnchor.constraint(equalToConstant: 80),
            
            scissorsButton.centerXAnchor.constraint(equalTo: scissorsBtnBackground.centerXAnchor),
            scissorsButton.centerYAnchor.constraint(equalTo: scissorsBtnBackground.centerYAnchor),
            
            
            fightLoadView.topAnchor.constraint(equalTo: view.topAnchor),
            fightLoadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fightLoadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fightLoadView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
