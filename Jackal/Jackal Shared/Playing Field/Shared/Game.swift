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
    let level: Level
    private let size: Level.Configuration.Size
    
    var stateMachine: GKStateMachine?
    
    var fieldCells: [FieldNodeEntity] = []
    var pirates: [PirateEntity] = []
    
    var selectedPirate: PirateEntity?
    
    // MARK: Public Properties
    lazy var gameScene: GameScene = {
        return GameScene.newGameScene(with: self)
    }()
    
    // MARK: Lifecycle
    init() {
        let configuration = Level.Configuration.standard
        size = configuration.size
        level = Level(configuration: configuration)
    }
    
    // MARK: Private
    
    private func setupPlayingBoard(in scene: SKScene) -> SKNode {
        scene.backgroundColor = .blue
        let sceneSize = min(scene.size.width, scene.size.height)
        let board = SKNode()
        board.position = CGPoint(x: -sceneSize/2, y: -sceneSize/2)
        
        let width = CGFloat(gameScene.cellWidth)
        let cellSize = CGSize(width: width, height: width)
        
        for i in 0..<size.width {
            for j in 0..<size.height {
                
                guard !isCorner(x: i, y: j, height: size.height, width: size.width) else { continue }
                
                let node = CellNode(texture: SKTexture(imageNamed: "suit"),
                                    size: cellSize)
                
                let boardPosition = int2(i, j)
                node.position = gameScene.point(at: boardPosition)
                node.zPosition = Constants.zPosition.fieldCell.rawValue
                board.addChild(node)
                
                // entity
                let cell = FieldNodeEntity()
                cell.addComponent(SpriteComponent(node: node))
                
                let inputHandlingComponent = InputHandlingComponent()
                node.inputHandler = inputHandlingComponent
                cell.addComponent(inputHandlingComponent)
                
                let selectionComponent = SelectionComponent()
                cell.addComponent(selectionComponent)
                
                let boardPositionComponent = BoardPositionComponent()
                boardPositionComponent.boardPosition = BoardPosition(int2: boardPosition)
                cell.addComponent(boardPositionComponent)
                
                fieldCells.append(cell)
            }
        }
        
        scene.addChild(board)

        return board
    }
    
    
    func isCorner(x: Int32, y: Int32, height: Int32, width: Int32) -> Bool {
        let conditions: [Bool] = [x == 0, y == 0, x == width - 1, y == height - 1]
        return conditions.filter { $0 }.count == 2
    }
    
    
    private func setupPirates(on board: SKNode) {
        
        let width = CGFloat(gameScene.cellWidth)

        let pirateSize = CGSize(width: width / 3, height: width / 3)
        let pirateNode = PirateNode(size: pirateSize)
        let pirateGridPosition = int2(size.width / 2, size.height / 2)
        pirateNode.position = gameScene.point(at: pirateGridPosition)
        pirateNode.zPosition = Constants.zPosition.pirate.rawValue
        board.addChild(pirateNode)
        
        let pirate = PirateEntity()
        
        let nodeComponent = NodeComponent(node: pirateNode)
        pirate.addComponent(nodeComponent)
        
        let inputHandlingComponent = InputHandlingComponent()
        pirateNode.inputHandler = inputHandlingComponent
        pirate.addComponent(inputHandlingComponent)
        
        let selectionComponent = SelectionComponent()
        pirate.addComponent(selectionComponent)
        
        
        let boardPositionComponent = BoardPositionComponent()
        boardPositionComponent.boardPosition = BoardPosition(BoardPosition.Unit(pirateGridPosition.x),
                                                             BoardPosition.Unit(pirateGridPosition.y))
        pirate.addComponent(boardPositionComponent)
        
        pirates.append(pirate)
    }
    
    
    func setupStates() {
        
        let states: [GKState] = [
            StartTurnState(game: self),
            PirateSelectedState(game: self)
        ]
        
        self.stateMachine = GKStateMachine(states: states)
        self.stateMachine?.enter(StartTurnState.self)
    }
}

// MARK: - GameSceneOutput
extension Game: GameSceneOutput {
    
    func sceneDidSetUp(scene: SKScene) {
        let board = setupPlayingBoard(in: scene)
        setupPirates(on: board)
        setupStates()
    }
}
