//
//  UIView + ext.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 13.06.2024.
//

import UIKit

//MARK: - Add Subviews

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
}


//MARK: - Add / Remove Shadow

fileprivate let shadowLayer = CAShapeLayer()

extension UIView {
    
    func addTopInnerShadow() {
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 4)
        shadowLayer.shadowOpacity = 0.6
        shadowLayer.shadowRadius = 4
        shadowLayer.fillRule = .evenOdd
        clipsToBounds = true
        
        let path = UIBezierPath(rect: bounds.insetBy(dx: -bounds.size.width, dy: -bounds.size.height))
        
        let innerPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).reversing()
        
        path.append(innerPath)
        shadowLayer.path = path.cgPath
        layer.addSublayer(shadowLayer)
    }
    
    
    func removeShadow() {
        shadowLayer.removeFromSuperlayer()
    }
    
    
    func addShadowOnView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1
    }
}


//MARK: - Custom Settings View

extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}
