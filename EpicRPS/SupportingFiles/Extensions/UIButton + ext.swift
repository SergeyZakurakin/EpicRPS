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
}
