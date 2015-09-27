//
//  GameController.swift
//  UnderDaSeaFight
//
//  Created by The Deblings on 25/09/2015.
//  Copyright © 2015 Kestrel Design. All rights reserved.
//

import Foundation

class GameController {
    private var leftPlayer: Player?
    private var rightPlayer: Player?
    enum GameState {
        case LEFTPLAYER
        case RIGHTPLAYER
        case GAME
        case ENDGAME
    }
    enum CritterType {
        case SEAHORSE
        case CRAB
    }
    var game = GameState.LEFTPLAYER
    var screen: ViewController!
    
    init(screen: ViewController) {
        self.screen = screen
        screen.showPlayer1Screen()
    }
    
    func playerChoseACritter(var nameOfPlayer: String?, critter: CritterType){
        if game == .LEFTPLAYER {
            if nameOfPlayer == "" {
                nameOfPlayer = "Player 1"
            }
            leftPlayer = Player(name: nameOfPlayer!, type: critter)
            game = .RIGHTPLAYER
            screen.showPlayer2Screen()
        } else if game == .RIGHTPLAYER {
            if nameOfPlayer == "" {
                nameOfPlayer = "Player 2"
            }
            rightPlayer = Player(name: nameOfPlayer!, type: critter)
            game = .GAME
            screen.showMainGameScreen(leftPlayer!.type, rightCritter: rightPlayer!.type)
        }
    }
    
    func leftPlayerAttacked(){
        let attackAmount = rightPlayer!.getHitByRandomPower()
        screen.print("\(leftPlayer!.name) attacked, \(rightPlayer!.name) lost \(attackAmount) hp!")
        screen.showRightPlayerHp(rightPlayer!.hp)
        if !rightPlayer!.isAlive {
            game = .ENDGAME
            screen.killRightPlayer(rightPlayer!.type)
            screen.shout("\(leftPlayer!.name) wins!!!")
        } else {
            screen.disableLeftPlayer(Int(arc4random_uniform(3)))
        }
    }
    
    func rightPlayerAttacked(){
        let attackAmount = leftPlayer!.getHitByRandomPower()
        screen.print("\(rightPlayer!.name) attacked, \(leftPlayer!.name) lost \(attackAmount) hp!")
        screen.showLeftPlayerHp(leftPlayer!.hp)
        if !leftPlayer!.isAlive {
            game = .ENDGAME
            screen.killLeftPlayer(leftPlayer!.type)
            screen.shout("\(rightPlayer!.name) wins!!!")
        } else {
            screen.disableRightPlayer(Int(arc4random_uniform(3)))
        }
    }
    
    func restartGame(){
        screen.resetGame(leftPlayer!.name,rightPlayerName: rightPlayer!.name)
        leftPlayer = nil
        rightPlayer = nil
        game = .LEFTPLAYER
    }
}