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
    
    // MARK: Lifecycle
    class func newGameScene(with output: GameSceneOutput) -> GameScene {
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else { abort() }
        
        scene.output = output
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // MARK: Public
    func setUpScene() {
        output?.sceneDidSetUp(scene: self)
    }
}
//TODO: https://trello.com/c/3y4H0ZO8/9-обсудить-реализацию-input-ов-для-различных-ос-macos-tvos-ios-watchos
#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
    }
    
    override func mouseDragged(with event: NSEvent) {
    }
    
    override func mouseUp(with event: NSEvent) {
    }

}
#endif

