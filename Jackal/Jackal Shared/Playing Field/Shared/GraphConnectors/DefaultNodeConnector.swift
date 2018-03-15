//
//  StandardNodeConnector.swift
//  Jackal
//
//  Created by Alexander Savonin on 01/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct DefaultNodeConnector: NodeConnectorDescribing {
    
    // MARK: NodeConnectorDescribing protocol
    func createNodes(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, x: Int8, y: Int8) {
        let position = BoardPosition(x, y)
        let node = BoardGraphNode(boardPosition: position)
        graph.add([node])
    }
    
    func addNodesConnections(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, map: [[FieldNodeDescribing]], x: Int8, y: Int8) {
        let position = BoardPosition(x, y)
        guard let centre = graph.node(at: position) else { return }
        
        let connectedPositions: [BoardPosition]
        
        switch fieldNode.moveType {
        case .any:
            connectedPositions = [] //TODO: Fix
            
        case .oneOf(let moves):
            connectedPositions = moves.map { BoardPosition(x + $0.x, y + $0.y) }
            
        case .none:
            connectedPositions = []
        }
        
        let connectedNodes = connectedPositions.flatMap(graph.node(at:))
        centre.addConnections(to: connectedNodes, bidirectional: false)
    }
    
    func removeNodesConnections(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, map: [[FieldNodeDescribing]], x: Int8, y: Int8) {
    }
}
