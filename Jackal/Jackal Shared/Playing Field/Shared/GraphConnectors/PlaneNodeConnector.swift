//
//  PlaneNodeConnector.swift
//  Jackal
//
//  Created by Andrey Zonov on 04/06/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

class PlaneNodeConnector: NodeConnectorDescribing {
    
    // MARK: NodeConnectorDescribing protocol
    func addNodesConnections(from fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
        
        let position = BoardPosition(x, y)
        guard let centre = level.graph.node(at: position) else { return }
        
        var connectedPositions: [BoardPosition] = []
        let size = level.configuration.size
        for x in 0..<size.width {
            for y in 0..<size.height {
                connectedPositions.append(BoardPosition(BoardPosition.Unit(x),
                                                        BoardPosition.Unit(y)))
            }
        }
        
        let connectedNodes = connectedPositions.compactMap({ (toPosition) -> BoardGraphNode? in
            guard let adjacentFieldNode = level.fieldNodeInfoAt(position: toPosition) else { return nil }
            var graphNode: BoardGraphNode? = nil
            let isValid = adjacentFieldNode.nodeConnector.canCreateConnection(fromFieldNode: fieldNode,
                                                                              toFieldNode: adjacentFieldNode)
            if isValid {
                graphNode = adjacentFieldNode.nodeConnector.nodeForConnection(fromPosition: position,
                                                                              moveType: fieldNode.moveType,
                                                                              toFieldNode: adjacentFieldNode,
                                                                              toPosition: toPosition,
                                                                              level: level)
            }
            return graphNode
        })
        centre.addConnections(to: connectedNodes, bidirectional: false)
    }
}
