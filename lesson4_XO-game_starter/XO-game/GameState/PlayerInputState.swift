//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 9/10/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

public class PlayerInputState: GameState {
    
    public private(set) var isCompleted = false
    public let markViewPrototype: MarkView // Prototype
    
    public let player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(player: Player, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView    ) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.markViewPrototype = markViewPrototype //Prototype
    }
    
    public func begin() {
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        Log(.playerInput(player: self.player, position: position))
        
        guard let gameboardView = self.gameboardView
            , gameboardView.canPlaceMarkView(at: position)
            else { return }
        
        //State
//        let markView: MarkView
//        switch self.player {
//        case .first:
//            markView = XView()
//        case .second:
//            markView = OView()
//        }
//        self.gameboard?.setPlayer(self.player, at: position)
//        self.gameboardView?.placeMarkView(markView, at: position)
//        self.isCompleted = true
//
//        guard let gameboardView = self.gameboardView
//            , gameboardView.canPlaceMarkView(at: position)
//            else { return }
        
        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        self.isCompleted = true
    }
    
    public func complete() {
        self.isCompleted = true
    }
    
    public func getNextPlayer() -> Player? {
        player.next
    }
    
    public func getPlayer() -> Player {
        player
    }
}
