//
//  GoldNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 04/06/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation

struct GoldNode: FieldNodeDescribing {
    
    // MARK: Public Data Structures
    enum `Type`: String {
        case oneCoin
        case twoСoins
        case threeСoins
        case fourСoins
        case fiveСoins
    }
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation = .none
    var canContainObject = true
    var canStay = true
    var actionType: ActionType
    var textureName: String
    
    // MARK: Lifecycle
    init(type: Type) {
        let moves = [Move(x: -1, y: -1),
                     Move(x:  0, y: -1),
                     Move(x: +1, y: -1),
                     Move(x: -1, y:  0),
                     Move(x: +1, y:  0),
                     Move(x: -1, y: +1),
                     Move(x:  0, y: +1),
                     Move(x: +1, y: +1)]
        moveType = .oneOf(moves)
        textureName = type.rawValue
        
        let types: [Type] = [.oneCoin, .twoСoins, .threeСoins, .fourСoins, .fiveСoins]
        
        guard let index = types.index(of: type)?.advanced(by: 1) else {
            assertionFailure("unsupported \(type)")
            actionType = .atTheOpenning
            return
        }
        
        actionType = .showCoins(UInt(index))
    }
}
