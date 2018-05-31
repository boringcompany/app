//
//  IceNodeConnector.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 20/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

class IceNodeConnector: NodeConnectorDescribing {
    
    private var connections: [BoardPosition] = []
    
    // MARK: NodeConnectorDescribing protocol
    func createNodes(for fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
    }
    
    func addNodesConnections(from fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
    }
    
    func canCreateConnection(fromFieldNode: FieldNodeDescribing, toFieldNode: FieldNodeDescribing) -> Bool {
        
        return true
    }
    
    func nodeForConnection(fromPosition: BoardPosition,
                           moveType: MoveType,
                           toFieldNode: FieldNodeDescribing,
                           toPosition: BoardPosition,
                           level: Level) -> BoardGraphNode? {
        
        let currentIndex = self.connections.index(of: fromPosition)
        let z: Int
        if currentIndex == nil {
            z = self.connections.count
            self.connections.append(fromPosition)
        } else {
            z = currentIndex!
        }
        
        let icePosition = BoardPosition(x: toPosition.x, y: toPosition.y, z: Int8(z))
        let node = BoardGraphNode(boardPosition: icePosition)
        level.graph.add([node])
        
        let connectedPositions: [BoardPosition]
        
        switch moveType {
        case .any:
            connectedPositions = [] //TODO: Fix
            
        case .oneOf(let moves):
            let move = Move(x: toPosition.x - fromPosition.x, y: toPosition.y - fromPosition.y)
            let iceMoves: [Move] = max(move.x, move.y) > 1 ? moves : [move]
            connectedPositions = iceMoves.map { BoardPosition(toPosition.x + $0.x, toPosition.y + $0.y) }
            
        case .none:
            connectedPositions = []
        }
        
        let connectedNodes = connectedPositions.compactMap({ (nextPosition) -> BoardGraphNode? in
            guard let adjacentFieldNode = level.fieldNodeInfoAt(position: nextPosition) else { return nil }
            let graphNode: BoardGraphNode? = adjacentFieldNode.nodeConnector.nodeForConnection(fromPosition: toPosition,
                                                                                               moveType: moveType,
                                                                                               toFieldNode: adjacentFieldNode,
                                                                                               toPosition: nextPosition,
                                                                                               level: level)
            return graphNode
        })
        node.addConnections(to: connectedNodes, bidirectional: false)
        
        return node
    }
}
