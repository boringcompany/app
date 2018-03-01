//
//  GraphNodeConnector.swift
//  Jackal
//
//  Created by Alexander Savonin on 01/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import SpriteKit

protocol NodeConnectorDescribing {
    
    func createNodes(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, x: Int8, y: Int8)
    
    func addNodesConnections(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, x: Int8, y: Int8)
    
    func removeNodesConnections(fieldNode: FieldNodeDescribing, graph: BoardGraph<BoardGraphNode>, x: Int8, y: Int8)
}
