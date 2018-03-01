//
//  PirateSelectedState.swift
//  Jackal
//
//  Created by Anton Tyutin on 19.02.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit


class PirateSelectedState: TurnState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        return stateClass == StartTurnState.self
            || stateClass == PirateSelectedState.self
    }
    
    
    override func didEnter(from previousState: GKState?) {
        
        let selectedPirate = self.game.selectedPirate!
        
        for pirate in self.game.pirates {
            
            let inputComponent = pirate.component(ofType: InputHandlingComponent.self)
            inputComponent?.interactionEnabled = true
            
            let selectionComponent = pirate.component(ofType: SelectionComponent.self)
            selectionComponent?.delegate = self
        }
        
        let selectedPiratePosition =
            selectedPirate.component(ofType: BoardPositionComponent.self)!.boardPosition!
        
        let availablePositions: Set<BoardPosition> =
            Set(self.game.level.availableDestinations(for: selectedPiratePosition))
        
        let filteredAvailablePositions = availablePositions.map { (position) -> BoardPosition in
            return BoardPosition(int2: position.int2Position)
        }
        
        for cell in self.game.fieldCells {
            
            guard let cellPosition =
                cell.component(ofType: BoardPositionComponent.self)?.boardPosition else { continue }
            
            let isCellAvailable = filteredAvailablePositions.contains(cellPosition)
            
            let inputComponent = cell.component(ofType: InputHandlingComponent.self)
            inputComponent?.interactionEnabled = isCellAvailable
            
            let selectionComponent = cell.component(ofType: SelectionComponent.self)
            selectionComponent?.delegate = self
            
            let spriteComponent = cell.component(ofType: SpriteComponent.self)
            if let cellNode = spriteComponent?.node as? CellNode {
                cellNode.highlighted = isCellAvailable
            }
        }
    }
    
    
    private func movePirate(_ pirate: PirateEntity, to cell: FieldNodeEntity) {
        
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
        if let relativePosition = self.game.level.relativePosition(for: piratePosition) {
            point = self.game.gameScene.point(at: cellPosition.int2Position, relativePosition: relativePosition)
        } else {
            point = self.game.gameScene.point(at: cellPosition.int2Position)
        }
        let action = SKAction.move(to: point, duration: 0.3)
        pirateNode.run(action)
    }
    
    private func updateState(for cell: FieldNodeEntity) {
        self.movePirate(self.game.selectedPirate!, to: cell)
        
        self.game.selectedPirate?.component(ofType: SelectionComponent.self)?.isSelected = !cell.info.canStay
        if !cell.info.canStay {
            self.stateMachine?.enter(PirateSelectedState.self)
        }
    }
}


// MARK: - SelectionComponentDelegate

extension PirateSelectedState: SelectionComponentDelegate {
    
    
    func entitySelected(_ entity: GKEntity) {
        
        switch entity {
        case let pirate as PirateEntity where pirate != self.game.selectedPirate:
            
            self.game.selectedPirate = pirate
            self.stateMachine?.enter(PirateSelectedState.self)
            
        case let cell as FieldNodeEntity:
            self.updateState(for: cell)
            
        default:
            break
        }
    }
    
    
    func entityDeselected(_ entity: GKEntity) {
        
        switch entity {
        case let pirate as PirateEntity where self.game.selectedPirate == pirate:
            
            self.game.selectedPirate = nil
            self.stateMachine?.enter(StartTurnState.self)
            
            for cell in self.game.fieldCells {
                let spriteComponent = cell.component(ofType: SpriteComponent.self)
                if let cellNode = spriteComponent?.node as? CellNode {
                    cellNode.highlighted = false
                }
            }
            
        case let cell as FieldNodeEntity:
            self.updateState(for: cell)
            
        default:
            break
        }
    }
}
