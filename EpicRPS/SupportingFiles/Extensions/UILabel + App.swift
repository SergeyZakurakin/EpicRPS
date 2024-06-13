//
//  UILabel + App.swift
//  EpicRPS
//
//  Created by Vadim Zhelnov on 13.06.24.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont?, color: UIColor) {
        self.init()
        self.text = text
        self.font = font
        textColor = color
        numberOfLines = 3
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
