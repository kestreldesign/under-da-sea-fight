//
//  ViewController.swift
//  UnderDaSeaFight
//
//  Created by The Deblings on 24/09/2015.
//  Copyright © 2015 Kestrel Design. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //player input option screen
    @IBOutlet weak var playerInputBackground: UIImageView!
    @IBOutlet weak var playerInputStackView: UIStackView!
    @IBOutlet weak var playerInputTextField: UITextField!
    @IBOutlet weak var seahorseOptionImage: UIButton!
    @IBOutlet weak var crabOptionImage: UIButton!
    
    @IBOutlet weak var bottomOfScreenLabel: UILabel!
    @IBOutlet weak var middleOfScreenLabel: UILabel!
    @IBOutlet weak var leftPlayerScore: UILabel!
    @IBOutlet weak var rightPlayerScore: UILabel!
    @IBOutlet weak var leftPlayerCritter: UIImageView!
    @IBOutlet weak var rightPlayerCritter: UIImageView!
    @IBOutlet weak var leftAttackButton: UIButton!
    @IBOutlet weak var rightAttackButton: UIButton!
    
    var game: GameController!
    var timer = NSTimer()
    var reset = false
    var resetPlayer2sName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wipe()
        shout("")
        playerInputTextField.placeholder = "player 1's name"
        playerInputTextField.placeholder = "player 2's name"
        game = GameController.init(screen: self)
    }

    @IBAction func playerChoseSeahorse(sender: AnyObject) {
        game.playerChoseACritter(playerInputTextField.text, critter: GameController.CritterType.SEAHORSE)
    }
    @IBAction func playerChoseCrab(sender: AnyObject) {
        game.playerChoseACritter(playerInputTextField.text, critter: GameController.CritterType.CRAB)
    }
    @IBAction func rightPlayerAttacked(sender: AnyObject) {
        game.rightPlayerAttacked()
    }
    @IBAction func leftPlayerAttacked(sender: AnyObject) {
        game.leftPlayerAttacked()
    }
    @IBAction func restartGame(sender: UIButton) {
        game.restartGame()
    }
    func hideLeftPlayer(){
        leftPlayerCritter.hidden = true
    }
    func hideRightPlayer(){
        rightPlayerCritter.hidden = true
    }
    func shout(text: String){
        middleOfScreenLabel.text = text
        //show restart button
    }
    func wipe(){
        bottomOfScreenLabel.text = ""
    }
    func showLeftPlayerHp(health: Int){
        leftPlayerScore.text = "\(health)"
    }
    func showRightPlayerHp(health: Int){
        rightPlayerScore.text = "\(health)"
    }
    func print(text: String){
        timer.invalidate() //stop previous wipes
        bottomOfScreenLabel.text = text
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target:self, selector: Selector("wipe"), userInfo: nil, repeats: false)
    }
    func disableLeftPlayer(time: Int){
        leftAttackButton.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(Double(time), target: self, selector: "enableLeftAttackButton", userInfo: nil, repeats: false)
    }
    func enableLeftAttackButton(){
        leftAttackButton.enabled = true
    }
    func disableRightPlayer(time: Int){
        rightAttackButton.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(Double(time), target: self, selector: "enableRightAttackButton", userInfo: nil, repeats: false)
    }
    func enableRightAttackButton(){
        rightAttackButton.enabled = true
    }
    func showPlayer1Screen(){
        seahorseOptionImage.setImage(UIImage(named: "seahorse_left.png"), forState: .Normal)
        crabOptionImage.setImage(UIImage(named: "crab_left.png"), forState: .Normal)
        playerInputBackground.hidden = false;
        playerInputStackView.hidden = false;
    }
    func showPlayer2Screen(){
        if reset {
            playerInputTextField.text = resetPlayer2sName
        } else {
            playerInputTextField.text = ""
        }
        seahorseOptionImage.setImage(UIImage(named: "seahorse_right.png"), forState: .Normal)
        crabOptionImage.setImage(UIImage(named: "crab_right.png"), forState: .Normal)
    }
    func showMainGameScreen(leftCritter: GameController.CritterType, rightCritter: GameController.CritterType){
        playerInputBackground.hidden = true;
        playerInputStackView.hidden = true;
        
        var leftCritterStr = ""
        var rightCritterStr = ""
        if leftCritter == .SEAHORSE {
            leftCritterStr = "seahorse_left"
        } else if leftCritter == .CRAB {
            leftCritterStr = "crab_left"
        }
        if rightCritter == .SEAHORSE {
            rightCritterStr = "seahorse_right"
        } else if rightCritter == .CRAB {
            rightCritterStr = "crab_right"
        }
        leftPlayerCritter.image = UIImage(named: "\(leftCritterStr).png")
        rightPlayerCritter.image = UIImage(named: "\(rightCritterStr).png")
    }
    func resetGame(leftPlayerName: String, rightPlayerName: String){
        reset = true
        wipe()
        shout("")
        playerInputTextField.text = leftPlayerName
        resetPlayer2sName = rightPlayerName
        showLeftPlayerHp(100)
        showLeftPlayerHp(100)
        showPlayer1Screen()
    }
}

