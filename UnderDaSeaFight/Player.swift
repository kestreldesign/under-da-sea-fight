//
//  Player.swift
//  UnderDaSeaFight
//
//  Created by The Deblings on 26/09/2015.
//  Copyright © 2015 Kestrel Design. All rights reserved.
//

import Foundation

class Player {
    private var _hp = 100
    private var _attackPower = 20
    private var _name = "Player"
    private var _type: GameController.CritterType!
    private var _alive: Bool = true

    init(name: String, type: GameController.CritterType){
        self._name = name
        self._type = type
    }
    
    func getHitByRandomPower() -> Int {
        let power = Int(arc4random_uniform(10) + 15) //between 15 and 25
        if getHit(power) {
            return power
        } else {
            return 0
        }
    }
    
    init(hp: Int, attackPwr: Int, name: String, type: GameController.CritterType){
        self._hp = hp
        self._attackPower = attackPwr
        self._name = name
        self._type = type

    }
    
    func getHit(powerOfAttack: Int) -> Bool{
        _hp -= powerOfAttack
        if _hp <= 0 {
            _alive = false
            _hp = 0
        }
        return true
    }
    
    var hp: Int {
        get {
            return _hp
        }
        set {
            _hp = newValue
        }
    }
    
    var attackPower: Int {
        get {
            return _attackPower
        }
        set {
            _attackPower = newValue
        }
    }
    
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var type: GameController.CritterType {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    var isAlive: Bool {
        get {
            return _alive
        }
    }
}