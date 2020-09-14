//
//  MoveCommand.swift
//  XO-game
//
//  Created by Алексей Мальков on 13.09.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class MoveCommand {
    var position: GameboardPosition
    var player: Player
    var gBoardView: GameboardView
    var gameboard: Gameboard
    
    init(at position: GameboardPosition, from player: Player, gBoardView: GameboardView, gameboard: Gameboard) {
        self.position = position
        self.gBoardView = gBoardView
        self.player = player
        self.gameboard = gameboard
    }
}
