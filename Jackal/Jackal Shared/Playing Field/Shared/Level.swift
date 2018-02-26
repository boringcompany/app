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
    struct Configuration {
        
        // MARK: Public Data Structures
        struct Size {
            let width: Int
            let height: Int
        }
        
        struct FieldNodeAmount {
            let node: FieldNodeDescribable.Type
            let amount: UInt
        }
        
        // MARK: Public Properties
        let size: Size
        let amountOfFields: [FieldNodeAmount]
    }
    
    // MARK: Private Properties
    private let initialNodes: [[FieldNodeDescribable]]
    private let configuration: Configuration
    
    // MARK: Public Properties
    let graph: BoardGraph<BoardGraphNode>
    
    
    // MARK: Lifecycle
    init(configuration: Configuration = .standard) {
        self.configuration = configuration
        
        graph = BoardGraph()
        let size = configuration.size
        var fieldNodes: [[FieldNodeDescribable]] = Array(repeating: Array(repeating: EmptyFieldNode(rotation: .none),
                                                                          count: Int(size.height)),
                                                         count: Int(size.width))
        for x in 0..<Int8(size.width) {
            for y in 0..<Int8(size.height) {
                let position = BoardPosition(x, y)
                let node = BoardGraphNode(boardPosition: position)
                graph.add([node])
            }
        }
        
        for x in 0..<Int8(configuration.size.width) {
            for y in 0..<Int8(size.height) {
                
                let fieldNode = fieldNodes[Int(x)][Int(y)]
                let position = BoardPosition(x, y)
                guard let centre = graph.node(at: position) else { continue }
                
                let connectedPositions: [BoardPosition]
                
                switch fieldNode.moveType {
                case .any:
                    connectedPositions = []//TODO: Fix
                    
                case .oneOf(let moves):
                    connectedPositions = moves.map { BoardPosition(x + $0.x, y + $0.y) }
                }
                
                let connectedNodes = connectedPositions.flatMap(graph.node(at:))
                centre.addConnections(to: connectedNodes, bidirectional: false)
            }
        }
        initialNodes = fieldNodes
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
    
    func textureNameAt(x: Int, y: Int) -> String {
        return initialNodes[x][y].textureName
    }
}
