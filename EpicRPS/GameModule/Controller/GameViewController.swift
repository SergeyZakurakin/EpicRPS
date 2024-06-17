//
//  GameViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

enum RPSButton: Int {
    case rock = 1
    case paper = 2
    case scissors = 3
}


final class GameViewController: UIViewController {
    
    // MARK: - UI
    
    //Preload View
    private lazy var fightLoadView = FightLoadView(user: user, computer: computer)
    
    private let gameBackgroundImageView = UIImageView(image: .gameBackground)
    private let fightLabel = UILabel(text: "FIGHT",fontSize: 56, color: .yellowDarker)
    
    //Hands
    private var baseFemaleHand = UIImageView(image: .baseFemaleHand)
    private var baseMaleHand = UIImageView(image: .baseMaleHand)
    
    //Player Images
    private let firstPlayerScaleImage = UIImageView(image: .alien)
    private let secondPlayerScaleImage = UIImageView(image: .wrestler)
    
    //Buttons
    private lazy var rockButton = RPSSignButton(image: .rockBtn)
    private lazy var paperButton = RPSSignButton(image: .paperBtn)
    private lazy var scissorsButton = RPSSignButton(image: .scissorsBtn)
    
    //ProgressViews
    private var timeProgressScaleView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.0, animated: false)
        progressView.progress = 0.0
        progressView.transform = CGAffineTransform(rotationAngle:  -.pi / 2)
        progressView.progressTintColor = .greenLighter
        progressView.trackTintColor = .blueLight
        progressView.progressViewStyle = .bar
        progressView.layer.cornerRadius = 5
        progressView.layer.sublayers?[1].cornerRadius = 5
        progressView.subviews[1].clipsToBounds = true
        progressView.layer.masksToBounds = true
        return progressView
    }()
    
    private var timeLabel = UILabel(text: "0",fontSize: 12, color: .white)
    private lazy var firstPlayerProgressView = UIProgressView(progressColor: .greenLighter, trackColor: .blueLight, rotationAngle: .pi / -2)
    private let scaleMiddleLine = UIImageView(bgColor: .white)
    private lazy var secondPlayerProgressView = UIProgressView(progressColor: .brownBase, trackColor: .blueLight, rotationAngle: .pi / 2)
    
    
    //MARK: - Properties
    
    private var isGamePaused = false
    private var totalScore = 3
    
    private var timer = Timer()
    private var secondPassed = 0
    private var totalTime = 30
    
    var userScore = 0
    var computerScore = 0
    
    lazy var user: Player = Player(character: .wrestler, victories: "\(2)", loses: "\(0)")
    lazy var computer: Player = Player(character: .alien, victories: "\(5)", loses: "\(7)")
    
    
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
        
        setupUI()
        setupButtons()
        setupConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.createTimer()
        }
    }
}


//extension GameViewController {
//    // change color state change button to private
//    func buttonDidTapped() {
//        if rockButton.button.isTouchInside {
//            rockButton.button.tintColor = .yellowLighter
//            rockButton.backgroundColor = .blueDarker
//
//            paperButton.button.tintColor = .white
//            paperButton.backgroundColor = .blueBase
//            scissorsButton.button.tintColor = .white
//            scissorsButton.backgroundColor = .blueBase
//            play(sign: .rock)
//        } else if paperButton.button.isTouchInside {
//            paperButton.button.tintColor = .yellowLighter
//            paperButton.backgroundColor = .blueDarker
//
//            rockButton.button.tintColor = .white
//            rockButton.backgroundColor = .blueBase
//            scissorsButton.button.tintColor = .white
//            scissorsButton.backgroundColor = .blueBase
//            play(sign: .paper)
//        } else {
//            play(sign: .scissors)
//            scissorsButton.button.tintColor = .yellowLighter
//            scissorsButton.backgroundColor = .blueDarker
//
//            rockButton.button.tintColor = .white
//            rockButton.backgroundColor = .blueBase
//            paperButton.button.tintColor = .white
//            paperButton.backgroundColor = .blueBase
//        }
//    }

//Do not work
//    func buttonDidTapped() {
//        if rockButton.isActive {
//
//            play(sign: .rock)
//            rockButton.isActive = false
//        } else if paperButton.isActive == true {
//            play(sign: .paper)
//            rockButton.isActive = false
//        } else if scissorsButton.isActive == true {
//            play(sign: .scissors)
//            rockButton.isActive = false
//        }
//    }
//}


//MARK: - Internal Methods

private extension GameViewController {
    
    //MARK: - Buttons
    
