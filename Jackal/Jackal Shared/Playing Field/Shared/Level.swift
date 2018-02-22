//
//  Level.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/01/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit

class Level {
    
    // MARK: Public Data Structures
    struct Size {
        let width: Int32
        let height: Int32
    }
    
    // MARK: Public Properties
    let graph: BoardGraph<BoardGraphNode>
    
    
    // MARK: Lifecycle
    init(with size: Size) {
        
        graph = BoardGraph()
        
        for x in 0..<Int8(size.width) {
            for y in 0..<Int8(size.height) {
                
                let position = BoardPosition(x, y)
                let node = BoardGraphNode(boardPosition: position)
                graph.add([node])
            }
        }
        
        
        for x in 0..<Int8(size.width) {
            for y in 0..<Int8(size.height) {
                
                let position = BoardPosition(x, y)
                guard let centre = graph.node(at: position) else { continue }
                
                let connectedPositions = [
                    BoardPosition(x-1, y-1),
                    BoardPosition(x,   y-1),
                    BoardPosition(x+1, y-1),
                    BoardPosition(x-1, y),
                    BoardPosition(x+1, y),
                    BoardPosition(x-1, y+1),
                    BoardPosition(x,   y+1),
                    BoardPosition(x+1, y+1),
                ]
                
                let connectedNodes = connectedPositions.flatMap(graph.node(at:))
                centre.addConnections(to: connectedNodes, bidirectional: false)
            }
        }
    }
    
    
    func availableDestinations(for boardPosition: BoardPosition) -> [BoardPosition] {
        
        guard let node = graph.node(at: boardPosition) else {
            return []
        }
        
        let positions = node.connectedNodes.flatMap { connectedNode in
            return (connectedNode as? BoardGraphNode)?.boardPosition
        }
        
        return positions
    }
}
