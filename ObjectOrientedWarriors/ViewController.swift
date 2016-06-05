//
//  ViewController.swift
//  ObjectOrientedWarriors
//
//  Created by Arbie Chuang on 6/4/16.
//  Copyright © 2016 Arbie Chuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var printLabel: UILabel!
    
    @IBOutlet weak var player1HpLabel: UILabel!
    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player1BtnLabel: UILabel!
    
    @IBOutlet weak var player2HpLabel: UILabel!
    @IBOutlet weak var player2Image: UIImageView!
    @IBOutlet weak var player2Button: UIButton!
    @IBOutlet weak var player2BtnLabel: UILabel!
    
    @IBOutlet weak var resetBtnLabel: UIButton!
    @IBOutlet weak var restButton: UILabel!
    
    var player1: Player!
    var player1Status: Int!
    var player2: Player!
    var player2Status: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1Image.transform = CGAffineTransformMakeScale(-1, 1)
        startEnable()
    }
    
    func startGame() {
        startDisable()
        
        player1 = Player(name: "Silver Chariot", hp: 60, attPwr: 20)
        player1Status = playerStatus(player1)
        hpLblColor(player1HpLabel, playerStatus: player1Status)
        player1HpLabel.text = "HP \(player1.hp)"
        
        player2 = Player(name: "Crazy Diamond", hp: 60, attPwr: 20)
        player2Status = playerStatus(player2)
        hpLblColor(player2HpLabel, playerStatus: player2Status)
        player2HpLabel.text = "HP \(player2.hp)"
        
        printLabel.text = "Player1: \(player1.name) & Player2: \(player2.name)"
        
        player1Image.alpha = 1
        player2Image.alpha = 1
        
        attTimer()
    }
    
    func attTimer() {
        let randTime = Double(Int(arc4random_uniform(3)) + 1)
        NSTimer.scheduledTimerWithTimeInterval(randTime, target: self, selector: #selector(ViewController.attEnable), userInfo: nil, repeats: false)
    }
    
    func attEnable() {
        player1Button.hidden = false
        player2Button.hidden = false
        player1BtnLabel.alpha = 1
        player2BtnLabel.alpha = 1
    }
    
    func attDisable() {
        player1Button.hidden = true
        player2Button.hidden = true
        player1BtnLabel.alpha = 0.3
        player2BtnLabel.alpha = 0.3
    }
    
    func startEnable() {
        restButton.hidden = false
        resetBtnLabel.hidden = false
    }
    
    func startDisable() {
        restButton.hidden = true
        resetBtnLabel.hidden = true
    }
    
    func playerStatus(player: Player) -> Int {
        return player.hpStatus(player.hp)
    }
    
    func hpLblColor(label: UILabel, playerStatus: Int) {
        if(playerStatus == 3) {
            label.textColor = UIColor.blackColor()
        } else if(playerStatus == 2) {
            label.textColor = UIColor.orangeColor()
        } else {
            label.textColor = UIColor.redColor()
        }
    }

    @IBAction func player1AttTapped(sender: AnyObject) {
        attDisable()
        if player2.underAttack(player1.attPwr) {
            // play sound
            printLabel.text = "\(player1.name) attacked \(player2.name)"
            player2Status = playerStatus(player2)
            hpLblColor(player2HpLabel, playerStatus: player2Status)
            player2HpLabel.text = "HP \(player2.hp)"
        }
        
        if player2.isAlive {
            attTimer()
        } else {
            player2Image.alpha = 0.1
            printLabel.text = "\(player1.name) won!"
            startEnable()
        }
    }
    
    @IBAction func player2AttTapped(sender: AnyObject) {
        attDisable()
        if player1.underAttack(player2.attPwr) {
            printLabel.text = "\(player2.name) attacked \(player1.name)"
            player1Status = playerStatus(player1)
            hpLblColor(player1HpLabel, playerStatus: player1Status)
            player1HpLabel.text = "HP \(player1.hp)"
        }
        if player1.isAlive {
           attTimer()
        } else {
            player1Image.alpha = 0.1
            printLabel.text = "\(player2.name) won!"
            startEnable()
        }
    }
    
    @IBAction func resetGameTapped(sender: AnyObject) {
        startGame()
    }

}

