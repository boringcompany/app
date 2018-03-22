//
//  ShipNode.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 22/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct ShipNode: FieldNodeDescribing {
    
    // MARK: Public Data Structures
    enum ShipType: String {
        case blackShip
        case greenShip
        case purpleShip
        case redShip
    }
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation
    var canContainObject = true
    var canStay = true
    var actionType: ActionType = .permanent
    var textureName: String
    
    // MARK: Lifecycle
    init(type: ShipType, rotation: Rotation) {
        let moves: [Move] = [Move(x:  0, y: +1, rotation: rotation),
                             Move(x: -1, y:  0, rotation: rotation),
                             Move(x: +1, y:  0, rotation: rotation)]
        self.moveType = .oneOf(moves)
        self.rotation = rotation
        self.textureName = type.rawValue
    }
}
