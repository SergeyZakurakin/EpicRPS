//
//  UIView + ext.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 13.06.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
            for view in subviews {
                addSubview(view)
            }
        }
    
    
    func addSubviews(_ subviews: [UIView]) {
            for view in subviews {
                addSubview(view)
            }
        }
    
    
    func addTopInnerShadow() {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 3)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 3
        shadowLayer.fillRule = .evenOdd
        clipsToBounds = true
        
        let path = UIBezierPath(rect: bounds.insetBy(dx: -bounds.size.width, dy: -bounds.size.height))
        
        let innerPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).reversing()
        
        path.append(innerPath)
        shadowLayer.path = path.cgPath
        
        layer.addSublayer(shadowLayer)
    }
}

