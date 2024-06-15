//
//  RPSSign.swift
//  EpicRPS
//
//  Created by Evgenii Mazrukho on 13.06.2024.
//

import UIKit

enum RPSSign {
    case rock
    case paper
    case scissors
    
    
    func getGameState(computerSign: RPSSign) -> GameState {
        var gameState = GameState.start
        switch self {
        case .rock:
            if computerSign == .rock { gameState = .draw }
            if computerSign == .paper { gameState = .lose }
            if computerSign == .scissors { gameState = .win }
        case .paper:
            if computerSign == .rock { gameState = .win }
            if computerSign == .paper { gameState = .draw }
            if computerSign == .scissors { gameState = .lose }
        case .scissors:
            if computerSign == .rock { gameState = .lose }
            if computerSign == .paper { gameState = .win }
            if computerSign == .scissors { gameState = .draw }
        }
        return gameState
    }
    
    
    static func randomSign() -> RPSSign {
        let sign = Int.random(in: 0...2)
        
        if sign == 0 {
            return .rock
        } else if sign == 1 {
            return .paper
        } else {
            return .scissors
        }
    }
}
