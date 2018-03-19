//
//  SeaNodeConnector.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 07/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//


struct SeaNodeConnector: NodeConnectorDescribing {
    
    // MARK: NodeConnectorDescribing protocol
    func createNodes(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, x: Int8, y: Int8) {
        let position = BoardPosition(x, y)
        let node = BoardGraphNode(boardPosition: position)
        graph.add([node])
    }
    
    func addNodesConnections(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, map: [[FieldNodeDescribing]], x: Int8, y: Int8) {
        let position = BoardPosition(x, y)
        guard let centre = graph.node(at: position) else { return }
        
        if case .oneOf(let moves) = fieldNode.moveType {
            let connectedPositions = moves.map { BoardPosition(x + $0.x, y + $0.y) }
            let connectedNodes = connectedPositions.flatMap({ (position) -> BoardGraphNode? in
                guard let graphNode = graph.node(at: position) else { return nil }
                let adjacentFieldNode = map[Int(position.x)][Int(position.y)]
                return adjacentFieldNode is SeaNode ? graphNode : nil
            })
            centre.addConnections(to: connectedNodes, bidirectional: false)
        }
    }
    
    func removeNodesConnections(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, map: [[FieldNodeDescribing]], x: Int8, y: Int8) {
        let position = BoardPosition(x, y)
        guard let centre = graph.node(at: position) else { return }
        guard let inputConnections = graph.inputConnectionsToNode(at: position) else { return }
        for (position, node) in inputConnections {
            let inputFieldNode = map[Int(position.x)][Int(position.y)]
            if !(inputFieldNode is SeaNode || inputFieldNode is ArrowNode) {
                node.removeConnections(to: [centre], bidirectional: false)
            }
        }
    }
}
