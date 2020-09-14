//
//  GameState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 9/10/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    var isCompleted: Bool { get }
    
    func begin()
    
    func complete()
    
    func addMark(at position: GameboardPosition)
    
    func getNextPlayer() -> Player?
    
    func getPlayer() -> Player
}
