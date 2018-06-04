//
//  GraphNodeConnector.swift
//  Jackal
//
//  Created by Alexander Savonin on 01/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import SpriteKit

protocol NodeConnectorDescribing {
    
    func createNodes(for fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level)
    
    func addNodesConnections(from fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level)
    
    func canCreateConnection(fromFieldNode: FieldNodeDescribing, toFieldNode: FieldNodeDescribing) -> Bool
    
    func nodeForConnection(fromPosition: BoardPosition,
                           moveType: MoveType,
                           toFieldNode: FieldNodeDescribing,
                           toPosition: BoardPosition,
                           level: Level) -> BoardGraphNode?
}

extension NodeConnectorDescribing {
    
    func createNodes(for fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
        
        let position = BoardPosition(x, y)
        let node = BoardGraphNode(boardPosition: position)
        level.graph.add([node])
    }
    
    func nodeForConnection(fromPosition: BoardPosition,
                           moveType: MoveType,
                           toFieldNode: FieldNodeDescribing,
                           toPosition: BoardPosition,
                           level: Level) -> BoardGraphNode? {
        
        return level.graph.node(at: toPosition)
    }
    
    func canCreateConnection(fromFieldNode: FieldNodeDescribing, toFieldNode: FieldNodeDescribing) -> Bool {
        
        return true
    }
}
