//
//  HorseNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 28/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//


struct HorseNode: FieldNodeDescribing {
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation = .none
    var canContainObject = true
    var canStay = false
    var actionType: ActionType = .permanent
    
    // MARK: Lifecycle
    init() {
        let moves = [Move(x:  1, y:  2),
                     Move(x: -1, y:  2),
                     Move(x: -2, y:  1),
                     Move(x: -2, y: -1),
                     Move(x: -1, y: -2),
                     Move(x:  1, y: -2),
                     Move(x:  2, y:  1),
                     Move(x:  2, y: -1)]
        moveType = .oneOf(moves)
    }
}
