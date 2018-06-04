//
//  OutboundNodeConnector.swift
//  Jackal
//
//  Created by Alexander Savonin on 22/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//


class OutboundNodeConnector: NodeConnectorDescribing {
    
    // MARK: NodeConnectorDescribing protocol
    func createNodes(for fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
    }
    
    func addNodesConnections(from fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
    }
    
    func canCreateConnection(fromFieldNode: FieldNodeDescribing, toFieldNode: FieldNodeDescribing) -> Bool {
        
        return false
    }
    
    func nodeForConnection(fromPosition: BoardPosition,
                           moveType: MoveType,
                           toFieldNode: FieldNodeDescribing,
                           toPosition: BoardPosition,
                           level: Level) -> BoardGraphNode? {
        
        return nil
    }
}
