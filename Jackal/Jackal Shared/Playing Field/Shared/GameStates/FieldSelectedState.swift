//
//  FieldSelectedState.swift
//  Jackal
//
//  Created by Anton Tyutin on 19.03.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit


class FieldSelectedState: TurnState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        return stateClass == EndTurnState.self
            || stateClass == PirateSelectedState.self
    }
    
    
    override func didEnter(from previousState: GKState?) {
        
        guard let pirate = self.game.selectedPirate else {
            assertionFailure("Cannot get into \(FieldSelectedState.self) without any pirate selected")
            return
        }

        for pirate in self.game.pirates {
            
            pirate.setSelectable(false)
        }
        
        self.openSelectedCellIfNeeded { cell in
            
            self.movePirate(pirate, to: cell, completion: {})
            
            if cell.info.canStay {
                self.stateMachine?.enter(EndTurnState.self)
            } else {
                self.stateMachine?.enter(PirateSelectedState.self)
            }
        }
    }
    
    
    private func openSelectedCellIfNeeded(completion: @escaping (CellEntity) -> Void) {
        
        guard let cellIndex = self.game.selectedCellIndex else {
            assertionFailure("Cannot get into \(FieldSelectedState.self) without any field selected")
            return
        }
        
        let cell = self.game.cells[cellIndex]
        
        guard let position = cell.component(ofType: BoardPositionComponent.self)?.boardPosition else {
            assertionFailure("Selected cell \(cell) doesn't have board position")
            return
        }
        
        if cell.info is SuitNode {
            
            let openedCellInfo = self.game.level.fieldNodeInfoAt(x: Int(position.x), y: Int(position.y))
            self.game.cells[cellIndex] = CellEntity(with: openedCellInfo)
            
            let texture = SKTexture(imageNamed: openedCellInfo.textureName)
            let flipComponent = cell.component(ofType: FlipSpriteComponent.self)
            flipComponent?.flip(to: texture) {
                completion(cell)
            }
            
        } else {
            completion(cell)
        }
    }

    
    private func movePirate(_ pirate: PirateEntity,
                            to cell: CellEntity,
                            completion: @escaping () -> Void) {
        
        guard
            let cellPosition = cell.component(ofType: BoardPositionComponent.self)?.boardPosition,
            let pirateNode = pirate.component(ofType: NodeComponent.self)?.node,
            let piratePositionComponent = pirate.component(ofType: BoardPositionComponent.self),
            var piratePosition = piratePositionComponent.boardPosition
            else { return }
        
        if piratePosition.int2Position == cellPosition.int2Position {
            piratePosition.z += 1
        } else {
            piratePosition = cellPosition
        }
        piratePositionComponent.boardPosition = piratePosition
        
        let point: CGPoint
        if let relativePosition = cell.info.relativePosition(boardPosition: piratePosition) {
            point = self.game.gameScene.point(at: cellPosition.int2Position,
                                              relativePosition: relativePosition)
        } else {
            point = self.game.gameScene.point(at: cellPosition.int2Position)
        }
        let moveAction = SKAction.move(to: point, duration: 0.3)
        
        pirateNode.run(moveAction, completion: completion)
    }
    
    
    private func deselectPirate() {
        
    }
}
