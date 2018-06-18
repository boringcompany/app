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
            
            self.movePirate(pirate, to: cell)
        }
        
        guard let cellIndex = self.game.selectedCellIndex else {
            assertionFailure("Cannot get into \(FieldSelectedState.self) without any field selected")
            return
        }
        
        let cell = self.game.cells[cellIndex]
        
        self.performCellAction(cell.info.actionType)
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
            
            let openedCellInfo = self.game.level.openCell(x: Int(position.x), y: Int(position.y))
            self.game.cells[cellIndex].info = openedCellInfo
            
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
                            to cell: CellEntity) {
        
        guard
            let cellPosition = cell.component(ofType: BoardPositionComponent.self)?.boardPosition,
            let pirateNode = pirate.component(ofType: NodeComponent.self)?.node,
            let piratePositionComponent = pirate.component(ofType: BoardPositionComponent.self),
            var piratePosition = piratePositionComponent.boardPosition
            else { return }
        
        let currentPosition = piratePosition
        let currentNodeInfo = self.game.level.fieldNodeInfoAt(position: currentPosition)
        
        let availablePositions = self.game.level.availableDestinations(for: currentPosition)
        let availablePositionsInCell = availablePositions.filter { $0.int2Position == cellPosition.int2Position }
        assert(availablePositionsInCell.count == 1, "There is more than 1 or no available positions in a cell")
        
        piratePosition = availablePositionsInCell[0]
        piratePositionComponent.boardPosition = piratePosition
        
        if currentNodeInfo is ShipNode && cell.info is SeaNode {
            self.game.switchNodeAt(currentPosition, with: cellPosition)
        }
        
        let piratePoint: CGPoint
        if let relativePosition = cell.info.relativePosition(boardPosition: piratePosition) {
            piratePoint = self.game.gameScene.point(at: cellPosition.int2Position,
                                                    relativePosition: relativePosition)
        } else {
            piratePoint = self.game.gameScene.point(at: cellPosition.int2Position)
        }
        let pirateMoveAction = SKAction.move(to: piratePoint, duration: 0.3)
        
        pirateNode.run(pirateMoveAction, completion: {
            self.refreshPirateState(pirate,
                                    cell: cell,
                                    previousPosition: currentPosition)
        })
    }
    
    
    private func refreshPirateState(_ pirate: PirateEntity,
                                    cell: CellEntity,
                                    previousPosition: BoardPosition) {
        if cell.info.canStay {
            self.stateMachine?.enter(EndTurnState.self)
        } else {
            if case .revert = cell.info.moveType {
                let previousNodeInfo = self.game.level.fieldNodeInfoAt(position: previousPosition)
                if let arrowNodeInfo = previousNodeInfo as? ArrowNode,
                    case .oneOf(let moves) = arrowNodeInfo.moveType,
                    moves.count == 1 {
                    // TODO: Kill pirate
                    self.stateMachine?.enter(EndTurnState.self)
                    return
                }
                if let previousCell = self.game.cellAt(position: BoardPosition(int2: previousPosition.int2Position)) {
                    self.movePirate(pirate, to: previousCell)
                } else {
                    self.stateMachine?.enter(EndTurnState.self)
                }
            } else {
                self.stateMachine?.enter(PirateSelectedState.self)
            }
        }
    }
    
    private func performCellAction(_ action: ActionType) {
        switch action {
        case .showCoins(let amountOfCoins):
            addCoins(amount: amountOfCoins)
            
        default:
            break
        }
        
        return
    }
    
    private func deselectPirate() {
        
    }
    
    private func addCoins(amount: UInt) {
        guard let cellIndex = self.game.selectedCellIndex else {
            assertionFailure("Cannot get into \(FieldSelectedState.self) without any field selected")
            return
        }
        
        let cell = self.game.cells[cellIndex]
        
        guard let position = cell.component(ofType: BoardPositionComponent.self)?.boardPosition else {
            assertionFailure("Selected cell \(cell) doesn't have board position")
            return
        }
        
        guard cell.info is GoldNode else {
            assertionFailure("Attempting to add coins not to the GoldNode")
            return
        }
        
        game.addCoinsAmount(amount, at: position)
    }
}
