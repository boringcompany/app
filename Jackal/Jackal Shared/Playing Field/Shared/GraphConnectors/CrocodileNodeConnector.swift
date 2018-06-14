//
//  CrocodileNodeConnector.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 01/06/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

class CrocodileNodeConnector: NodeConnectorDescribing {
    
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
        
        let crocodilePosition = BoardPosition(x: toPosition.x, y: toPosition.y, z: Int8(z))
        let node = BoardGraphNode(boardPosition: crocodilePosition)
        level.graph.add([node])
        
        let connectedPositions = [BoardPosition(int2: fromPosition.int2Position)]
        
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
