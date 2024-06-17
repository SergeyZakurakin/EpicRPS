//
//  UIImageView + ext.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 17.06.2024.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        self.image = image
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    convenience init(bgColor: UIColor) {
        self.init()
        backgroundColor = bgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
