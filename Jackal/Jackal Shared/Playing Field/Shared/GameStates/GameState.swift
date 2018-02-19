//
//  GameState.swift
//  Jackal
//
//  Created by Anton Tyutin on 19.02.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit


class GameState: GKState {
    
    let game: Game
    
    init(game: Game) {
        self.game = game
    }
}
