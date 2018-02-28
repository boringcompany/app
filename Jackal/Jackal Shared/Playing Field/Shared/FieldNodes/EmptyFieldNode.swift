//
//  EmptyFieldNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct EmptyFieldNode: FieldNodeDescribing {
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation
    var textureName = "suit"
    var canContainObject = true
    var canStay = true
    var actionType: ActionType = .permanent
    
    // MARK: Lifecycle
    init(rotation: Rotation) {
        let moves: [Move] = [Move(x: -1, y: -1),
                             Move(x:  0, y: -1),
                             Move(x: +1, y: -1),
                             Move(x: -1, y:  0),
                             Move(x: +1, y:  0),
                             Move(x: -1, y: +1),
                             Move(x:  0, y: +1),
                             Move(x: +1, y: +1)]
        moveType = .oneOf(moves)
        self.rotation = rotation
    }
}
