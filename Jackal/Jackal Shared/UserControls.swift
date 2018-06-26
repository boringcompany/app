//
//  UserControls.swift
//  Jackal
//
//  Created by Andrey Zonov on 26/06/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation

class UserControls {
    
    // MARK: Public Properties
    lazy var controlsScene: GameScene = {
        return GameScene.newGameScene(with: self)
    }()
}
