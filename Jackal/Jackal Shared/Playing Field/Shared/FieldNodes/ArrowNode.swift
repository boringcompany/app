//
//  ArrowNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 26/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct ArrowNode: FieldNodeDescribing {
    
    enum `Type` {
        case unidirectionalStraight
        case unidirectionalDiagonal
        case bidirectionalStraight
        case bidirectionalDiagonal
        case threeDirectional
        case fourDirectionalStraight
        case fourDirectionalDiagonal
    }
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation
    var canContainObject = true
    var canStay = false
    var actionType: ActionType = .permanent
    var isOpenned = false
    
    // MARK: Lifecycle
    init(rotation: Rotation, type: Type) {
        moveType = .oneOf(ArrowNode.moves(for: type))
        self.rotation = rotation
    }
    
    // MARK: Private
    private static func moves(for type: Type) -> [Move] {
        let moves: [Move]
        switch type {
        case .unidirectionalStraight:
            moves = [Move(x: 0, y: 1)]
            
        case .unidirectionalDiagonal:
            moves = [Move(x: 1, y: 1)]
            
        case .bidirectionalStraight:
            moves = [Move(x: 0, y: 1),
                     Move(x: 0, y: -1)]
            
        case .bidirectionalDiagonal:
            moves = [Move(x: 1, y: 1),
                     Move(x: -1, y: -1)]
            
        case .threeDirectional:
            moves = [Move(x: 0, y: 1),
                     Move(x: 0, y: -1),
                     Move(x: -1, y: 0)]
            
        case .fourDirectionalStraight:
            moves = [Move(x: 0, y: 1),
                     Move(x: 0, y: -1),
                     Move(x: -1, y: 0),
                     Move(x: 1, y: 0)]
            
        case .fourDirectionalDiagonal:
            moves = [Move(x: -1, y: 1),
                     Move(x: 1, y: -1),
                     Move(x: -1, y: 1),
                     Move(x: 1, y: -1)]
        }
        return moves
    }
}
