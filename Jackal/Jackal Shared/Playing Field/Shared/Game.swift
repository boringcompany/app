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
        
        enum zPosition: CGFloat {
            
            case fieldCell = 0
            case pirate = 100
        }
    }
    
    // MARK: Private Properties
    let level: Level
    private let size: Level.Configuration.Size
    
    var stateMachine: GKStateMachine?
    
    var cells: [CellEntity] = []
    var pirates: [PirateEntity] = []
    
    var selectedPirate: PirateEntity?
    var selectedCellIndex: Int?
    
    // MARK: Public Properties
    lazy var gameScene: GameScene = {
        return GameScene.newGameScene(with: self)
    }()
    
    func cellAt(position: BoardPosition) -> CellEntity? {
        return cells.first { $0.component(ofType: BoardPositionComponent.self)?.boardPosition == position }
    }
    
    func switchNodeAt(_ p1: BoardPosition, with p2: BoardPosition) {
        
        guard let firstEntity = cellAt(position: p1),
            let secondEntity = cellAt(position: p2),
            let firstPositionComponent = firstEntity.component(ofType: BoardPositionComponent.self),
            let secondPositionComponent = secondEntity.component(ofType: BoardPositionComponent.self),
            let firstSpriteComponent = firstEntity.component(ofType: SpriteComponent.self),
            let secondSpriteComponent = secondEntity.component(ofType: SpriteComponent.self)
            else { return }
        
        let firstPoint = self.gameScene.point(at: p1.int2Position)
        let secondPoint = self.gameScene.point(at: p2.int2Position)
        
        let firstMoveAction = SKAction.move(to: secondPoint, duration: 0.3)
        let secondMoveAction = SKAction.move(to: firstPoint, duration: 0.3)
        
        firstSpriteComponent.node.run(firstMoveAction)
        secondSpriteComponent.node.run(secondMoveAction)
        
        firstPositionComponent.boardPosition = p2
        secondPositionComponent.boardPosition = p1
        
        self.level.switchNodeAt(p1, with: p2)
    }
    
    // MARK: Lifecycle
    init() {
        let configuration = Level.Configuration.standard
        size = configuration.size
        level = Level(configuration: configuration)
        level.buildGraph()
    }
    
    // MARK: Private
    private func setupPlayingBoard(in scene: SKScene) -> SKNode {
        scene.backgroundColor = SKColor(red: CGFloat(243.0/255.0),
                                        green: CGFloat(243.0/255.0),
                                        blue: CGFloat(243.0/255.0),
                                        alpha: CGFloat(1.0))
        let board = SKNode()
        
        let width = CGFloat(gameScene.cellWidth)
        let cellSize = CGSize(width: width, height: width)
        
        for x in 0..<size.width {
            for y in 0..<size.height {
                
                guard let fieldNodeInfo = level.fieldNodeInfoAt(x: x, y: y) else { continue }
                if (fieldNodeInfo is OutboundNode) { continue }
                
                let textureName = fieldNodeInfo.textureName
                let node = CellNode(texture: SKTexture(imageNamed: textureName),
                                    size: cellSize)
                
                let boardPosition = int2(x, y)
                node.position = gameScene.point(at: boardPosition)
                node.zPosition = Constants.zPosition.fieldCell.rawValue
                node.zRotation = fieldNodeInfo.rotation.cgRotation
                board.addChild(node)
                
                // entity
                let cell = CellEntity(with: fieldNodeInfo)
                cell.addComponent(SpriteComponent(node: node))
                cell.addComponent(FlipSpriteComponent())
                
                let inputHandlingComponent = InputHandlingComponent()
                node.inputHandler = inputHandlingComponent
                cell.addComponent(inputHandlingComponent)
                
                let selectionComponent = SelectionComponent()
                cell.addComponent(selectionComponent)
                
                let boardPositionComponent = BoardPositionComponent()
                boardPositionComponent.boardPosition = BoardPosition(int2: boardPosition)
                cell.addComponent(boardPositionComponent)
                
                cells.append(cell)
            }
        }
        
        let boardSize = CGSize(width: CGFloat(size.width) * cellSize.width,
                               height: CGFloat(size.height) * cellSize.height)
        GameBorder.addBorder(to: board, boardSize: boardSize)
        
        scene.addChild(board)
        
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: scene.size.width/2 - 100, y: scene.size.height/2 + 65)
        cameraNode.xScale = 1.3
        cameraNode.yScale = 1.3
        scene.addChild(cameraNode)
        scene.camera = cameraNode

        return board
    }
    
    
    private func setupPirates(on board: SKNode) {
        
        let width = CGFloat(gameScene.cellWidth)

        let pirateSize = CGSize(width: width / 3, height: width / 3)
        let pirateNode = PirateNode(size: pirateSize)
        let pirateGridPosition = int2(size.width / 2, 0)
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
            PirateSelectedState(game: self),
            FieldSelectedState(game: self),
            EndTurnState(game: self)
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
