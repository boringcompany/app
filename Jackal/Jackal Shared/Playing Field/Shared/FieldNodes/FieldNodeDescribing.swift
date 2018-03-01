//
//  FieldNodeDescribable.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import SpriteKit

protocol FieldNodeDescribing {
    
    var moveType: MoveType { get }
    
    var rotation: Rotation { get }
    
    var suitTextureName: String { get }
    
    var textureName: String { get }
    
    var currentTextureName: String { get }
    
    /// Возможность заходить с предметами
    var canContainObject: Bool { get }
    
    /// Возможность стоять на клетке
    var canStay: Bool { get }
    
    /// Тип действия (постоянно, при открытии)
    var actionType: ActionType { get }
    
    var isOpen: Bool { get }
    
    /// Toggling isOpen property if possible
    mutating func toggle()
    
    var nodeConnector: NodeConnectorDescribing { get }
    
    func relativePosition(boardPosition: BoardPosition) -> Position?
}

extension FieldNodeDescribing {
    
    var suitTextureName: String {
        return "suit"
    }
    
    var currentTextureName: String {
        return isOpen ? textureName : suitTextureName
    }
    
    var textureName: String {
        return String(describing: Self.self)
    }
    
    var nodeConnector: NodeConnectorDescribing {
        return DefaultNodeConnector()
    }
    
    func relativePosition(boardPosition: BoardPosition) -> Position? {
        return nil
    }
}
