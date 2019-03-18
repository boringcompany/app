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
    
    // MARK: Public Properties
    let inputHandler: InputHandlerProtocol
    
    // MARK: Lifecycle
    init(inputHandler: InputHandlerProtocol, with output: ControlsSceneOutput) {
        self.inputHandler = inputHandler
        self.output = output
        super.init(size: CGSize(width: 1600, height: 1600))
        scaleMode = .aspectFill
        backgroundColor = .clear
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
    }
}
