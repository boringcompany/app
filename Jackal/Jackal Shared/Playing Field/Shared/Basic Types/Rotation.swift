//
//  Rotation.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import CoreGraphics

enum Rotation: Int {
    case none
    case left90
    case left180
    case left270
    
    var cgRotation: CGFloat {
        switch self {
            
        case .none:
            return CGFloat(0.0)
            
        case .left90:
            return CGFloat(Double.pi * 0.5)
            
        case .left180:
            return CGFloat(Double.pi)
            
        case .left270:
            return CGFloat(Double.pi * 1.5)
            
        }
    }
}
