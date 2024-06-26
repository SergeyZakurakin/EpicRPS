//
//  UILabel + ext.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 17.06.2024.
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
    
    
    convenience init(text: String = "",
                     font: Font = .rubickBold,
                     fontSize: CGFloat = 19,
                     color: UIColor,
                     textAlignment: NSTextAlignment = .center) {
        
        self.init()
        self.text = text
        self.font = Font.getFont(font, size: fontSize)
        self.textAlignment = textAlignment
        textColor = color
        adjustsFontSizeToFitWidth = true
        numberOfLines = 0
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    convenience init(textColor: ColorResource) {
        self.init()
        
        self.text = "EPIC RPS"
        self.font = UIFont(name: "Rubik-Bold", size: 30)
        self.textColor = UIColor(resource: textColor)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
