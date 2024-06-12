//
//  RPSTitleLabel.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 11.06.2024.
//

import UIKit

final class RPSTitleLabel: UILabel {

    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        configure()
    }
    
    
    convenience init(text: String,
                     font: Font = .rubickBold,
                     fontSize: CGFloat = 19,
                     color: UIColor,
                     textAlignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        
        self.text = text
        self.font = Font.getFont(font, size: fontSize)
        textColor = color
        self.textAlignment = textAlignment
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Internal Methods
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        numberOfLines = 0
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
