//
//  OutboundNode.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 14/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct OutboundNode: FieldNodeDescribing {
    
    // MARK: Public Properties
    var moveType: MoveType = .none
    var rotation: Rotation = .none
    var canContainObject = false
    var canStay = false
    var actionType: ActionType = .permanent
    var nodeConnector: NodeConnectorDescribing
    
    // MARK: Lifecycle
    init() {
        nodeConnector = OutboundNodeConnector()
    }
}
