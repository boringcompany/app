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
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputHandler = InputHandler()
        let gameScene = Game(inputHandler: inputHandler).gameScene
        
        gameView.presentScene(gameScene)
        
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
}
