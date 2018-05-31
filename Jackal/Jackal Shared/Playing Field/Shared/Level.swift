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
    private var visibleNodes: [[FieldNodeDescribing]]
    private let configuration: Configuration
    
    // MARK: Public Properties
    private(set) var graph: BoardGraph<BoardGraphNode>
    
    
    // MARK: Lifecycle
    init(configuration: Configuration = .standard) {
        self.configuration = configuration
        
        self.initialNodes = Level.nodes(for: configuration)
        self.visibleNodes = Level.buildSuits(using: configuration)
        self.graph = BoardGraph()
    }
    
    
    func availableDestinations(for boardPosition: BoardPosition) -> [BoardPosition] {
        
        guard let node = graph.node(at: boardPosition) else {
            return []
        }
        
        let positions = node.connectedNodes.compactMap { connectedNode in
            return (connectedNode as? BoardGraphNode)?.boardPosition
        }
        
        return positions
    }
    
    
    func fieldNodeInfoAt(x: Int, y: Int) -> FieldNodeDescribing? {
        if x < 0
            || y < 0
            || x >= self.visibleNodes.count
            || y >= self.visibleNodes[x].count { return nil }
        return visibleNodes[x][y]
    }
    
    
    func fieldNodeInfoAt(position: BoardPosition) -> FieldNodeDescribing? {
        return fieldNodeInfoAt(x: Int(position.x), y: Int(position.y))
    }
    
    
    @discardableResult
    func openCell(x: Int, y: Int) -> FieldNodeDescribing {
        
        let node = self.initialNodes[x][y]
        self.visibleNodes[x][y] = node
        
        buildGraph()
        
        return node
    }
    
    
    //For now, I have no idea how to do it more clearly and safe, u r welcome :-)
    static func nodes(for configuration: Configuration) -> [[FieldNodeDescribing]] {
        var nodes: [[FieldNodeDescribing]] = Array(repeating: Array(repeating: OutboundNode(),
                                      count: Int(configuration.size.height)),
                     count: Int(configuration.size.width))
        
        var sourcefieldNodes: [FieldNodeDescribing] = []
        for field in configuration.amountOfFields {
            for _ in 0..<field.amount {
                sourcefieldNodes.append(field.node)
            }
        }
        let shuffledNodes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: sourcefieldNodes) as! [FieldNodeDescribing]
        var shuffledNodesCounter = 0
        
        let height = configuration.size.height
        let width = configuration.size.width
        
        for y in 0...(height - 1) {
            for x in 0...(width - 1) {
                if isCorner(x: x, y: y, height: height, width: width) { continue }
                if isSea(x: x, y: y, height: height, width: width) {
                    nodes[x][y] = SeaNode()
                } else {
                    nodes[x][y] = shuffledNodes[shuffledNodesCounter]
                    shuffledNodesCounter += 1
                }
            }
        }
        
        return nodes
    }
    
    
    static func buildSuits(using configuration: Configuration) -> [[FieldNodeDescribing]] {
        
        var nodes: [[FieldNodeDescribing]] = Array(repeating: Array(repeating: OutboundNode(),
                                                                    count: Int(configuration.size.height)),
                                                   count: Int(configuration.size.width))
        
        let height = configuration.size.height
        let width = configuration.size.width
        
        for y in 0...(height - 1) {
            for x in 0...(width - 1) {
                
                if isCorner(x: x, y: y, height: height, width: width) {
                    continue
                }
                if isSea(x: x, y: y, height: height, width: width) {
                    nodes[x][y] = SeaNode()
                    continue
                }
                nodes[x][y] = SuitNode()
            }
        }
        
        return nodes
    }
    
    
    func buildGraph() {
        
        self.graph = BoardGraph()
        
        for (x, line) in self.visibleNodes.enumerated() {
            for (y, node) in line.enumerated() {
                
                node.nodeConnector.createNodes(for: node, x: Int8(x), y: Int8(y), level: self)
            }
        }
        
        for (x, line) in self.visibleNodes.enumerated() {
            for (y, node) in line.enumerated() {
                
                node.nodeConnector.addNodesConnections(from: node,
                                                       x: Int8(x),
                                                       y: Int8(y),
                                                       level: self)
            }
        }
    }
    
    
    // handling edge case
    private static func isSea(x: Int, y: Int, height: Int, width: Int) -> Bool {
        let firstConditions: [Bool] = [x == 0, y == 0, x == width - 1, y == height - 1]
        let secondCondions: [Bool] = [x > 1 && x < width - 2, y > 1 && y < height - 2]
        let thirdCondions: [Bool] = [x == 1, y == 1, x == width - 2, y == height - 2]
        let firstCount = firstConditions.filter { $0 }.count
        let secondCount = secondCondions.filter { $0 }.count
        let thirdCount = thirdCondions.filter { $0 }.count
        return (firstCount == 1 && secondCount == 1) || thirdCount == 2
    }
    
    // handling corner case
    private static func isCorner(x: Int, y: Int, height: Int, width: Int) -> Bool {
        let firstConditions: [Bool] = [x == 0, y == 0, x == width - 1, y == height - 1]
        let secondCondions: [Bool] = [x == 1, y == 1, x == width - 2, y == height - 2]
        let firstCount = firstConditions.filter { $0 }.count
        let secondCount = secondCondions.filter { $0 }.count
        return firstCount != 0 && firstCount + secondCount == 2
    }
}
