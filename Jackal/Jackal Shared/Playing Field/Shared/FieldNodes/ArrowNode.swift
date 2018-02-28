//
//  ArrowNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 26/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct ArrowNode: FieldNodeDescribing {

    // MARK: Public Data Structures
    enum `Type`: String {
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
    var isOpen = false
    var textureName: String
    
    // MARK: Lifecycle
    init(rotation: Rotation, type: Type) {
        let info = ArrowNode.info(for: type)
        moveType = .oneOf(info.moves)
        textureName = info.textureName
        self.rotation = rotation
    }
    
    // MARK: Private
    private static func info(for type: Type) -> (moves: [Move], textureName: String) {
        let moves: [Move]
        let textureName: String = type.rawValue
        
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
        return (moves, textureName)
    }
    
    // MARK: Public
    mutating func toggle() {
        isOpen = !isOpen
    }
}
