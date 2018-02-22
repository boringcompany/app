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
    let inputHandler: InputHandlerProtocol = InputHandler()
    
    var cellWidth: CGFloat {
        return Constants.cellWidth
    }
    
    // MARK: Lifecycle
    class func newGameScene(with output: GameSceneOutput) -> GameScene {
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else { abort() }
        
        scene.output = output
        scene.scaleMode = .aspectFill
        
        return scene
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
}
