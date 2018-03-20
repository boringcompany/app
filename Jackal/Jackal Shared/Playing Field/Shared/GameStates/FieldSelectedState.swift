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
        
        guard let field = self.game.selectedField else {
            assertionFailure("Cannot get into \(FieldSelectedState.self) without any field selected")
            return
        }
        
        for pirate in self.game.pirates {
            
            pirate.setSelectable(false)
        }
        
        self.movePirate(pirate, to: field) {
            
            if field.info.canStay {
                self.stateMachine?.enter(EndTurnState.self)
            } else {
                self.stateMachine?.enter(PirateSelectedState.self)
            }
        }
    }
    
    
    
    private func movePirate(_ pirate: PirateEntity,
                            to cell: FieldNodeEntity,
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
            point = self.game.gameScene.point(at: cellPosition.int2Position, relativePosition: relativePosition)
        } else {
            point = self.game.gameScene.point(at: cellPosition.int2Position)
        }
        let moveAction = SKAction.move(to: point, duration: 0.3)
        cell.component(ofType: FlipSpriteComponent.self)?.flip(to: cell.texture)
        
        pirateNode.run(moveAction)
        pirateNode.run(moveAction, completion: completion)
    }
    
    
    private func deselectPirate() {
        
    }
}
