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
        let empty = FieldNoteAmount(node: EmptyFieldNode.self,
                                    amount: UInt(Size.standard.height * Size.standard.width))
        return Level.Configuration(size: Size.standard,
                                   amountOfFields: [empty])
    }
}
