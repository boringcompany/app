//
//  UserControls.swift
//  Jackal
//
//  Created by Andrey Zonov on 26/06/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import SpriteKit

class UserControls {
    
    // MARK: Public Properties
    let inputHandler: InputHandlerProtocol
    
    lazy var controlsScene: ControlsScene = {
        return ControlsScene(inputHandler: inputHandler, with: self)
    }()
    
    // MARK: Lifecycle
    init(inputHandler: InputHandlerProtocol) {
        self.inputHandler = inputHandler
    }
}

extension UserControls: ControlsSceneOutput {
    
    func sceneDidSetUp(scene: SKScene) {
        let pirateNode = PirateNode(size: CGSize(width: 50, height: 50))
        pirateNode.position = CGPoint(x: 0, y: 0)
        scene.addChild(pirateNode)
    }
}
