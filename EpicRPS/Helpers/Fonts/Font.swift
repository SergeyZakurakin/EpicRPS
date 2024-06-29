//
//  Font.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 10.06.2024.
//

import UIKit

enum Font: String {
    
    case rubickBlack = "Rubik-Black"
    case rubickBold = "Rubik-Bold"
    case rubickMedium = "Rubik-Medium"
    case rubickRegular = "Rubik-Regular"
    
    case poppinsBlack = "Poppins-Black"
    case poppinsRegular = "Poppins-Regular"
    
    static func getFont(_ font: Font, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
