//
//  ProgressView + ext.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 17.06.2024.
//

import UIKit

extension UIProgressView {
    convenience init(progressColor: UIColor, trackColor: UIColor, rotationAngle: CGFloat) {
        self.init()
        progress = 0.0
        progressTintColor = progressColor
        trackTintColor = trackColor
        clipsToBounds = true
        transform = CGAffineTransform(rotationAngle: rotationAngle)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
