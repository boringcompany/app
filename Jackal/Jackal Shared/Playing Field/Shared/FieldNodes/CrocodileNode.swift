//
//  CrocodileNode.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 01/06/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct CrocodileNode: FieldNodeDescribing {
    
    // MARK: Public Properties
    var moveType: MoveType = .revert
    var rotation: Rotation = .none
    var canContainObject = true
    var canStay = false
    var actionType: ActionType = .permanent
    var nodeConnector: NodeConnectorDescribing
    
    // MARK: Lifecycle
    init() {
        nodeConnector = CrocodileNodeConnector()
    }
}
