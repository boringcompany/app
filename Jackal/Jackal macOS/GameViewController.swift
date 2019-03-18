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
        gameScene.nextResponder = self
        
        gameView.presentScene(gameScene)
        
        let controlsScene = UserControls(inputHandler: inputHandler).controlsScene
        
        controlsView.allowsTransparency = true
        controlsView.presentScene(controlsScene)
    }
    
    override func scrollWheel(with event: NSEvent) {
        guard let camera = gameView.scene?.camera else { return }
        
        let scale = max(min(camera.yScale + (event.scrollingDeltaY / 100), 1.5), 0.4)
        camera.xScale = scale
        camera.yScale = scale
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard let scene = gameView.scene else { return }
        guard let camera = scene.camera else { return }
        
        let offsetX: CGFloat = 210
        let offsetY: CGFloat = 150
        var pos = camera.position
        pos.x = max(min(pos.x - event.deltaX, scene.size.width - offsetX), offsetX)
        pos.y = max(min(pos.y + event.deltaY, scene.size.height - offsetY), offsetY)
        camera.position = pos
    }
}

