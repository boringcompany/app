//
//  IceNode.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 20/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct IceNode: FieldNodeDescribing {

    // MARK: Public Properties
    var moveType: MoveType = .any
    var rotation: Rotation = .none
    var canContainObject = true
    var canStay = false
    var actionType: ActionType = .permanent
    var nodeConnector: NodeConnectorDescribing
    
    // MARK: Lifecycle
    init() {
        nodeConnector = IceNodeConnector()        
    }
}
