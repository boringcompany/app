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
            let node: FieldNodeDescribing
            let amount: UInt
        }
        
        // MARK: Public Properties
        let size: Size
        let amountOfFields: [FieldNodeAmount]
    }
    
    // MARK: Private Properties
    private let initialNodes: [[FieldNodeDescribing]]
    private let configuration: Configuration
    
    // MARK: Public Properties
    let graph: BoardGraph<BoardGraphNode>
    
    
    // MARK: Lifecycle
    init(configuration: Configuration = .standard) {
        self.configuration = configuration
        
        graph = BoardGraph()
        let size = configuration.size
        
        var fieldNodes = Level.nodes(for: configuration)//Some kind of mapping
        
        for x in 0..<Int8(size.width) {
            for y in 0..<Int8(size.height) {
                let fieldNode = fieldNodes[Int(x)][Int(y)]
                fieldNode.nodeConnector.createNodes(fieldNode: fieldNode, graph: graph, x: x, y: y)
            }
        }
        
        for x in 0..<Int8(size.width) {
            for y in 0..<Int8(size.height) {
                let fieldNode = fieldNodes[Int(x)][Int(y)]
                fieldNode.nodeConnector.addNodesConnections(fieldNode: fieldNode, graph: graph, x: x, y: y)
            }
        }
        
        for x in 0..<Int8(size.width) {
            for y in 0..<Int8(size.height) {
                let fieldNode = fieldNodes[Int(x)][Int(y)]
                fieldNode.nodeConnector.removeNodesConnections(fieldNode: fieldNode, graph: graph, x: x, y: y)
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
    
    func fieldNodeInfoAt(x: Int, y: Int) -> FieldNodeDescribing {
        return initialNodes[x][y]
    }
    
    func relativePosition(for boardPosition: BoardPosition) -> Position? {
        
        let fieldNode = initialNodes[Int(boardPosition.x)][Int(boardPosition.y)]
        return fieldNode.relativePosition(boardPosition:boardPosition)
    }
    
    //For now, i have no idea how to do it more clearly and safe, u a welcome :-)
    static func nodes(for configuration: Configuration) -> [[FieldNodeDescribing]] {
        var nodes: [[FieldNodeDescribing]] = Array(repeating: Array(repeating: EmptyNode(),
                                      count: Int(configuration.size.height)),
                     count: Int(configuration.size.width))
        
        var x = 0
        var y = 0
        
        for field in configuration.amountOfFields {
            for _ in 0..<field.amount {
                nodes[x][y] = field.node
                x += 1
                if x == configuration.size.width {
                    x = 0
                    y += 1
                }
            }
        }
        return nodes
    }
}
