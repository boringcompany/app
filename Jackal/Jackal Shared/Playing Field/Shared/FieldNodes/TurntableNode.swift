//
//  TurntableNode.swift
//  Jackal
//
//  Created by Alexander Savonin on 28/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

struct TurntableNode: FieldNodeDescribing {
    
    // MARK: Public Data Structures
    enum `Type`: String {
        case twoSteps
        case threeSteps
        case fourSteps
        case fiveSteps
    }
    
    // MARK: Public Properties
    var moveType: MoveType
    var rotation: Rotation = .none
    var canContainObject = true
    var canStay = true
    var actionType: ActionType = .permanent
    var textureName: String
    var nodeConnector: NodeConnectorDescribing
    var positions: [Position]
    var stepsCount: Int {
        return positions.count
    }
    
    // MARK: Lifecycle
    init(type: Type) {
        let moves: [Move] = [Move(x: -1, y: -1),
                             Move(x:  0, y: -1),
                             Move(x: +1, y: -1),
                             Move(x: -1, y:  0),
                             Move(x: +1, y:  0),
                             Move(x: -1, y: +1),
                             Move(x:  0, y: +1),
                             Move(x: +1, y: +1)]
        moveType = .oneOf(moves)
        let info = TurntableNode.info(for: type)
        positions = info.positions
        textureName = info.textureName
        nodeConnector = TurntableNodeConnector()
    }
    
    // MARK: Private
    private static func info(for type: Type) -> (positions: [Position], textureName: String) {
        let positions: [Position]
        let textureName: String = type.rawValue
        
        switch type {
        case .twoSteps:
            positions = [Position(x: -0.3, y: -0.3),
                         Position(x: 0.25, y: 0.3)]
            
        case .threeSteps:
            positions = [Position(x: 0.3, y: -0.3),
                         Position(x: -0.1, y: 0),
                         Position(x: 0.3, y: 0.3)]
            
        case .fourSteps:
            positions = [Position(x: 0.3, y: -0.3),
                         Position(x: -0.25, y: -0.15),
                         Position(x: 0.2, y: 0.2),
                         Position(x: -0.2, y: 0.4)]
            
        case .fiveSteps:
            positions = [Position(x: 0.35, y: 0.3),
                         Position(x: 0, y: 0.3),
                         Position(x: -0.3, y: 0.05),
                         Position(x: -0.15, y: -0.25),
                         Position(x: 0.3, y: -0.3)]
        }
        return (positions, textureName)
    }
    
    func relativePosition(boardPosition: BoardPosition) -> Position? {
        return positions[Int(boardPosition.z)]
    }
}
