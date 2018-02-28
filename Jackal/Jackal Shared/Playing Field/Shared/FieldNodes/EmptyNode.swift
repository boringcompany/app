//
//  EmptyNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct EmptyNode: FieldNodeDescribing {
    
    // MARK: Public Data Structures
    enum `Type`: String {
        case tree
        case log
        case stump
        case hole
    }
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation
    var canContainObject = true
    var canStay = true
    var actionType: ActionType = .permanent
    var isOpen = false
    var textureName: String
    
    // MARK: Lifecycle
    init(rotation: Rotation, type: Type) {
        let moves: [Move] = [Move(x: -1, y: -1),
                             Move(x:  0, y: -1),
                             Move(x: +1, y: -1),
                             Move(x: -1, y:  0),
                             Move(x: +1, y:  0),
                             Move(x: -1, y: +1),
                             Move(x:  0, y: +1),
                             Move(x: +1, y: +1)]
        moveType = .oneOf(moves)
        textureName = type.rawValue
        self.rotation = rotation
    }
    
    // MARK: Public
    mutating func toggle() {
        isOpen = !isOpen
    }
}
