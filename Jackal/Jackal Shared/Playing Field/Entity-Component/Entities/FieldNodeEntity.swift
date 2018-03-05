//
//  FieldNodeEntity.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/01/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit

class FieldNodeEntity: GKEntity {
    
    public let info: FieldNodeDescribing
    
    init(with info: FieldNodeDescribing) {
        self.info = info
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
