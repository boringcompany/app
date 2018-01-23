//
//  InterfaceController.swift
//  Jackal watchOS App Extension
//
//  Created by Andrey Zonov on 11/01/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    // MARK: Public Properties
    @IBOutlet var skInterface: WKInterfaceSKScene!
    
    // MARK: Lifecycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let scene = Game().gameScene
        
        // Present the scene
        self.skInterface.presentScene(scene)
        
        // Use a preferredFramesPerSecond that will maintain consistent frame rate
        self.skInterface.preferredFramesPerSecond = 30
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
