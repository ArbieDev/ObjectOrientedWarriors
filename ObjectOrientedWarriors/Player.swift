//
//  Character.swift
//  ObjectOrientedWarriors
//
//  Created by Arbie Chuang on 6/5/16.
//  Copyright © 2016 Arbie Chuang. All rights reserved.
//

import Foundation

class Player {
    private var _name: String
    private var _hp: Int
    private var _attPwr: Int
    
    var name: String {
        get {
            return _name
        }
    }
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var attPwr: Int {
        get {
            return _attPwr
        }
    }
    
    var isAlive: Bool {
        get {
            if hp > 0 {
                return true
            } else {
                return false
            }
        }
    }
    
    init(name: String, hp: Int, attPwr: Int) {
        self._name = name
        self._hp = hp
        self._attPwr = attPwr
    }
    
    func underAttack(attPwr: Int) -> Bool {
        self._hp -= attPwr
        return true
    }
    
    func hpStatus(hp: Int) -> Int {
        if(hp > 50) {
            return 3
        } else if(hp > 30) {
            return 2
        } else {
            return 1
        }
    }
    
}