//
//  TurntableNodeConnector.swift
//  Jackal
//
//  Created by Alexander Savonin on 01/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

class TurntableNodeConnector: NodeConnectorDescribing {
    
    // MARK: Private
    private func castFieldNode(fieldNode: FieldNodeDescribing) -> TurntableNode {
        
        assert(fieldNode is TurntableNode, "Wrong field node type")
        return fieldNode as! TurntableNode
    }
    
    // MARK: NodeConnectorDescribing protocol
    func createNodes(for fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
        
        let turntableNode = castFieldNode(fieldNode: fieldNode)
        var graphNodes: [BoardGraphNode] = []
        for z in 0..<turntableNode.stepsCount {
            let position = BoardPosition(x, y, Int8(z))
            let node = BoardGraphNode(boardPosition: position)
            graphNodes.append(node)
        }
        level.graph.add(graphNodes)
    }
    
    func addNodesConnections(from fieldNode: FieldNodeDescribing, x: Int8, y: Int8, level: Level) {
        
        let turntableNode = castFieldNode(fieldNode: fieldNode)
        for z in 0..<turntableNode.stepsCount-1 {
            let position = BoardPosition(x, y, Int8(z))
            let connectedPosition = BoardPosition(x, y, Int8(z+1))
            guard let centre = level.graph.node(at: position),
                let connectedNode = level.graph.node(at: connectedPosition)
                else { continue }
            centre.addConnections(to: [connectedNode], bidirectional: false)
        }
        
        let position = BoardPosition(x, y, Int8(turntableNode.stepsCount-1))
        guard let centre = level.graph.node(at: position) else { return }
        let moveType = fieldNode.rotatedMoveType()
        
        if case .oneOf(let moves) = moveType {
            let connectedPositions = moves.map { BoardPosition(x + $0.x, y + $0.y) }
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
