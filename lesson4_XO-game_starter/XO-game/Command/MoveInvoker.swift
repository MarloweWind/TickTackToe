//
//  MoveInvoker.swift
//  XO-game
//
//  Created by Алексей Мальков on 13.09.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class MoveInvoker {
    static let shared = MoveInvoker()
    var commands: [MoveCommand] = []
    var mover = Mover()
    
    func addMove(at position: GameboardPosition, from player: Player, gBoardView: GameboardView, gameboard: Gameboard) {
        commands.append(MoveCommand(at: position, from: player, gBoardView: gBoardView, gameboard: gameboard))
    }
    
    func perform(){
        if commands.count > 0 {
            let halfArray = commands.count/2
            
            for i in 0..<halfArray {
                if commands.indices.contains(i) {
                    let firstPlayerCommand = commands[i]
                    self.mover.makeMove(at: firstPlayerCommand.position, from: firstPlayerCommand.player, gBoardView: firstPlayerCommand.gBoardView, gameboard: firstPlayerCommand.gameboard)
                    let secondPlayerCommand = commands[(i + halfArray)]
                    self.mover.makeMove(at: secondPlayerCommand.position, from: secondPlayerCommand.player, gBoardView: secondPlayerCommand.gBoardView, gameboard: secondPlayerCommand.gameboard)
                }
            }
        }
    }    
    func reset() {
        commands.removeAll()
    }
}
