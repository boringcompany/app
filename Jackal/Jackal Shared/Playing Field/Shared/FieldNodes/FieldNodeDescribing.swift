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
}
