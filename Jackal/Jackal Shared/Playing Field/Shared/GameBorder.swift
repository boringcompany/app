//
//  GameBorder.swift
//  Jackal iOS
//
//  Created by Alexander Savonin on 15/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import SpriteKit

class GameBorder {
    
    static func addBorder(to board: SKNode, boardSize: CGSize) {
        let origin = CGPoint(x: -35.0, y: -35.0)
        let size = CGSize(width: boardSize.width + 70.0, height: boardSize.height + 70.0)
        let cornerZPosition = CGFloat(-2.0)
        let sideZPosition = CGFloat(-1.0)
        let cornerSize = CGSize(width: 450.0, height: 450.0)
        let sideSize = CGSize(width: 465.0, height: 150.0)
        let cornerCenter = CGPoint(x: cornerSize.width / 2.0, y: cornerSize.height / 2.0)
        let sideCenter = CGPoint(x: sideSize.width / 2.0, y: sideSize.height / 2.0)
        let sideInset = CGFloat(10.0)
        let rotations = [CGFloat(Double.pi * 1.5),
                         CGFloat(Double.pi / 2.0),
                         CGFloat(Double.pi),
                         CGFloat(0.0)]
        let cornerPositions = [cornerCenter,
                               CGPoint(x: size.width - cornerCenter.x, y: size.height - cornerCenter.y),
                               CGPoint(x: cornerCenter.x, y: size.height - cornerCenter.y),
                               CGPoint(x: size.width - cornerCenter.x, y: cornerCenter.y)]
        let sidePositions = [CGPoint(x: size.width - sideCenter.y - sideInset, y: size.height / 2.0),
                             CGPoint(x: sideCenter.y + sideInset, y: size.height / 2.0),
                             CGPoint(x: size.width / 2.0, y: sideCenter.y + sideInset),
                             CGPoint(x: size.width / 2.0, y: size.height - sideCenter.y - sideInset)]
        
        for i in 0...3 {
            let cornerTextureName = "borderCorner" + String(i + 1)
            let cornerSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: cornerTextureName),
                                                size:cornerSize)
            cornerSpriteNode.position = CGPoint(x: cornerPositions[i].x + origin.x,
                                                y: cornerPositions[i].y + origin.y)
            cornerSpriteNode.zPosition = cornerZPosition
            cornerSpriteNode.zRotation = rotations[i];
            board.addChild(cornerSpriteNode)
            
            let sideTextureName = "borderSide" + String(i + 1)
            let sideSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: sideTextureName),
                                              size:sideSize)
            sideSpriteNode.position = CGPoint(x: sidePositions[i].x + origin.x,
                                                y: sidePositions[i].y + origin.y)
            sideSpriteNode.zPosition = sideZPosition
            sideSpriteNode.zRotation = rotations[i];
            board.addChild(sideSpriteNode)
        }
    }
}
