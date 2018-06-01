//
//  PlaneNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 31/05/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation

struct PlaneNode: FieldNodeDescribing {
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation = .none
    var canContainObject = true
    var canStay = true
    var actionType: ActionType = .once
    var textureName: String
    
    // MARK: Lifecycle
    init() {
        moveType = .any
        textureName = "plane"
    }
}