    func setupButtons() {
        rockButton.tag = RPSButton.rock.rawValue
        paperButton.tag = RPSButton.paper.rawValue
        scissorsButton.tag = RPSButton.scissors.rawValue

        rockButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        paperButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        scissorsButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
    }
    
    
    @objc func buttonHandler(_ button: UIButton) {
        switch RPSButton(rawValue: button.tag) {
        case .rock:
            play(sign: .rock)
        case .paper:
            play(sign: .paper)
        case .scissors:
            play(sign: .scissors)
        default:
            return
        }
    }
    
    
    //MARK: - Update UI Logic
    
    func updateUI(state: GameState) {
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
    
    
    func updatePlayerUI(sign: RPSSign) {
        switch sign {
        case .rock:
            baseMaleHand.image = .rockMaleHand
        case .paper:
            baseMaleHand.image = .paperMaleHand
        case .scissors:
            baseMaleHand.image = .scissorsMaleHand
        }
    }
    
    
    func updateComputerUI(sign: RPSSign) {
        switch sign {
        case .rock:
            baseFemaleHand.image = .rockFemaleHand
        case .paper:
            baseFemaleHand.image = .paperFemaleHand
        case .scissors:
            baseFemaleHand.image = .scissorsFemaleHand
        }
    }
    
    
    //MARK: - Play Logic
    
    func play(sign: RPSSign) {
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
    
    
    //MARK: - Timer
    
    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerScale), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimerScale() {
        if secondPassed < totalTime {
            secondPassed += 1
            
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            
            timeProgressScaleView.progress = percentageProgress
            timeLabel.text = "\(secondPassed/10)\(secondPassed%10)"
            
        } else if totalTime == 30 {
            timer.invalidate()
            timeLabel.text = "\(0)"
            computerScore += 1
            timeProgressScaleView.progress = 0
            secondPlayerProgressView.progress = Float(computerScore) / Float(totalScore)
        } else {
            timer.invalidate()
        }
    }
    
    
    //MARK: - Pause Logic
    
    @objc  func togglePause() {
        if isGamePaused {
            resumeGame()
        } else {
            pauseGame()
        }
    }
    
    func resumeGame() {
        isGamePaused = false
        createTimer()
        fightLabel.text = "FIGHT"
        rockButton.isEnabled = true
        paperButton.isEnabled = true
        scissorsButton.isEnabled = true
    }
    
    func pauseGame() {
        isGamePaused = true
        timer.invalidate()
        fightLabel.text = "PAUSE"
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
    }
    
    
    //MARK: - Navigation
    
    func goToWinResultsVC() {
        let resultsVC = FightResultsViewController()
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    func goToLoseResultsVC() {
        let resultsVC = FightLooseResultsViewController()
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    
    @objc  func backToMainVC() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    
    //MARK: - Setup UI
    
    func setupUI() {
        view.addSubview(gameBackgroundImageView)
        view.addSubview(fightLabel)
        view.addSubview(baseFemaleHand)
        view.addSubview(baseMaleHand)
        view.addSubview(timeProgressScaleView)
        view.addSubview(timeLabel)
        view.addSubview(firstPlayerProgressView)
        view.addSubview(secondPlayerProgressView)
        view.addSubview(scaleMiddleLine)
        view.addSubview(firstPlayerScaleImage)
        view.addSubview(secondPlayerScaleImage)
        view.addSubview(rockButton)
        view.addSubview(paperButton)
        view.addSubview(scissorsButton)
        view.addSubview(fightLoadView)
        
        fightLoadView.configureView(with: user, and: computer)
    }
    
    
    //MARK: - Constraints
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gameBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            gameBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameBackgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            fightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fightLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            baseFemaleHand.bottomAnchor.constraint(equalTo: fightLabel.topAnchor,constant: -40),
            baseFemaleHand.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 90),
            baseFemaleHand.widthAnchor.constraint(equalToConstant: 147),
            baseFemaleHand.heightAnchor.constraint(equalToConstant: 423),
            
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
            
            rockButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 702),
            rockButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 57),
            rockButton.widthAnchor.constraint(equalToConstant: 80),
            rockButton.heightAnchor.constraint(equalToConstant: 80),
            
            paperButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 652),
            paperButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paperButton.widthAnchor.constraint(equalToConstant: 80),
            paperButton.heightAnchor.constraint(equalToConstant: 80),
            
            scissorsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 702),
            scissorsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 249),
            scissorsButton.widthAnchor.constraint(equalToConstant: 80),
            scissorsButton.heightAnchor.constraint(equalToConstant: 80),
            
            timeProgressScaleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timeProgressScaleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -35),
            timeProgressScaleView.widthAnchor.constraint(equalToConstant: 166),
            timeProgressScaleView.heightAnchor.constraint(equalToConstant: 10),
            
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
}
