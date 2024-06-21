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
    private let firstPlayerScaleImage = UIImageView(image: .alien)
    private let secondPlayerScaleImage = UIImageView(image: .wrestler)
    
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
    private lazy var firstPlayerProgressView = UIProgressView(progressColor: .greenLighter, trackColor: .blueLight, rotationAngle: .pi / -2)
    private let scaleMiddleLine = UIImageView(bgColor: .white)
    private lazy var secondPlayerProgressView = UIProgressView(progressColor: .brownBase, trackColor: .blueLight, rotationAngle: .pi / 2)
    
    
    //MARK: - Properties
    
    private var isGamePaused = false
    private var totalScore = 3
    
    private var timer = Timer()
    private var secondPassed = 0
    private var totalTime = 30
    
//    var userScore = 0
//    var computerScore = 0
    
    private lazy var user: Player = Player(character: .wrestler, victories: "0", loses: "0")
    private lazy var computer: Player = Player(character: .alien, victories: "0", loses: "0")
    
    
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
        
        getDataFromStorage()
        
        setupUI()
        setupButtons()
        setupConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.createTimer()
        }
        
        
        
        
    }
    
    
    var userScore = PlayerScore(totalVictories: 0, totalLoses: 0, victories: 0, loses: 0)
    var computerScore = PlayerScore(totalVictories: 0, totalLoses: 0, victories: 0, loses: 0)
}


//MARK: - Internal Methods

private extension GameViewController {
    
    //MARK: - Data Storage
    
    func saveDataToStorage() {
        if let encodedUserScore = try? JSONEncoder().encode(userScore) {
            UserDefaults.standard.set(encodedUserScore, forKey: "UserScore")
        }
        
        if let encodedComputerScore = try? JSONEncoder().encode(computerScore) {
            UserDefaults.standard.set(encodedComputerScore, forKey: "ComputerScore")
        }
    }
    
    
    func getDataFromStorage() {
        if let data = UserDefaults.standard.object(forKey: "UserScore") as? Data,
           let userScore = try? JSONDecoder().decode(PlayerScore.self, from: data) {
            user.victories = String(userScore.victories)
            user.loses = String(userScore.loses)
        }
        
        
        if let data = UserDefaults.standard.object(forKey: "ComputerScore") as? Data,
           let computerScore = try? JSONDecoder().decode(PlayerScore.self, from: data) {
            computer.victories = String(computerScore.victories)
            computer.loses = String(computerScore.loses)
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
            computerScore.victories += 1
            fightLabel.text = "LOSE"
            resetGameField()
            sumTotalScores()
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
        secondPlayerProgressView.progress = Float(computerScore.victories) / Float(totalScore)
    }
    
    
    //MARK: - Play Logic
    
    func play(sign: RPSSign) {
        let computerSign = RPSSign.randomSign()
        let gameState = sign.getGameState(computerSign: computerSign)
        
        updateUI(state: gameState)
        updatePlayerUI(sign: sign)
        updateComputerUI(sign: computerSign)
        
        if gameState == .win {
            userScore.victories += 1
            computerScore.loses += 1
            firstPlayerProgressView.progress = Float(userScore.victories) / Float(totalScore)
            nextStage()
        } else if gameState == .lose {
            computerScore.victories += 1
            userScore.loses += 1
            secondPlayerProgressView.progress = Float(computerScore.victories) / Float(totalScore)
            nextStage()
        } else if gameState == .draw {
            nextStage()
        }
        
        sumTotalScores()
        
        saveDataToStorage()
        
        
        
        print(userScore)
        print(computerScore)
    }
    
    
    func sumTotalScores() {
//        userScore.totalLoses += userScore.loses
//        userScore.totalVictories += userScore.victories
//        computerScore.totalLoses += computerScore.loses
//        computerScore.totalVictories += computerScore.victories
    }
    
    
    func checkResults() {
        if userScore.victories == 3 {
            timer.invalidate()
            goToWinResultsVC()
        } else if computerScore.victories == 3 {
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
        isGamePaused = false
        createTimer()
        fightLabel.text = "FIGHT"
        toggleIsEnabledButtons()
    }
    
    func pauseGame() {
        isGamePaused = true
        timer.invalidate()
        fightLabel.text = "PAUSE"
        toggleIsEnabledButtons()
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    //MARK: - Setup UI
    
    func setupUI() {
        view.addSubviews(gameBackgroundImageView, fightLabel,
                         baseFemaleHand, baseMaleHand,
                         timeProgressScaleView, timeLabel,
                         firstPlayerProgressView, secondPlayerProgressView,
                         scaleMiddleLine, firstPlayerScaleImage, secondPlayerScaleImage,
                         rockButton, paperButton, scissorsButton,
                         fightLoadView)
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
