//
//  ViewController.swift
//  UnderDaSeaFight
//
//  Created by The Deblings on 24/09/2015.
//  Copyright © 2015 Kestrel Design. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    //player input option screen
    @IBOutlet weak var playerInputBackground: UIImageView!
    @IBOutlet weak var playerInputStackView: UIStackView!
    @IBOutlet weak var playerInputTextField: UITextField!
    @IBOutlet weak var seahorseOptionImage: UIButton!
    @IBOutlet weak var crabOptionImage: UIButton!
    
    //main play screen
    @IBOutlet weak var bottomOfScreenLabel: UILabel!
    @IBOutlet weak var middleOfScreenLabel: UILabel!
    @IBOutlet weak var leftPlayerScore: UILabel!
    @IBOutlet weak var rightPlayerScore: UILabel!
    @IBOutlet weak var leftPlayerCritter: UIImageView!
    @IBOutlet weak var rightPlayerCritter: UIImageView!
    @IBOutlet weak var leftAttackButton: UIButton!
    @IBOutlet weak var rightAttackButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    //variables
    var game: GameController!
    var timer = NSTimer()
    var reset = false
    var resetPlayer2sName = ""
    var bubbleSound: AVAudioPlayer!
    var dieSound: AVAudioPlayer!
    var backgroundSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wipe()
        shout("")
        restartButton.hidden = true
        playerInputTextField.delegate = self
        initialiseSounds()
        game = GameController.init(screen: self)
    }
    
    //Sounds
    func initialiseSounds(){
        var path = NSBundle.mainBundle().pathForResource("bubble1", ofType: "mp3")
        var soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try bubbleSound = AVAudioPlayer(contentsOfURL: soundUrl)
            bubbleSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        path = NSBundle.mainBundle().pathForResource("crab_die", ofType: "mp3")
        soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try dieSound = AVAudioPlayer(contentsOfURL: soundUrl)
            dieSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        path = NSBundle.mainBundle().pathForResource("water_background", ofType: "mp3")
        soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try backgroundSound = AVAudioPlayer(contentsOfURL: soundUrl)
            backgroundSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        backgroundSound.numberOfLoops = -1
        backgroundSound.volume = 0.9
        backgroundSound.play()
    }
    func playBubble(){
        if bubbleSound.playing {
            bubbleSound.stop()
        }
        let path = NSBundle.mainBundle().pathForResource("bubble\(Int(arc4random_uniform(3)+1))", ofType: "mp3")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try bubbleSound = AVAudioPlayer(contentsOfURL: soundUrl)
            bubbleSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        bubbleSound.play()
    }
    func playDeathSound(type: GameController.CritterType){
        if dieSound.playing {
            dieSound.stop()
        }
        if bubbleSound.playing {
            bubbleSound.stop()
        }
        var typeToStr = ""
        if type == .CRAB {
            typeToStr = "crab_die"
        } else if type == .SEAHORSE {
            typeToStr = "seahorse_die"
        }
        let path = NSBundle.mainBundle().pathForResource("\(typeToStr)", ofType: "mp3")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try dieSound = AVAudioPlayer(contentsOfURL: soundUrl)
            dieSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        dieSound.play()
    }
    
    //player entry
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        if (textField.text!.characters.count >= 10 && range.length == 0) {
            return false
        }
        else {
            return true
        }
    }
    func checkTextLength(){
    if playerInputTextField.text!.characters.count >= 10 {
        let substringRange = playerInputTextField.text!.startIndex..<playerInputTextField.text!.startIndex.advancedBy(10)
        playerInputTextField.text = playerInputTextField.text!.substringWithRange(substringRange)
        }
    }
    @IBAction func playerChoseSeahorse(sender: AnyObject) {
        checkTextLength()
        game.playerChoseACritter(playerInputTextField.text, critter: GameController.CritterType.SEAHORSE)
    }
    @IBAction func playerChoseCrab(sender: AnyObject) {
        checkTextLength()
        game.playerChoseACritter(playerInputTextField.text, critter: GameController.CritterType.CRAB)
    }
    
    
    //game play
    @IBAction func leftPlayerAttacked(sender: AnyObject) {
        playBubble()
        game.leftPlayerAttacked()
    }
    @IBAction func rightPlayerAttacked(sender: AnyObject) {
        playBubble()
        game.rightPlayerAttacked()
    }
    func showLeftPlayerHp(health: Int){
        leftPlayerScore.text = "\(health)"
    }
    func showRightPlayerHp(health: Int){
        rightPlayerScore.text = "\(health)"
    }
    func disableLeftPlayer(time: Int){
        leftAttackButton.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(Double(time), target: self, selector: "enableAttackButtons", userInfo: nil, repeats: false)
    }
    func disableRightPlayer(time: Int){
        rightAttackButton.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(Double(time), target: self, selector: "enableAttackButtons", userInfo: nil, repeats: false)
    }
    func killLeftPlayer(type: GameController.CritterType){
        leftPlayerCritter.hidden = true
        playDeathSound(type)
    }
    func killRightPlayer(type: GameController.CritterType){
        rightPlayerCritter.hidden = true
        playDeathSound(type)
    }
    func enableAttackButtons(){
        leftAttackButton.enabled = true
        rightAttackButton.enabled = true
    }
    func disableAttackButtons(){
        leftAttackButton.enabled = false
        rightAttackButton.enabled = false
    }
    @IBAction func restartGame(sender: UIButton) {
        game.restartGame()
    }
    
    //feedback
    func shout(text: String){
        middleOfScreenLabel.text = text
        restartButton.hidden = false
        disableAttackButtons()
    }
    func wipe(){
        bottomOfScreenLabel.text = ""
    }
    func print(text: String){
        timer.invalidate() //stop previous wipes
        bottomOfScreenLabel.text = text
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target:self, selector: Selector("wipe"), userInfo: nil, repeats: false)
    }
    
    //screen management
    func showPlayer1Screen(){
        playerInputTextField.placeholder = "player 1's name"
        seahorseOptionImage.setImage(UIImage(named: "seahorse_left.png"), forState: .Normal)
        crabOptionImage.setImage(UIImage(named: "crab_left.png"), forState: .Normal)
        
        playerInputBackground.hidden = false;
        playerInputStackView.hidden = false;
    }
    func showPlayer2Screen(){
        playerInputTextField.placeholder = "player 2's name"
        seahorseOptionImage.setImage(UIImage(named: "seahorse_right.png"), forState: .Normal)
        crabOptionImage.setImage(UIImage(named: "crab_right.png"), forState: .Normal)
        if reset {
            playerInputTextField.text = resetPlayer2sName
        } else {
            playerInputTextField.text = ""
        }
    }
    func showMainGameScreen(leftCritter: GameController.CritterType, rightCritter: GameController.CritterType){
        playerInputBackground.hidden = true
        playerInputStackView.hidden = true
        leftAttackButton.enabled = true
        rightAttackButton.enabled = true
        
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
        restartButton.hidden = true
        playerInputTextField.text = leftPlayerName
        resetPlayer2sName = rightPlayerName
        showLeftPlayerHp(100)
        showRightPlayerHp(100)
        leftPlayerCritter.hidden = false
        rightPlayerCritter.hidden = false
        showPlayer1Screen()
    }
}

