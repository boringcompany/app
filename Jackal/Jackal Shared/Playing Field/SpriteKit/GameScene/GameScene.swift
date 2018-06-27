//
//  GameScene.swift
//  Jackal Shared
//
//  Created by Andrey Zonov on 11/01/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import SpriteKit

protocol GameSceneOutput: class {
    func sceneDidSetUp(scene: SKScene)
}


class GameScene: SKScene {
    
    // MARK: Private Data Structures
    private enum Constants {
        
        static let cellWidth: CGFloat = 90
    }
    
    
    // MARK: Private Properties
    private var output: GameSceneOutput?
    
    // MARK: Public Properties
    let inputHandler: InputHandlerProtocol
    
    var cellWidth: CGFloat {
        return Constants.cellWidth
    }
    
    // MARK: Lifecycle
    init(inputHandler: InputHandlerProtocol, with output: GameSceneOutput) {
        self.inputHandler = inputHandler
        self.output = output
        super.init(size: CGSize(width: 1600, height: 1600))
        scaleMode = .aspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func setUpScene() {
        output?.sceneDidSetUp(scene: self)
        setupInputs()
    }
    
    func point(at gridPosition: int2) -> CGPoint {
        
        let point = CGPoint(x: cellWidth * CGFloat(gridPosition.x) + cellWidth * 0.5,
                            y: cellWidth * CGFloat(gridPosition.y) + cellWidth * 0.5)
        
        return point
    }
    
    func point(at gridPosition: int2, relativePosition: Position) -> CGPoint {
        
        let point = CGPoint(x: cellWidth * CGFloat(gridPosition.x) + cellWidth * (0.5 + relativePosition.x),
                            y: cellWidth * CGFloat(gridPosition.y) + cellWidth * (0.5 + relativePosition.y))
        
        return point
    }
}
