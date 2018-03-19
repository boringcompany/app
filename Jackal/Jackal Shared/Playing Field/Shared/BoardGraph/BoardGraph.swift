//
//  BoardGraph.swift
//  Jackal
//
//  Created by Anton Tyutin on 29.01.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit


class BoardGraph<NodeType>: GKGraph where NodeType: BoardGraphNode {
    
    private var nodesByPosition: [BoardPosition: NodeType] = [:]
    
    
    override func add(_ nodes: [GKGraphNode]) {
        
        super.add(nodes)
        
        nodes.flatMap { $0 as? NodeType }
            .forEach { nodesByPosition[$0.boardPosition] = $0 }
    }
    
    
    override func remove(_ nodes: [GKGraphNode]) {
        
        super.remove(nodes)
        
        nodes.flatMap { ($0 as? NodeType)?.boardPosition }
            .forEach { nodesByPosition.removeValue(forKey:$0) }
    }
    
    
    func node(at boardPosition: BoardPosition) -> NodeType? {
        return self.nodesByPosition[boardPosition]
    }
    
    
    func inputConnectionsToNode(at boardPosition: BoardPosition) -> [BoardPosition: NodeType]? {
        guard let targetNode = node(at: boardPosition) else { return nil }
        return self.nodesByPosition.filter { $0.value.connectedNodes.contains(targetNode) }
    }
}
