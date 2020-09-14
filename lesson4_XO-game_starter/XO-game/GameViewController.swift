//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

public class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet weak var modeLabel: UILabel!
    
    var gameMode: GameModeEnum = .pvp
    let maxMovePerPlayer = 5
    
    private let gameboard = Gameboard()
    private lazy var referee = Referee(gameboard: self.gameboard)
    private var currentState: GameState! {
        didSet {
            if let currentState = self.currentState {
                currentState.begin()
            }
        }
    }

    private let moveInvoker = MoveInvoker.shared
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        
        switch gameMode {
        case .pve:
            modeLabel.text = "PVE"
        case .strategy:
            modeLabel.text = "Strategy"
        default:
            modeLabel.text = "PVP"
        }
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            if let position = position {
                    let maxCommandToPerform = ((self.maxMovePerPlayer * 2) - 1)
                    
                if (self.gameMode == .strategy && self.moveInvoker.commands.count == maxCommandToPerform)  {
                        self.currentState.addMark(at: position)
                        self.moveInvoker.perform()
                    }
                } else {
                    self.currentState.complete()
                }
                
                if let winner = self.referee.determineWinner() {
                    self.currentState = GameEndedState(winner: winner, gameViewController: self)
                    return
                }
                
                if let position = position {
                    self.currentState.addMark(at: position)
                }
                
                if self.currentState.isCompleted {
                    self.goToNextState()
                }
            }
    }
    
    private func goToFirstState() {
        // Текущий стейт должен быть пустым
        currentState = nil
        goToNextState()
    }

    private func goToNextState() {
        var player: Player
        
        if let currentState = self.currentState,
            let nextPlayer = currentState.getNextPlayer()
        {
            player = nextPlayer
        } else {
            player = .first
        }
        
        // В зависимости от выбранного режима стартуем тот или иной стэйт
        if gameMode == .pvp {
            self.currentState = PlayerInputState(player: player,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView,
                                                 markViewPrototype: player.markViewPrototype)
        } else if gameMode == .strategy {
            self.currentState = StrategyInputState(player: player,
                                                gameViewController: self,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView,
                                                markViewPrototype: player.markViewPrototype, maxMovePerPlayer: maxMovePerPlayer)
            
        } else {
            self.currentState = aiState(player: player,
                                                   gameViewController: self,
                                                   gameboard: gameboard,
                                                   gameboardView: gameboardView,
                                                   markViewPrototype: player.markViewPrototype)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameboardView.clear()
        gameboard.clear()
        moveInvoker.reset()
        goToFirstState()
        
        Log(.restartGame)
    }
}

