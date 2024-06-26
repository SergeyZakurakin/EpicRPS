//
//  UIButton + ext.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 21.06.2024.
//

import UIKit

extension UIButton {
    convenience init(image: UIImage) {
        self.init(type: .system)
        self.setBackgroundImage(image, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    convenience init(textLabel: String) {
        self.init()
        
        self.setTitle(textLabel, for: .normal)
        self.setBackgroundImage(.buttonBackground, for: .normal)
        self.setTitleColor(.brownDarker, for: .normal)
        self.titleLabel?.font = Font.getFont(.rubickBold, size: 16)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
