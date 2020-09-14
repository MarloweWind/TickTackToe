//
//  LogAction.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 9/10/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

public enum LogAction {
    case playerInput(player: Player, position: GameboardPosition)
    case playerNotFoundMove(player: Player)
    case gameFinisher(winner: Player?)
    case restartGame
}

public func Log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}
