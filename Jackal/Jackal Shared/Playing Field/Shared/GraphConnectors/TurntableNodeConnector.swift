//
//  TurntableNodeConnector.swift
//  Jackal
//
//  Created by Alexander Savonin on 01/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct TurntableNodeConnector: NodeConnectorDescribing {
    
    // MARK: Private
    private func castFieldNode(fieldNode: FieldNodeDescribing) -> TurntableNode {
        assert(fieldNode is TurntableNode, "Wrong field node type")
        return fieldNode as! TurntableNode
    }
    
    // MARK: NodeConnectorDescribing protocol
    func createNodes(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, x: Int8, y: Int8) {
        let turntableNode = castFieldNode(fieldNode: fieldNode)
        var graphNodes: [BoardGraphNode] = []
        for z in 0..<turntableNode.stepsCount {
            let position = BoardPosition(x, y, Int8(z))
            let node = BoardGraphNode(boardPosition: position)
            graphNodes.append(node)
        }
        graph.add(graphNodes)
    }
    
    func addNodesConnections(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, x: Int8, y: Int8) {
        let turntableNode = castFieldNode(fieldNode: fieldNode)
        for z in 0..<turntableNode.stepsCount-1 {
            let position = BoardPosition(x, y, Int8(z))
            let connectedPosition = BoardPosition(x, y, Int8(z+1))
            guard let centre = graph.node(at: position) else { continue }
            guard let connectedNode = graph.node(at: connectedPosition) else { continue }
            centre.addConnections(to: [connectedNode], bidirectional: false)
        }
        
        let position = BoardPosition(x, y, Int8(turntableNode.stepsCount-1))
        guard let centre = graph.node(at: position) else { return }
        
        if case .oneOf(let moves) = fieldNode.moveType {
            let connectedPositions = moves.map { BoardPosition(x + $0.x, y + $0.y) }
            let connectedNodes = connectedPositions.flatMap(graph.node(at:))
            centre.addConnections(to: connectedNodes, bidirectional: false)
        }
    }
    
    func removeNodesConnections(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, x: Int8, y: Int8) {
    }
}
