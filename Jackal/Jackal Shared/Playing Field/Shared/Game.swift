//
//  Game.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/01/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class Game {
    
    // MARK: Private Data Structures
    private enum Constants {
        static let width: Int32 = 10
        static let height: Int32 = 10
        static let cellWidth = 50
    }
    
    // MARK: Private Properties
    private let level: Level
    private let size: Level.Size
    
    // MARK: Public Properties
    lazy var gameScene: GameScene = {
        return GameScene.newGameScene(with: self)
    }()
    
    // MARK: Lifecycle
    init() {
        size = Level.Size(width: Constants.width,
                          height: Constants.height)
        level = Level(with: size)
    }
    
    // MARK: Private
    private func setupPlayingBoard(in scene: SKScene) {
        scene.backgroundColor = .blue
        
        let board = SKNode()
        let width = CGFloat(Constants.cellWidth)
        let graph = level.graph
        let cellSize = CGSize(width: width, height: width)
        let step: Float = 1 / Float(size.width * size.height)
        var index: Float = 0
        for i in 0..<size.width {
            for j in 0..<size.height {
                if graph.node(atGridPosition: vector_int2(x: i, y: j)) != nil {
                    let color = NSColor(calibratedWhite: CGFloat(index * step), alpha: 1)
                    let node = SKSpriteNode(color: color, size: cellSize)
                    let x = CGFloat(i) * width + width / 2
                    let y = CGFloat(j) * width  + width / 2
                    node.position = CGPoint(x: x, y: y)
                    board.addChild(node)
                    index += 1
                }
            }
        }
        scene.addChild(board)
    }
}

// MARK: - GameSceneOutput
extension Game: GameSceneOutput {
    
    func sceneDidSetUp(scene: SKScene) {
        setupPlayingBoard(in: scene)
    }
}
