//
//  StandardNodeConnector.swift
//  Jackal
//
//  Created by Alexander Savonin on 01/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

class DefaultNodeConnector: NodeConnectorDescribing {
    
    // MARK: NodeConnectorDescribing protocol
    func addNodesConnections(from fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
        
        let position = BoardPosition(x, y)
        guard let centre = level.graph.node(at: position) else { return }
        
        let connectedPositions: [BoardPosition]
        let moveType = fieldNode.rotatedMoveType()
        
        switch moveType {            
        case .oneOf(let moves):
            connectedPositions = moves.map { BoardPosition(x + $0.x, y + $0.y) }
            
        case .none:
            connectedPositions = []
        }
        
        let connectedNodes = connectedPositions.compactMap({ (toPosition) -> BoardGraphNode? in
            guard let adjacentFieldNode = level.fieldNodeInfoAt(position: toPosition) else { return nil }
            var graphNode: BoardGraphNode? = nil
            let isValid = adjacentFieldNode.nodeConnector.canCreateConnection(fromFieldNode: fieldNode,
                                                                              toFieldNode: adjacentFieldNode)
            if isValid {
                graphNode = adjacentFieldNode.nodeConnector.nodeForConnection(fromPosition: position,
                                                                              moveType: moveType,
                                                                              toFieldNode: adjacentFieldNode,
                                                                              toPosition: toPosition,
                                                                              level: level)
            }
            return graphNode
        })
        centre.addConnections(to: connectedNodes, bidirectional: false)
    }
}
