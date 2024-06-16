//
//  GameViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Properties
    private var isGamePaused = false
    private var totalScore = 3
    
    lazy var user: Player = Player(character: .wrestler, victories: "\(2)", loses: "\(0)")
    lazy var computer: Player = Player(character: .alien, victories: "\(5)", loses: "\(7)")
    
    // MARK: - UI Components?
    private let gameBackgroundImageView = RPSImageView(image: .gameBackground)
    private let fightLabel = RPSTitleLabel(text: "FIGHT",fontSize: 56, color: .yellowDarker)
    private var baseFameleHand = RPSImageView(image: .baseFemaleHand)
    private var baseMaleHand = RPSImageView(image: .baseMaleHand)
    private var timeProgressScaleView = UIProgressView()
    private var timer = Timer()
    private var secondPassed = 0
    private var totalTime = 30
    private let playersResultScale = RPSImageView(frame: .zero)
    private var timeScale = RPSImageView(frame: .zero)
    private var timeLabel = RPSTitleLabel(text: "30",fontSize: 12, color: .white)
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
    
    //MARK: - progress view refactor
    private lazy var firstPlayerProgressView: UIProgressView = {
        let element = UIProgressView()
        element.progress = 0
        element.progressTintColor = UIColor(resource: .greenLighter)
        element.trackTintColor = UIColor(resource: .blueLight)
        element.clipsToBounds = true
        element.transform = CGAffineTransform(rotationAngle: .pi / -2)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondPlayerProgressView: UIProgressView = {
        let element = UIProgressView()
        element.progress = 0
        element.progressTintColor = UIColor(resource: .brownBase)
        element.trackTintColor = UIColor(resource: .blueLight)
        element.clipsToBounds = true
        element.transform = CGAffineTransform(rotationAngle: .pi / 2)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    
    
    
    //MARK: - buttons background - refactor
    
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
            self.setupNavBar(on: self, title: "Game", leftImage: .back, leftSelector: #selector(self.backToMainVC), rightImage: .pause, rightSelector: #selector(self.togglePause))
            self.updateUI(state: .start)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersResultScale.backgroundColor = .blueLight
        timeScale.backgroundColor = .blueLight
        scaleMiddleLine.backgroundColor = .white
        timeProgressScaleView.progress = 0.0
        secondPassed = 0
        
        setupUI()
        setupConstain()
        setupButtons()
        createTimeProgress(timeProgressScaleView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.createTimer()
        }
    }
    
    
    //MARK: - game logic refactor?
    
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
            firstPlayerProgressView.progress = Float(userScore) / Float(totalScore)
        } else if gameState == .lose {
            computerScore += 1
            secondPlayerProgressView.progress = Float(computerScore) / Float(totalScore)
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
    
    //MARK: - actions
    
    @objc private func rockButtonTapped() {
        play(sign: .rock)
    }
    
    
    @objc private func paperButtonTapped() {
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
    
    // pause Game
    @objc private func togglePause() {
         if isGamePaused {
             resumeGame()
         } else {
             pauseGame()
         }
     }
    
    private func resumeGame() {
        isGamePaused = false
        createTimer()
        fightLabel.text = "FIGHT"
        rockButton.isEnabled = true
        paperButton.isEnabled = true
        scissorsButton.isEnabled = true
    }
    
    private func pauseGame() {
        isGamePaused = true
        timer.invalidate()
        fightLabel.text = "PAUSE"
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
    }
    
    
    //MARK: - UI Setup
    private func setupUI() {
        
        view.addSubview(gameBackgroundImageView)
        view.addSubview(fightLabel)
        view.addSubview(baseFameleHand)
        view.addSubview(baseMaleHand)
        view.addSubview(timeProgressScaleView)
        
        view.addSubview(timeLabel)
        view.addSubview(firstPlayerProgressView)
        view.addSubview(secondPlayerProgressView)
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
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
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
            
            timeLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 87),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            timeLabel.widthAnchor.constraint(equalToConstant: 40),
            timeLabel.heightAnchor.constraint(equalToConstant: 14),
            
            scaleMiddleLine.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 155),
            scaleMiddleLine.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scaleMiddleLine.widthAnchor.constraint(equalToConstant: 18),
            scaleMiddleLine.heightAnchor.constraint(equalToConstant: 1),
            
            firstPlayerScaleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            firstPlayerScaleImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            firstPlayerScaleImage.heightAnchor.constraint(equalToConstant: 45),
            
            secondPlayerScaleImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            secondPlayerScaleImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            secondPlayerScaleImage.heightAnchor.constraint(equalToConstant: 45),
            
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
            
            firstPlayerProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 155),
            firstPlayerProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 74),
            firstPlayerProgressView.widthAnchor.constraint(equalToConstant: 150),
            firstPlayerProgressView.heightAnchor.constraint(equalToConstant: 10),
            
            secondPlayerProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 155),
            secondPlayerProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -74),
            secondPlayerProgressView.widthAnchor.constraint(equalToConstant: 150),
            secondPlayerProgressView.heightAnchor.constraint(equalToConstant: 10),
            
            fightLoadView.topAnchor.constraint(equalTo: view.topAnchor),
            fightLoadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fightLoadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fightLoadView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - TimeScaleUI
    
    func createTimeProgress(_ progressView: UIProgressView){
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.0, animated: false)
        progressView.transform = CGAffineTransform(rotationAngle:  -.pi / 2)
        progressView.progressTintColor = .greenLighter
        progressView.trackTintColor = .blueLight
        progressView.progressViewStyle = .bar
        progressView.layer.cornerRadius = 5
        progressView.layer.sublayers?[1].cornerRadius = 5
        progressView.subviews[1].clipsToBounds = true
        progressView.layer.masksToBounds = true
        progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -35).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 166).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    //MARK: - Time
    func createTimer() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimerScale), userInfo: nil, repeats: true)
//        }
    }
    
    @objc func updateTimerScale() {
        if secondPassed < totalTime {
            secondPassed += 1
            
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            
            timeProgressScaleView.progress = percentageProgress
            timeLabel.text = "\(secondPassed/10)\(secondPassed%10)"
            
//            print(secondPassed)
//            print(percentageProgress)
        } else {
            timer.invalidate()
            
        }
        
    }
    
}
