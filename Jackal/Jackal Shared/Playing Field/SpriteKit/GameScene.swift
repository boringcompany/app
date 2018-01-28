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
    
    // MARK: Private Properties
    private var output: GameSceneOutput?
    private let inputHandler = InputHandler()
    
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
}
