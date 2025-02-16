//
//  GameViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

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
    private let userScaleImage = RPSImageView(frame: .zero)
    private let computerScaleImage = RPSImageView(frame: .zero)
    
    //Buttons
    private lazy var rockButton = RPSSignButton(with: .rockBtn)
    private lazy var paperButton = RPSSignButton(with: .paperBtn)
    private lazy var scissorsButton = RPSSignButton(with: .scissorsBtn)
    
    //ProgressView Timer
    private var timeProgressScaleView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.0, animated: true)
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
    
    private var timeLabel = UILabel(text: "0:00",fontSize: 12, color: .white)
    
    //ProgressView Players Counter
    private lazy var userProgressView = UIProgressView(progressColor: .greenLighter, trackColor: .blueLight, rotationAngle: .pi / -2)
    private let scaleMiddleLine = UIImageView(bgColor: .white)
    private lazy var computerProgressView = UIProgressView(progressColor: .brownBase, trackColor: .blueLight, rotationAngle: .pi / 2)
    
    
    //MARK: - Properties
    
    private var isGamePaused = false
    private var totalScore = 3
    
    private var timer = Timer()
    private var secondPassed = 0
    private let totalTime = 30
    
    private var user: Player = Player(
        avatarName: "",
        victories: 0,
        loses: 0,
        score: 0
    )
    
    private var computer: Player = Player(
        avatarName: "",
        victories: 0,
        loses: 0,
        score: 0
    )
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.title = ""
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.fightLoadView.removeFromSuperview()
            self.setupNavBar(on: self, title: "Game", leftImage: .back, leftSelector: #selector(self.backToMainVC), rightImage: .pause, rightSelector: #selector(self.togglePause))
            self.updateUI(state: .start)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlayerDataFromStorage(user: user, computer: computer)
        updatePlayerDataByScore()
        
        
        setupUI()
        setupButtons()
        setupConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.createTimer()
        }
    }
}


//MARK: - Internal Methods

private extension GameViewController {
    
    //MARK: - Data Storage
    
    func getPlayerDataFromStorage(user: Player, computer: Player) {
        let userVictoryData = UserDefaults.standard.integer(forKey: "UserVictory")
        let userLoseData = UserDefaults.standard.integer(forKey: "UserLose")
        let computerVictoryData = UserDefaults.standard.integer(forKey: "ComputerVictory")
        let computerLoseData = UserDefaults.standard.integer(forKey: "ComputerLose")
        
        self.user = Player(avatarName: "lightning", victories: userVictoryData, loses: userLoseData, score: 0)
        self.computer = Player(avatarName: "alien", victories: computerVictoryData, loses: computerLoseData, score: 0)
    }
    
    
    func updatePlayerDataByScore() {
        let userScore = UserDefaults.standard.integer(forKey: "UserScore")
        let computerScore = UserDefaults.standard.integer(forKey: "ComputerScore")

        if userScore == 3 {
            user.victories += 1
            computer.loses += 1
            UserDefaults.standard.setValue(user.victories, forKey: "UserVictory")
            UserDefaults.standard.setValue(computer.loses, forKey: "ComputerLose")
        } else if computerScore == 3 {
            user.loses += 1
            computer.victories += 1
            UserDefaults.standard.setValue(computer.victories, forKey: "ComputerVictory")
            UserDefaults.standard.setValue(user.loses, forKey: "UserLose")
        }
    }
    
    
    //MARK: - Action
    
