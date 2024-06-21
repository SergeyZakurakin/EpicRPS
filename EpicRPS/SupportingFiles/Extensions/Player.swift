//
//  Player.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 15.06.2024.
//

import UIKit

struct Player {
    let character: UIImage
    var victories: String
    var loses: String
}


struct PlayerScore: Codable {
    var totalVictories: Int
    var totalLoses: Int
    var victories: Int
    var loses: Int
}
