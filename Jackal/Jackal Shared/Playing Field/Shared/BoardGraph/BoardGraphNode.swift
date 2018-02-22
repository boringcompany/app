//
//  BoardGraphNode.swift
//  Jackal
//
//  Created by Anton Tyutin on 29.01.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit


class BoardGraphNode: GKGraphNode {
    
    var boardPosition: BoardPosition
    
    init(boardPosition: BoardPosition) {
        
        self.boardPosition = boardPosition
        super.init()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
