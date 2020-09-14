//
//  TitleScreenViewController.swift
//  XO-game
//
//  Created by Алексей Мальков on 12.09.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import UIKit

class TitleScreenViewController: UIViewController {
    
    private var changedGameModeState: GameModeEnum = .pvp

    @IBOutlet weak var gameModeState: UISegmentedControl!
        
    @IBAction func gameModeChanged(_ sender: Any) {
        switch gameModeState.selectedSegmentIndex {
        case 1:
            changedGameModeState = .pve
        case 2:
            changedGameModeState = .strategy
        default:
            changedGameModeState = .pvp
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GameViewController,
            let id = segue.identifier,
            id == "startGame"
        {
            destination.gameMode = changedGameModeState
        }
    }
    
    

}
