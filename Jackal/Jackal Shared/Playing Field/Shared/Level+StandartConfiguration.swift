//
//  Level+StandartConfiguration.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation

extension Level.Configuration.Size {
    
    static var standard = Level.Configuration.Size(width: 11, height: 11)
}

extension Level.Configuration {
    
    static var standard: Level.Configuration {
        let size = Size.standard
        var fields: [FieldNodeAmount] = []
        
        fields.append(FieldNodeAmount(node: EmptyNode(type: .hole),
                                      amount: 4))
        
        fields.append(FieldNodeAmount(node: EmptyNode(type: .log),
                                      amount: 4))
        
        fields.append(FieldNodeAmount(node: EmptyNode(type: .stump),
                                      amount: 4))
        
        fields.append(FieldNodeAmount(node: EmptyNode(type: .tree),
                                      amount: 4))
        
        fields.append(FieldNodeAmount(node: ArrowNode(type: .unidirectionalStraight),
                                      amount: 3))
        
        fields.append(FieldNodeAmount(node: ArrowNode(type: .unidirectionalDiagonal),
                                      amount: 3))
        
        fields.append(FieldNodeAmount(node: ArrowNode(type: .bidirectionalStraight),
                                      amount: 3))
        
        fields.append(FieldNodeAmount(node: ArrowNode(type: .bidirectionalDiagonal),
                                      amount: 3))
        
        fields.append(FieldNodeAmount(node: ArrowNode(type: .threeDirectional),
                                      amount: 3))
        
        fields.append(FieldNodeAmount(node: ArrowNode(type: .fourDirectionalStraight),
                                      amount: 3))
        
        fields.append(FieldNodeAmount(node: ArrowNode(type: .fourDirectionalDiagonal),
                                      amount: 3))
        
        //TODO: remove stubs when all kinds of nodes will b ready
        let amount = fields.map {$0.amount}.reduce(0) { $0 + $1 }
        fields.append(FieldNodeAmount(node: EmptyNode(type: .hole),
                                      amount: UInt(size.width * size.height) - amount))
        
        return Level.Configuration(size: size, amountOfFields: fields)
    }
}
