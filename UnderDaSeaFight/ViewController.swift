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
    
    var game: GameController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = GameController.init(screen: self)
        
        
    }

    @IBAction func playerChoseSeahorse(sender: AnyObject) {
        game.playerChoseACritter(playerInputTextField.text, critter: GameController.CritterType.SEAHORSE)
    }
    
    @IBAction func playerChoseCrab(sender: AnyObject) {
        game.playerChoseACritter(playerInputTextField.text, critter: GameController.CritterType.CRAB)
    }
    
    func showPlayer1Screen(){
        seahorseOptionImage.setImage(UIImage(named: "seahorse_left.png"), forState: .Normal) //"seahorse_right.png"
        crabOptionImage.setImage(UIImage(named: "crab_left.png"), forState: .Normal) //"seahorse_right.png"
        playerInputTextField.placeholder = "player 1's name"
        playerInputBackground.hidden = false;
        playerInputStackView.hidden = false;
    }
    
    func showPlayer2Screen(){
        playerInputTextField.text = ""
        seahorseOptionImage.setImage(UIImage(named: "seahorse_right.png"), forState: .Normal) //"seahorse_right.png"
        crabOptionImage.setImage(UIImage(named: "crab_right.png"), forState: .Normal) //"seahorse_right.png"
        playerInputTextField.placeholder = "player 2's name"
    }
    

}

