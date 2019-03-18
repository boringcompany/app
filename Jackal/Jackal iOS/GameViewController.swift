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
    
    @IBOutlet private var pinchGestureRecognizer: UIPinchGestureRecognizer?
    @IBOutlet private var panGestureRecognizer: UIPanGestureRecognizer?
    
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
    
    @IBAction func moveGameScene(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let scene = gameView.scene else { return }
        guard let camera = scene.camera else { return }
        
        let translation = gestureRecognizer.translation(in: gameView)
        
        let offsetX: CGFloat = 100
        let offsetY: CGFloat = 100
        var pos = camera.position
        pos.x = max(min(pos.x - translation.x, scene.size.width - offsetX), offsetX)
        pos.y = max(min(pos.y + translation.y, scene.size.height - offsetY), offsetY)
        camera.position = pos
        
        gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: gameView)
    }
    
}
