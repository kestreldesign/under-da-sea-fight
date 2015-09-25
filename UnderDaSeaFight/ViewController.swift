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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load GameController
    }

    @IBAction func playerChoseSeahorse(sender: AnyObject) {
        //game.playerchoseseahorse(this)
    }
    @IBAction func playerChoseCrab(sender: AnyObject) {
        //game.playerchosecrab(this)
    }


}

