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
        static let width: Int32 = 11
        static let height: Int32 = 11
        
        enum zPosition: CGFloat {
            
            case fieldCell = 0
            case pirate = 100
        }
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
        let sceneSize = min(scene.size.width, scene.size.height)
        let board = SKNode()
        board.position = CGPoint(x: -sceneSize/2, y: -sceneSize/2)
        
        let width = CGFloat(gameScene.cellWidth)
        let cellSize = CGSize(width: width, height: width)
        
        for i in 0..<size.width {
            for j in 0..<size.height {
                guard !isCorner(x: i,
                                y: j,
                                height: size.height,
                                width: size.width)
                    else { continue }
                
                let node = SKSpriteNode(texture: SKTexture(imageNamed: "suit"),
                                        size: cellSize)
                node.position = self.gameScene.point(at: int2(i, j))
                node.zPosition = Constants.zPosition.fieldCell.rawValue
                board.addChild(node)
            }
        }
        
        let pirateSize = CGSize(width: width / 3, height: width / 3)
        let pirateNode = PirateNode(size: pirateSize)
        let pirateGridPosition = int2(size.width / 2, size.height / 2)
        pirateNode.position = self.gameScene.point(at: pirateGridPosition)
        pirateNode.zPosition = Constants.zPosition.pirate.rawValue
        board.addChild(pirateNode)
        
        scene.addChild(board)
    }
    
    
    func isCorner(x: Int32, y: Int32, height: Int32, width: Int32) -> Bool {
        let conditions: [Bool] = [x == 0, y == 0, x == width - 1, y == height - 1]
        return conditions.filter { $0 }.count == 2
    }
}

// MARK: - GameSceneOutput
extension Game: GameSceneOutput {
    
    func sceneDidSetUp(scene: SKScene) {
        setupPlayingBoard(in: scene)
    }
}
