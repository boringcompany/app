//
//  Level.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/01/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit

class Level {
    
    // MARK: Public Data Structures
    struct Size {
        let width: Int32
        let height: Int32
    }
    
    // MARK: Public Properties
    let graph: GKGridGraph<GKGridGraphNode>
    
    
    // MARK: Lifecycle
    init(with size: Size) {
        
        graph = GKGridGraph(fromGridStartingAt: vector_int2(x: 0, y: 0),
                            width: size.width,
                            height: size.height,
                            diagonalsAllowed: true)
    }
}
