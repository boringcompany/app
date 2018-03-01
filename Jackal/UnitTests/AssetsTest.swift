//
//  FieldNodesTests.swift
//  UnitTests
//
//  Created by Andrey Zonov on 28/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import XCTest
import SpriteKit

class FieldNodesTests: XCTest {
    
    struct TextureInfo {
        let node: FieldNodeDescribing
        let texture: UIImage?
        let suit: UIImage?
        
        init(node: FieldNodeDescribing) {
            self.node = node
            texture = UIImage(named: node.textureName)
            suit = UIImage(named: node.suitTextureName)
        }
    }
    
    var nodes: [FieldNodeDescribing] {
        return [EmptyNode(type: .hole),
                EmptyNode(type: .tree),
                EmptyNode(type: .stump),
                EmptyNode(type: .log),
                ArrowNode(type: .unidirectionalStraight),
                ArrowNode(type: .unidirectionalDiagonal),
                ArrowNode(type: .bidirectionalStraight),
                ArrowNode(type: .bidirectionalDiagonal),
                ArrowNode(type: .threeDirectional),
                ArrowNode(type: .fourDirectionalStraight),
                ArrowNode(type: .fourDirectionalDiagonal),
                HorseNode(),
                TurntableNode(type: .twoSteps),
                TurntableNode(type: .threeSteps),
                TurntableNode(type: .fourSteps),
                TurntableNode(type: .fiveSteps)]
    }
    
    func testAssets() {
        for info in nodes.map(TextureInfo.init) {
            XCTAssert(info.texture != nil, "texture for name \(info.node.textureName) not found")
            XCTAssert(info.suit != nil, "suit for name \(info.node.suitTextureName) not found")
        }
    }
}
