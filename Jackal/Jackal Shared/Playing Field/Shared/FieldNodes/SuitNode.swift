//
//  SuitNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 01/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct SuitNode: FieldNodeDescribing {
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation = .none
    var canContainObject = true
    var canStay = true
    var actionType: ActionType = .permanent
    var textureName: String
    
    // MARK: Lifecycle
    init() {
        let moves: [Move] = [Move(x: -1, y: -1),
                             Move(x:  0, y: -1),
                             Move(x: +1, y: -1),
                             Move(x: -1, y:  0),
                             Move(x: +1, y:  0),
                             Move(x: -1, y: +1),
                             Move(x:  0, y: +1),
                             Move(x: +1, y: +1)]
        moveType = .oneOf(moves)
        textureName = "suit"
    }
}
