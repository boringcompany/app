//
//  SeaNodeConnector.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 07/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//


class SeaNodeConnector: NodeConnectorDescribing {
    
    // MARK: NodeConnectorDescribing protocol
    func addNodesConnections(from fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
        
        let position = BoardPosition(x, y)
        guard let centre = level.graph.node(at: position) else { return }
        let moveType = fieldNode.rotatedMoveType()
        
        if case .oneOf(let moves) = moveType {
            let connectedPositions = moves.map { BoardPosition(x + $0.x, y + $0.y) }
            let connectedNodes = connectedPositions.compactMap({ (toPosition) -> BoardGraphNode? in
                guard let adjacentFieldNode = level.fieldNodeInfoAt(position: toPosition) else { return nil }
                var graphNode: BoardGraphNode? = nil
                let isValid = canCreateConnection(fromFieldNode: fieldNode, toFieldNode: adjacentFieldNode)
                    && adjacentFieldNode.nodeConnector.canCreateConnection(fromFieldNode: fieldNode, toFieldNode: adjacentFieldNode)
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
    
    func canCreateConnection(fromFieldNode: FieldNodeDescribing, toFieldNode: FieldNodeDescribing) -> Bool {
        
        let isValid = (toFieldNode is SeaNode || toFieldNode is ShipNode)
            && (fromFieldNode is SeaNode
                || fromFieldNode is ArrowNode
                || fromFieldNode is IceNode
                || fromFieldNode is ShipNode)
        return isValid
    }
}
