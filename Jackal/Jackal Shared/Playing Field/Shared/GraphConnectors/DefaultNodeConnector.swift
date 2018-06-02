//
//  StandardNodeConnector.swift
//  Jackal
//
//  Created by Alexander Savonin on 01/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

class DefaultNodeConnector: NodeConnectorDescribing {
    
    // MARK: NodeConnectorDescribing protocol
    func createNodes(for fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
        
        let position = BoardPosition(x, y)
        let node = BoardGraphNode(boardPosition: position)
        level.graph.add([node])
    }
    
    func addNodesConnections(from fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
        
        let position = BoardPosition(x, y)
        guard let centre = level.graph.node(at: position) else { return }
        
        var connectedPositions: [BoardPosition]
        
        switch fieldNode.moveType {
        case .any:
            connectedPositions = []
            let size = level.configuration.size
            for x in 0..<size.width {
                for y in 0..<size.height {
                    connectedPositions.append(BoardPosition(BoardPosition.Unit(x),
                                                            BoardPosition.Unit(y)))
                }
            }
            
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
                                                                              moveType: fieldNode.moveType,
                                                                              toFieldNode: adjacentFieldNode,
                                                                              toPosition: toPosition,
                                                                              level: level)
            }
            return graphNode
        })
        centre.addConnections(to: connectedNodes, bidirectional: false)
    }
    
    func canCreateConnection(fromFieldNode: FieldNodeDescribing, toFieldNode: FieldNodeDescribing) -> Bool {
        
        return true
    }
    
    func nodeForConnection(fromPosition: BoardPosition,
                           moveType: MoveType,
                           toFieldNode: FieldNodeDescribing,
                           toPosition: BoardPosition,
                           level: Level) -> BoardGraphNode? {
        
        return level.graph.node(at: toPosition)
    }
}
