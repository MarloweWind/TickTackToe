//
//  Mover.swift
//  XO-game
//
//  Created by Алексей Мальков on 13.09.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class Mover {
    public func makeMove(at position: GameboardPosition, from player: Player, gBoardView: GameboardView, gameboard: Gameboard) {
        let markView = player.markViewPrototype.copy()
        
        gameboard.setPlayer(player, at: position)
        
        if !gBoardView.canPlaceMarkView(at: position) {
            gBoardView.removeMarkView(at: position)
        }
        
        gBoardView.placeMarkView(markView as! MarkView, at: position)
        
        Log(.playerInput(player: player, position: position))
    }
}
