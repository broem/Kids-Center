//
//  MemoryVC.swift
//  Kids Joy Center
//
//  Created by Ben on 3/16/17.
//  Copyright © 2017 Benjamin Leach. All rights reserved.
//

import UIKit
import GameplayKit

class MemoryVC: UIViewController {
    
    var game_mode = 0
    var gridSize = 0
    var taggem = 0
    
    var xStart = 210
    var yStart = 190
    let spaceBetween = 2
    var adjustable = 0
    
    var shuffledArray = [UIImage]()
    
    var arraySize: Int = 0
    
    var gameButton = UIButton()
    var gameBoard = [[UIButton]]()
    // button size 120 x 120
    var gameQImg = [UIButton]()
    var gameAnimalImg = [UIImage]()
    var randomGameImg = [UIImage]()
    
    var qImg = UIImage(named: "question")
    
    // image frames for timer images
    let seconds = UIImageView()
    let tenSec = UIImageView()
    let minutes = UIImageView()
    
    // timer variables to be set
    var timeSec = 0
    var timeTenSec = 0
    var timeMin = 0
    
    var timerCount = 0
    
    var times = Timer()
    
    var numToCompare = "0"
    var lastClicked = -1
    var lastButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bgImg = UIImageView(frame: self.view.bounds)
        bgImg.image = UIImage(named: "background")
        bgImg.contentMode = .scaleToFill
        
        self.view.addSubview(bgImg)
        self.view.sendSubview(toBack: bgImg)
        
        self.navigationController?.title = "Memory Game!"
        self.title = "Memory Game!"
    
        let timeImg = UIImageView(frame: CGRect(x: 0, y: 75, width: 150, height: 55))
        setStartTime()
        startTimer()
        
        timeImg.image = UIImage(named: "time")
        //timeImg.contentMode = .topLeft
        self.view.addSubview(timeImg)
        
        
        
        
        minutes.frame = CGRect(x: 160, y: 75, width: 45, height: 55)
        minutes.image = UIImage(named: "cartoon-number-\(timeMin)")
        self.view.addSubview(minutes)
        
        tenSec.frame = CGRect(x: 222, y: 75, width: 45, height: 55)
        tenSec.image = UIImage(named: "cartoon-number-\(timeTenSec)")
        self.view.addSubview(tenSec)
        
        seconds.frame = CGRect(x: 272, y: 75, width: 45, height: 55)
        seconds.image = UIImage(named: "cartoon-number-\(timeSec)")
        self.view.addSubview(seconds)
        
        if game_mode == 10 {
            gridSize = 3
            adjustable = 120
        }
        
        if game_mode == 11 {
            gridSize = 4
            adjustable = 60
        }
        
        if game_mode == 12 {
            gridSize = 5
        }
        
        arraySize = 4 * gridSize
        
        let maxSize = arraySize / 2
        
        for i in 1...10 {
            let imgToAdd = UIImage(named: "\(i)")
            imgToAdd?.accessibilityIdentifier = "\(i)"
            
            randomGameImg.append(imgToAdd!)
        }
        // shuffle the images
        randomGameImg = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: randomGameImg) as! [UIImage]
        
        
        for i in 1...maxSize {
            
            //let anIm = i + 1
            // fill it twice since were matching
            // were setting a matching identifier with each to compare later
            //let imgToAdd = UIImage(named: "\(i)")
            //imgToAdd?.accessibilityIdentifier = "\(i)"
            
            gameAnimalImg.append(randomGameImg[i])
            
            gameAnimalImg.append(randomGameImg[i])
        }
        
        // random shuffle
        shuffledArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: gameAnimalImg) as! [UIImage]
        
        
        print("game lvl = \(game_mode)")
        
        generateBoard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("game lvl = \(game_mode)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateBoard() {
        xStart = xStart + adjustable
        for _ in 1...4 {
            for _ in 1...gridSize {
                gameButton = UIButton(frame: CGRect(x: xStart, y: yStart, width: 120 , height: 120))
                gameButton.setBackgroundImage(qImg, for: UIControlState.normal)
                
                gameButton.tag = taggem
                
                gameButton.addTarget(self, action: #selector(questionClicked(_:)), for: UIControlEvents.touchUpInside)
                
                self.view.addSubview(gameButton)
            
                xStart = xStart + 120
                taggem =  taggem + 1
            }
            xStart = 210 + adjustable
            yStart = yStart + 120
            
        }
    }

    func questionClicked (_ sender: UIButton) {
        print("sender: \(sender.tag)")
        sender.setBackgroundImage(shuffledArray[sender.tag], for: .normal)
        sender.isUserInteractionEnabled = false
        let imgsAreTheSame = shuffledArray[sender.tag].accessibilityIdentifier
        
        if lastClicked == -1 {
            // lastclicked now equals previous location
            lastClicked =  sender.tag
            lastButton = sender
            numToCompare = imgsAreTheSame!
        }
        
        else if numToCompare == imgsAreTheSame {
            // both of these should remain unclickable
            print("this actually works damn")
            numToCompare = "0"
            lastClicked = -1
        }
        else {
            
            print("waiting...")
            
            numToCompare = imgsAreTheSame!
           
            lastButton.isUserInteractionEnabled = true
            gameButton.isUserInteractionEnabled = true
            lastClicked = -1
            // current button must be clickable too
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                sender.isUserInteractionEnabled = true
                self.lastButton.setBackgroundImage(self.qImg, for: .normal)
                sender.setBackgroundImage(self.qImg, for: .normal)
            }
            
        }
        print("Last Clicked = \(lastClicked)")
        print("Num To Compare = \(numToCompare)")
        print("Img are same? = \(imgsAreTheSame)")
        
    }
    
    func startTimer() {
        // if game_lvl then set beginning state
        times = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            // update the seconds
            self.checkForEnd()
            
            
            
            let min = self.timerCount / 60
            
            let yep = self.timerCount%60
            
            let tens = yep / 10
            
            let ones = yep % 10

            self.seconds.image = UIImage(named: "cartoon-number-\(ones)")
            self.tenSec.image = UIImage(named: "cartoon-number-\(tens)")
            self.minutes.image = UIImage(named: "cartoon-number-\(min)")
            self.timerCount = self.timerCount - 1
            
            
            
        }
        times.fire()
        
    }
    
    func checkForEnd() {
        if (timerCount == 0) {
            times.invalidate()
        }
    }
    
    
    func setStartTime() {
        if game_mode == 10 {
            timerCount = 120
            timeSec = 0
            timeTenSec = 5
            timeMin = 1
        }
        if game_mode == 11 {
            timerCount = 105
            timeSec = 5
            timeTenSec = 4
            timeMin = 1
        }
        if game_mode == 12 {
            timerCount = 90
            timeSec = 0
            timeTenSec = 2
            timeMin = 1
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
