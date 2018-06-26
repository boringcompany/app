//
//  ControlsScene.swift
//  Jackal
//
//  Created by Andrey Zonov on 26/06/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import SpriteKit

protocol ControlsSceneOutput: class {
    func sceneDidSetUp(scene: SKScene)
}

class ControlsScene: SKScene {
    
    // MARK: Private Properties
    private var output: ControlsSceneOutput?
    
    // MARK: Lifecycle
    class func newGameScene(with output: ControlsSceneOutput) -> ControlsScene {
        guard let scene = SKScene(fileNamed: "ControlsScene") as? ControlsScene else { abort() }
        
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
    }
}
