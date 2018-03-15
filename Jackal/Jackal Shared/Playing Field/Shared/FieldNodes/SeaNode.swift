//
//  SeaNode.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 07/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct SeaNode: FieldNodeDescribing {
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation = .none
    var canContainObject = false
    var canStay = true
    var actionType: ActionType = .permanent
    var textureName: String = "transparentNode"
    var nodeConnector: NodeConnectorDescribing
    
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
        nodeConnector = SeaNodeConnector()
    }
}
