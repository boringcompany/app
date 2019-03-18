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
        let size = scene.size
        let playersCount = 4
        let playerIconDimension = min(size.height / 8, 150)
        let playerIconSize = CGSize(width: playerIconDimension, height: playerIconDimension)
        let offset = playerIconDimension * (CGFloat(playersCount) / 2)
        for i in 0..<playersCount {
            let playerNode = CellNode(texture: SKTexture(imageNamed: "player"),
                                      size: playerIconSize)
            
            let y = size.height / 2 - offset + playerIconDimension * CGFloat(i)
            playerNode.position = CGPoint(x: playerIconDimension / 2, y: y)
            scene.addChild(playerNode)
        }
    }
}
