//
//  GameViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

final class GameViewController: UIViewController {
    
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
        button.setBackgroundImage(.rock, for: .normal)
        return button
    }()
    private var paperButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.paper, for: .normal)
        return button
    }()
    private var scissorsButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.scissors, for: .normal)
        return button
    }()
    
    
    private let fightLoadView = FightLoadView(playerWinScore: 23, playerLoseScore: 1, computerWinScore: 10, computerLoseScore: 2)
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.title = ""
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.title = "Game"
            self.fightLoadView.removeFromSuperview()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Game"
        timeScale.backgroundColor = .blueLight
        playersResultScale.backgroundColor = .blueLight
        scaleMiddleLine.backgroundColor = .white
        timeScale.layer.cornerRadius = 6
        setupUI()
        setupConstain()
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
        view.addSubview(rockButton)
        view.addSubview(paperButton)
        view.addSubview(scissorsButton)
        view.addSubview(fightLoadView)
        
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
            
            baseFameleHand.bottomAnchor.constraint(equalTo: fightLabel.topAnchor,constant: -30),
            baseFameleHand.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 90),
            baseFameleHand.widthAnchor.constraint(equalToConstant: 147),
            baseFameleHand.heightAnchor.constraint(equalToConstant: 423),
            
            baseMaleHand.topAnchor.constraint(equalTo: fightLabel.bottomAnchor,constant: 30),
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
            
            
            
            fightLoadView.topAnchor.constraint(equalTo: view.topAnchor),
            fightLoadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fightLoadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fightLoadView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
        ])
    }
   
    
    
}
