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
        if nameOfPlayer?.characters.count >= 10 {
            let substringRange = nameOfPlayer!.startIndex..<nameOfPlayer!.startIndex.advancedBy(10)
            nameOfPlayer = nameOfPlayer!.substringWithRange(substringRange)
        }
        if game == .LEFTPLAYER {
            if nameOfPlayer == "" {
                nameOfPlayer = "Player 1"
            }
            print("left player, called '\(nameOfPlayer!)' chose the \(critter)")
            //store this info into leftplayer
            leftPlayer = Player(name: nameOfPlayer!, type: critter)
            game = .RIGHTPLAYER
            screen.showPlayer2Screen()
        } else if game == .RIGHTPLAYER {
            if nameOfPlayer == "" {
                nameOfPlayer = "Player 2"
            }
            print("right player, called '\(nameOfPlayer!)' chose the \(critter)")
            rightPlayer = Player(name: nameOfPlayer!, type: critter)
            game = .GAME
            screen.showMainGameScreen(leftPlayer!.type, rightCritter: rightPlayer!.type)
        }
    }
    
    func leftPlayerAttacked(){
        print("left player attacked")
        let attackAmount = rightPlayer!.getHitByRandomPower()
        screen.print("\(leftPlayer!.name) attacked, \(rightPlayer!.name) lost \(attackAmount) hp!")
        screen.showRightPlayerHp(rightPlayer!.hp)
        if !rightPlayer!.isAlive {
            game = .ENDGAME
            screen.hideRightPlayer()
            screen.shout("\(leftPlayer!.name) wins!!!")
        }
        screen.disableLeftPlayer(Int(arc4random_uniform(3)))
    }
    
    func rightPlayerAttacked(){
        print("right player attacked")
        let attackAmount = leftPlayer!.getHitByRandomPower()
        screen.print("\(rightPlayer!.name) attacked, \(leftPlayer!.name) lost \(attackAmount) hp!")
        screen.showLeftPlayerHp(leftPlayer!.hp)
        if !leftPlayer!.isAlive {
            game = .ENDGAME
            screen.hideLeftPlayer()
            screen.shout("\(rightPlayer!.name) wins!!!")
        }
        screen.disableRightPlayer(Int(arc4random_uniform(3)))
    }
    
    func restartGame(){
        screen.resetGame(leftPlayer!.name,rightPlayerName: rightPlayer!.name)
        leftPlayer = nil
        rightPlayer = nil
        game = .LEFTPLAYER
    }
}