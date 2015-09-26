//
//  GameController.swift
//  UnderDaSeaFight
//
//  Created by The Deblings on 25/09/2015.
//  Copyright © 2015 Kestrel Design. All rights reserved.
//

import Foundation

class GameController {
    //leftplayer
    //rightplayer
    //gamestate: leftplayer, rightplayer, game, endgame
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
    
    init(screen: ViewController) { //pass all the UI elements into the game at init?
        self.screen = screen
        screen.showPlayer1Screen()
    }
    
    func playerChoseACritter(var nameOfPlayer: String?, critter: CritterType){
        if nameOfPlayer == nil {
            nameOfPlayer = "Player1"
        }
        if game == .LEFTPLAYER {
            print("left player, called '\(nameOfPlayer!)' chose the \(critter)")
            //store this info into leftplayer
            game = .RIGHTPLAYER
            screen.showPlayer2Screen()
        } else if game == .RIGHTPLAYER {
            print("right player, called '\(nameOfPlayer!)' chose the \(critter)")
            //store this info into right player
            game = .GAME
            //screen.showMainGameScreen()
        }
    }
    
    func leftPlayerAttacked(){
        //attempt attack from left player to right player
        //update all numbers and display text
        //if right player dies, end game
        //disable leftplayer attack button for x seconds
    }
    
    func rightPlayerAttacked(){
        //attempt attack from right player to left player
        //update all numbers and display text
        //if left player dies, end game
        //disable rightplayer attack button for x seconds
    }
    
    func endGame() {
        //make loser disappear
        //display winner text and replay button
    }
    
    func reStartGame(){
        //show player 1 screen (still contains player 1's name)
    }
}