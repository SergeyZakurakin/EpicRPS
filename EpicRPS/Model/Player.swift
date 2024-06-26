//
//  Player.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 15.06.2024.
//

import UIKit

struct Player: Codable {
    var avatarName: String?
    var victories: Int
    var loses: Int
    var score: Int
    
    var avatar: UIImage? {
        return UIImage(named: avatarName!)!
    }
}