    @objc func buttonHandler(_ button: UIButton) {
        switch RPSSign(rawValue: button.tag) {
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
    
    
    func resetGameField() {
        toggleIsEnabledButtons()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
            guard let self = self else { return }
            self.fightLabel.text = "FIGHT"
            self.baseMaleHand.image = .baseMaleHand
            self.baseFemaleHand.image = .baseFemaleHand
            toggleIsEnabledButtons()
        }
    }
    
    
    func toggleIsEnabledButtons() {
        rockButton.isEnabled.toggle()
        paperButton.isEnabled.toggle()
        scissorsButton.isEnabled.toggle()
    }
    
    
    //MARK: - Timer
    
    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerScale), userInfo: nil, repeats: true)
    }

    
    @objc func updateTimerScale() {
        updateTimer()
    }
    

    func increaseTimerProgress() {
        let percentageProgress = Float(secondPassed) / Float(totalTime)
        timeProgressScaleView.progress = percentageProgress
        timeLabel.text = "0:\(secondPassed/10)\(secondPassed%10)"
    }

    
    func updateTimer() {
        if secondPassed + 1 <= totalTime {
            secondPassed += 1
            increaseTimerProgress()
        } else if totalTime == 30 {
            computer.score += 1
            fightLabel.text = "LOSE"
            resetGameField()
            checkResults()
            resetTimer()
        } else {
            timer.invalidate()
        }
    }
    
    
    func resetTimer() {
        timer.invalidate()
        secondPassed = 0
        resetTimerProgress()
        createTimer()
        updateTimer()
    }
    
    
    func resetTimerProgress() {
        timeProgressScaleView.setProgress(0.15, animated: true)
        computerProgressView.progress = Float(computer.score) / Float(totalScore)
    }
    
    
    //MARK: - Play Logic
    
    func play(sign: RPSSign) {
        let computerSign = RPSSign.randomSign()
        let gameState = sign.getGameState(computerSign: computerSign)
        
        updateUI(state: gameState)
        updatePlayerUI(sign: sign)
        updateComputerUI(sign: computerSign)
        
        if gameState == .win {
            user.score += 1
            userProgressView.progress = Float(user.score) / Float(totalScore)
            nextStage()
        } else if gameState == .lose {
            computer.score += 1
            computerProgressView.progress = Float(computer.score) / Float(totalScore)
            nextStage()
        } else if gameState == .draw {
            nextStage()
        }
        
        print(user)
        print(computer)
    }
    
    
    func checkResults() {
        if user.score == 3 {
            timer.invalidate()
            goToWinResultsVC()
        } else if computer.score == 3 {
            timer.invalidate()
            goToLoseResultsVC()
        }
    }
    
    
    func nextStage() {
        resetGameField()
        resetTimer()
        checkResults()
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
        isGamePaused.toggle()
        createTimer()
        fightLabel.text = "FIGHT"
        toggleIsEnabledButtons()
    }
    
    func pauseGame() {
        isGamePaused.toggle()
        timer.invalidate()
        fightLabel.text = "PAUSE"
        toggleIsEnabledButtons()
    }
    
    
    //MARK: - Navigation
    
    func goToWinResultsVC() {
        let resultsVC = FightResultsController(firstPlayer: user, secondPlayer: computer, gameState: .win)
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    
    func goToLoseResultsVC() {
        let resultsVC = FightResultsController(firstPlayer: computer, secondPlayer: user, gameState: .lose)
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    
    @objc  func backToMainVC() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    //MARK: - Setup UI
    
    func setupUI() {
        view.addSubviews(gameBackgroundImageView, fightLabel,
                         baseFemaleHand, baseMaleHand,
                         timeProgressScaleView, timeLabel,
                         userProgressView, computerProgressView,
                         scaleMiddleLine, computerScaleImage, userScaleImage,
                         rockButton, paperButton, scissorsButton,
                         fightLoadView)
        
        userScaleImage.image = user.avatar
        computerScaleImage.image = computer.avatar
    }
    
    
    func setupButtons() {
        rockButton.tag = RPSSign.rock.rawValue
        paperButton.tag = RPSSign.paper.rawValue
        scissorsButton.tag = RPSSign.scissors.rawValue

        rockButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        paperButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        scissorsButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
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
            
            computerProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 155),
            computerProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -74),
            computerProgressView.widthAnchor.constraint(equalToConstant: 150),
            computerProgressView.heightAnchor.constraint(equalToConstant: 10),
            
            computerScaleImage.centerXAnchor.constraint(equalTo: computerProgressView.centerXAnchor),
            computerScaleImage.bottomAnchor.constraint(equalTo: computerProgressView.topAnchor, constant: -60),
            computerScaleImage.heightAnchor.constraint(equalToConstant: 45),
            computerScaleImage.widthAnchor.constraint(equalToConstant: 45),
            
            userProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 155),
            userProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 74),
            userProgressView.widthAnchor.constraint(equalToConstant: 150),
            userProgressView.heightAnchor.constraint(equalToConstant: 10),
            
            userScaleImage.centerXAnchor.constraint(equalTo: userProgressView.centerXAnchor),
            userScaleImage.topAnchor.constraint(equalTo: userProgressView.bottomAnchor, constant: 60),
            userScaleImage.heightAnchor.constraint(equalToConstant: 45),
            userScaleImage.widthAnchor.constraint(equalToConstant: 45),

            
            fightLoadView.topAnchor.constraint(equalTo: view.topAnchor),
            fightLoadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fightLoadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fightLoadView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
