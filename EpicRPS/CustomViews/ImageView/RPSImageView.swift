//
//  RPSImageView.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 11.06.2024.
//

import UIKit

final class RPSImageView: UIImageView {
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    convenience init(image: UIImage = .dcWrestler) {
        self.init(frame: .zero)
        self.image = image
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Internal Methods
    
    private func configure() {
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
}
