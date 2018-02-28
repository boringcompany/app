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
        return [EmptyNode(rotation: .none, type: .hole),
                EmptyNode(rotation: .none, type: .tree),
                EmptyNode(rotation: .none, type: .stump),
                EmptyNode(rotation: .none, type: .log),
                ArrowNode(rotation: .none, type: .unidirectionalStraight),
                ArrowNode(rotation: .none, type: .unidirectionalDiagonal),
                ArrowNode(rotation: .none, type: .bidirectionalStraight),
                ArrowNode(rotation: .none, type: .bidirectionalDiagonal),
                ArrowNode(rotation: .none, type: .threeDirectional),
                ArrowNode(rotation: .none, type: .fourDirectionalStraight),
                ArrowNode(rotation: .none, type: .fourDirectionalDiagonal)]
    }
    
    func testAssets() {
        for info in nodes.map(TextureInfo.init) {
            XCTAssert(info.texture != nil, "texture for name \(info.node.textureName) not found")
            XCTAssert(info.suit != nil, "suit for name \(info.node.suitTextureName) not found")
        }
    }
}
