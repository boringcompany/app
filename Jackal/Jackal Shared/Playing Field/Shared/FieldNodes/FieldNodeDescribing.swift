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
    
    var textureName: String { get }
    
    /// Возможность заходить с предметами
    var canContainObject: Bool { get }
    
    /// Возможность стоять на клетке
    var canStay: Bool { get }
    
    /// Тип действия (постоянно, при открытии)
    var actionType: ActionType { get }
    
    var nodeConnector: NodeConnectorDescribing { get }
    
    func relativePosition(boardPosition: BoardPosition) -> Position?
}

extension FieldNodeDescribing {
    
    var textureName: String {
        return String(describing: Self.self)
    }
    
    var nodeConnector: NodeConnectorDescribing {
        return DefaultNodeConnector()
    }
    
    func relativePosition(boardPosition: BoardPosition) -> Position? {
        return nil
    }
    
    func rotatedMoveType() -> MoveType {
        switch self.moveType {
            
        case .oneOf(let moves):
            return .oneOf(moves.map { $0.moveWithRotation(self.rotation) })
            
        default:
            return self.moveType
        }
    }
}
