//
//  ArrowNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 26/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct ArrowNode: FieldNodeDescribable {
    
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
    var textureName = "suit"
    
    // MARK: Lifecycle
    init(rotation: Rotation, type: Type) {
        let moves: [Move] = []
        moveType = .oneOf(moves)
        self.rotation = rotation
    }
}
