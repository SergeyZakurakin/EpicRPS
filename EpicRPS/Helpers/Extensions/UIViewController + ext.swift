//
//  UIViewController + ext.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 12.06.2024.
//

import UIKit

extension UIViewController {
    
    func setupNavBar(on vc: UIViewController,
                     title: String?,
                     leftImage: UIImage, leftSelector: Selector?,
                     rightImage: UIImage?, rightSelector: Selector?) {
        
        let leftBarButton = UIBarButtonItem(image: leftImage.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: leftSelector)
        
        let rightBarButton = UIBarButtonItem(image: rightImage?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: rightSelector)
        
        navigationController?.navigationBar.tintColor = .greyBlack
        
        vc.title = title
        vc.navigationItem.setHidesBackButton(true, animated: true)
        vc.navigationItem.leftBarButtonItem = leftBarButton
        vc.navigationItem.rightBarButtonItem = rightBarButton
    }
}
