//
//  GameViewController.swift
//  Jackal macOS
//
//  Created by Andrey Zonov on 11/01/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {
    
    @IBOutlet private var gameView: SKView!
    @IBOutlet private var controlsView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputHandler = InputHandler()
        let gameScene = Game(inputHandler: inputHandler).gameScene
        
        gameView.presentScene(gameScene)
        
        let controlsScene = UserControls(inputHandler: inputHandler).controlsScene
        
        controlsView.allowsTransparency = true
        controlsView.presentScene(controlsScene)
    }
    
    override func scrollWheel(with event: NSEvent) {
        guard let camera = gameView.scene?.camera else { return }
        
        let scale = max(min(camera.yScale + (event.scrollingDeltaY / 100), 2), 0.2)
        camera.xScale = scale
        camera.yScale = scale
    }
}

