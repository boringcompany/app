//
//  GameViewController.swift
//  Jackal iOS
//
//  Created by Andrey Zonov on 11/01/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet private var gameView: SKView!
    @IBOutlet private var controlsView: SKView!
    
    private var pinchGestureRecognizer: UIPinchGestureRecognizer?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputHandler = InputHandler()
        let gameScene = Game(inputHandler: inputHandler).gameScene
        
        gameView.presentScene(gameScene)
        gameScene.camera?.xScale = 1.8
        gameScene.camera?.yScale = 1.8
        
        let controlsScene = UserControls(inputHandler: inputHandler).controlsScene
        
        controlsView.allowsTransparency = true
        controlsView.presentScene(controlsScene)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Gestures
    
    @IBAction func scaleGameScene(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard let camera = gameView.scene?.camera else { return }
        
        let scale = max(min(camera.yScale / gestureRecognizer.scale, 2), 0.4)
        camera.xScale = scale
        camera.yScale = scale
        gestureRecognizer.scale = 1.0
    }
    
}
