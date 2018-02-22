//
//  FieldNodeDescribable.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import SpriteKit

protocol FieldNodeDescribable {
    
    var moveType: MoveType { get }
    var rotation: Rotation { get }
}
