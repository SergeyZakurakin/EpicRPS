//
//  RulesViewController.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

final class RulesViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var rulesLabelArray: [UILabel] = []
    private var rulesIndexBtnArray: [UIButton] = []
    private let rulesTextArray = [
        "Игра проводится между игроком и компьютером",
        "Жесты:",
        "Кулак > Ножницы",
        "Бумага > Кулак",
        "Ножницы > Бумага",
        "У игрока есть 30 сек. для выбора жеста",
        "Игра ведётся до трёх побед одного из участников.",
        "За каждую победу игрок получает 500 баллов, которые можно посмотреть на доске лидеров."
    ]
    
    private lazy var gestureRockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.rock, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var gesturePaperButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.paper, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var gestureScissorsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.scissors, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "RULES"
        updateUI()
        setConstraints()
    }
    private func updateUI() {
        view.addSubview(gestureRockButton)
        view.addSubview(gesturePaperButton)
        view.addSubview(gestureScissorsButton)
        for i in 0...rulesTextArray.count - 1 {
            if (i + 1 == 8) {
                createRuleLabel(index: i, text: rulesTextArray[i], twoColored: true, textToColor: "500 баллов")
            }
                else {
                createRuleLabel(index: i, text: rulesTextArray[i], twoColored: false, textToColor: "")
            }
            if i < 5 {
                createRuleIndexBtn(index: i)
            }

        }
    }
    
    private func createRuleLabel(index: Int, text: String, twoColored: Bool, textToColor: String) {
        rulesLabelArray.append(UILabel(
            text: text,
            font: Font.getFont(.poppinsRegular, size: 16),
            color: .greyBlack
        ))
        rulesLabelArray[index].numberOfLines = 0
        rulesLabelArray[index].textAlignment = .left
        
        if twoColored {
            let string = NSMutableAttributedString(string: text)
            string.setColorForText(textToColor, with: .blueLight)
            rulesLabelArray[index].attributedText = string
        }
        
        view.addSubview(rulesLabelArray[index])
    }
    
    private func createRuleIndexBtn(index: Int) {
        rulesIndexBtnArray.append(UIButton(type: .system))
        rulesIndexBtnArray[index].titleLabel?.font = UIFont(name: "dela-gothic-one", size: 16)
        rulesIndexBtnArray[index].tintColor = .greyBlack
        rulesIndexBtnArray[index].backgroundColor = .yellowLight
        rulesIndexBtnArray[index].layer.cornerRadius = 15
        rulesIndexBtnArray[index].setTitle("\(index + 1)", for: .normal)
        rulesIndexBtnArray[index].translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rulesIndexBtnArray[index])
    }
}

extension RulesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            rulesLabelArray[0].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesLabelArray[0].topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            rulesLabelArray[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            rulesLabelArray[0].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            rulesIndexBtnArray[0].topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            rulesIndexBtnArray[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            rulesIndexBtnArray[0].heightAnchor.constraint(equalToConstant: 29),
            rulesIndexBtnArray[0].widthAnchor.constraint(equalToConstant: 29),
            
            rulesLabelArray[1].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesLabelArray[1].topAnchor.constraint(equalTo: rulesLabelArray[0].bottomAnchor, constant: 10),
            rulesLabelArray[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            rulesLabelArray[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            rulesIndexBtnArray[1].topAnchor.constraint(equalTo: rulesIndexBtnArray[0].bottomAnchor, constant: 20),
            rulesIndexBtnArray[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            rulesIndexBtnArray[1].heightAnchor.constraint(equalToConstant: 29),
            rulesIndexBtnArray[1].widthAnchor.constraint(equalToConstant: 29),
            
            rulesLabelArray[2].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesLabelArray[2].topAnchor.constraint(equalTo: rulesLabelArray[1].bottomAnchor, constant: 20),
            rulesLabelArray[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            rulesLabelArray[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            rulesLabelArray[3].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesLabelArray[3].topAnchor.constraint(equalTo: rulesLabelArray[2].bottomAnchor, constant: 20),
            rulesLabelArray[3].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            rulesLabelArray[3].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            gestureRockButton.topAnchor.constraint(equalTo: rulesIndexBtnArray[1].bottomAnchor, constant: 10),
            gestureRockButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            gestureRockButton.heightAnchor.constraint(equalToConstant: 30),
            gestureRockButton.widthAnchor.constraint(equalToConstant: 30),
            
            rulesLabelArray[4].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesLabelArray[4].topAnchor.constraint(equalTo: rulesLabelArray[3].bottomAnchor, constant: 20),
            rulesLabelArray[4].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            rulesLabelArray[4].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            gesturePaperButton.topAnchor.constraint(equalTo: gestureRockButton.bottomAnchor, constant: 13),
            gesturePaperButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            gesturePaperButton.heightAnchor.constraint(equalToConstant: 30),
            gesturePaperButton.widthAnchor.constraint(equalToConstant: 30),
            
            rulesLabelArray[5].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesLabelArray[5].topAnchor.constraint(equalTo: rulesLabelArray[1].bottomAnchor, constant: 140),
            rulesLabelArray[5].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            rulesLabelArray[5].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            gestureScissorsButton.topAnchor.constraint(equalTo: gesturePaperButton.bottomAnchor, constant: 13),
            gestureScissorsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            gestureScissorsButton.heightAnchor.constraint(equalToConstant: 30),
            gestureScissorsButton.widthAnchor.constraint(equalToConstant: 30),
            
            rulesIndexBtnArray[2].topAnchor.constraint(equalTo: rulesIndexBtnArray[1].bottomAnchor, constant: 130),
            rulesIndexBtnArray[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            rulesIndexBtnArray[2].heightAnchor.constraint(equalToConstant: 29),
            rulesIndexBtnArray[2].widthAnchor.constraint(equalToConstant: 29),
            
            rulesLabelArray[6].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesLabelArray[6].topAnchor.constraint(equalTo: rulesLabelArray[5].bottomAnchor, constant: 20),
            rulesLabelArray[6].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            rulesLabelArray[6].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            rulesIndexBtnArray[3].topAnchor.constraint(equalTo: rulesIndexBtnArray[2].bottomAnchor, constant: 25),
            rulesIndexBtnArray[3].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            rulesIndexBtnArray[3].heightAnchor.constraint(equalToConstant: 29),
            rulesIndexBtnArray[3].widthAnchor.constraint(equalToConstant: 29),
            
            rulesLabelArray[7].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesLabelArray[7].topAnchor.constraint(equalTo: rulesLabelArray[6].bottomAnchor, constant: 20),
            rulesLabelArray[7].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            rulesLabelArray[7].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            rulesIndexBtnArray[4].topAnchor.constraint(equalTo: rulesIndexBtnArray[3].bottomAnchor, constant: 40),
            rulesIndexBtnArray[4].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            rulesIndexBtnArray[4].heightAnchor.constraint(equalToConstant: 29),
            rulesIndexBtnArray[4].widthAnchor.constraint(equalToConstant: 29),
            
        ])
    }
    
}

extension NSMutableAttributedString {
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        let range:NSRange?
        
        if let text = textToFind {
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        } else {
            range = NSMakeRange(0, self.length)
        }
        
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)
        }
    }
}

