//
//  TurntableNode.swift
//  Jackal
//
//  Created by Alexander Savonin on 28/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct TurntableNode: FieldNodeDescribing {
    
    // MARK: Public Data Structures
    enum `Type`: String {
        case twoSteps
        case threeSteps
        case fourSteps
        case fiveSteps
    }
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation = .none
    var canContainObject = true
    var canStay = true
    var actionType: ActionType = .permanent
    var isOpen = false
    var textureName: String
    
    // MARK: Lifecycle
    init(type: Type) {
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
    }
    
    // MARK: Public
    mutating func toggle() {
        isOpen = !isOpen
    }
}
