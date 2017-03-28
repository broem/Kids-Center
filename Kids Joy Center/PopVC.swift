//
//  PopVC.swift
//  Kids Joy Center
//
//  Created by Ben on 3/24/17.
//  Copyright © 2017 Benjamin Leach. All rights reserved.
//

import UIKit

class PopVC: UIViewController {
    
    var balloonDiff = 0
    var difficultySpeed = 0.0
    var stopSec = 0
    
    var lastXPos = 0
    
    var score = 0
    var scoreviewHundreds = UIImageView()
    var scoreViewTens = UIImageView()
    var scoreViewOnes = UIImageView()
    
    var game_mode = 0
    // timer variables to be set
    var timeSec = 0
    var timeTenSec = 0
    var timeMin = 0
    
    var timerCount = 0
    var times = Timer()
    
    
    // image frames for timer images
    let seconds = UIImageView()
    let tenSec = UIImageView()
    let minutes = UIImageView()
    
    // balloon num
    var balloonMax = 0
    
    // balloon containers
    var container1 = UIView()
    var container2 = UIView()
    var container3 = UIView()
    var container4 = UIView()
    var container5 = UIView()
    var container6 = UIView()
    var container7 = UIView()
    var container8 = UIView()
    var container9 = UIView()
    var container10 = UIView()
    
    var t = Timer()
    
    // x check
    var xCheck = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImg = UIImageView(frame: self.view.bounds)
        bgImg.image = UIImage(named: "sky-background")
        bgImg.contentMode = .scaleToFill
        self.view.addSubview(bgImg)
        self.view.sendSubview(toBack: bgImg)
        // Do any additional setup after loading the view.
        
        self.navigationController?.title = "Pop Game!"
        self.title = "Pop Game!"
        
        let timeImg = UIImageView(frame: CGRect(x: 0, y: 75, width: 150, height: 55))
        setStartTime()
        startTimer()
        
        timeImg.image = UIImage(named: "time")
        timeImg.isUserInteractionEnabled = false
        //timeImg.contentMode = .topLeft
        self.view.addSubview(timeImg)
        
        
        minutes.frame = CGRect(x: 160, y: 75, width: 45, height: 55)
        minutes.image = UIImage(named: "cartoon-number-\(timeMin)")
        minutes.isUserInteractionEnabled = false
        self.view.addSubview(minutes)
        
        tenSec.frame = CGRect(x: 222, y: 75, width: 45, height: 55)
        tenSec.image = UIImage(named: "cartoon-number-\(timeTenSec)")
        tenSec.isUserInteractionEnabled = false
        self.view.addSubview(tenSec)
        
        seconds.frame = CGRect(x: 272, y: 75, width: 45, height: 55)
        seconds.image = UIImage(named: "cartoon-number-\(timeSec)")
        seconds.isUserInteractionEnabled = false
        self.view.addSubview(seconds)
        
        let scoreImg = UIImageView(frame: CGRect(x: 690, y: 75, width: 150, height: 55))
        scoreImg.image = UIImage(named: "score")
        scoreImg.isUserInteractionEnabled = false
        self.view.addSubview(scoreImg)
        
        
        scoreviewHundreds = UIImageView(frame: CGRect(x: 850, y: 75, width: 45, height: 55))
        self.view.addSubview(scoreviewHundreds)
        
        scoreViewTens = UIImageView(frame: CGRect(x: 895, y: 75, width: 45, height: 55))
        self.view.addSubview(scoreViewTens)
        
        scoreViewOnes = UIImageView(frame: CGRect(x: 940, y: 75, width: 45, height: 55))
        self.view.addSubview(scoreViewOnes)
        
        startTime()
//        t = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(createBalloon), userInfo: nil, repeats: true)
//        t.fire()
        //animateView(v: container5)
        
    }
    
    func startTime() {
        
        t = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(createBalloon), userInfo: nil, repeats: true)
        t.fire()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createBalloon() {
        
        let randomPercent = Int(arc4random_uniform(100) + 1)
        //print("score = \(score)")
        if(game_mode == 11 && randomPercent <= 50 && stopSec == 0) {
            stopSec = 1
            createBalloon()
        }
        if(game_mode == 12 && randomPercent <= 33 && stopSec == 0) {
            stopSec = 1
            createBalloon()
            createBalloon()
            
        }
        
        
        var xPos = Int(arc4random_uniform(9)) * 100
        // this way we dont get duplicates
        
//        print("xChek = \(xCheck)")
//        print("xpos = \(xPos)")
        if(xPos == xCheck){
            xPos = xPos + 100
//            print("new xPos = \(xPos)")
            if(xPos == 1000){
                xPos = 0
            }
            xCheck = xPos
        }
        
        
        let randColor = Int(arc4random_uniform(10) + 1)
        let randNum = Int(arc4random_uniform(UInt32(balloonDiff)) + 1)
        //print("Rand: \(randNum)")
        
        let balloon = UIView(frame: CGRect(x: xPos, y: 900, width: 100, height: 120))
        
        //if let balloon = self.view.viewWithTag(randContainer) {

            balloon.isHidden = false
        
        
        //let testm = UIView(frame: CGRect(x: 100, y: -120, width: 100, height: 120))
            //let testBG = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
            //testBG.image = UIImage(named: "color2")
            //let testnum = UIImageView(frame: CGRect(x: 40, y: 35, width: 35, height: 50))
        let testBG = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        testBG.image = UIImage(named: "color\(randColor)")
        let testnum = UIImageView(frame: CGRect(x: 40, y: 35, width: 35, height: 50))
        
        //testnum.frame.size.height = 50
        //testnum.frame.size.width = 35
        //testnum.center = balloon.center
        //testnum.frame.origin.y = testm.center.y
        
        testnum.image = UIImage(named: "cartoon-number-\(randNum)")
        balloon.addSubview(testBG)
        balloon.addSubview(testnum)
        balloon.sendSubview(toBack: testBG)
        balloon.tag = randNum
        
        self.view.addSubview(balloon)
        //balloon.center.y += 1000
        //yepper = testm
        animateView(v: balloon)
        stopSec = 0
        
    }
    
    func animateView(v: UIView){
        
        let speed = v.frame.origin.y/CGFloat(difficultySpeed)
        
        UIView.animate(withDuration: TimeInterval(speed), delay: 0, options: .allowUserInteraction, animations: {
            v.frame.origin.y = -100
        }, completion: {_ in v.removeFromSuperview() })
    }

    
    func startTimer() {
        // if game_lvl then set beginning state
        
        
        times = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            // update the seconds
            self.checkForEnd()
            
            
            // time stuff
            let min = self.timerCount / 60
            
            let yep = self.timerCount%60
            
            let tens = yep / 10
            
            let ones = yep % 10
            
            self.seconds.image = UIImage(named: "cartoon-number-\(ones)")
            self.tenSec.image = UIImage(named: "cartoon-number-\(tens)")
            self.minutes.image = UIImage(named: "cartoon-number-\(min)")
            self.timerCount = self.timerCount - 1
            
            
            // score stuff
            let hunScore = self.score / 100
            let onesScore = self.score % 10
            var tensScore = 0
            if self.score > 100 {
                let div = self.score / 100
                tensScore = div / 10
                
            }
            else {
                tensScore = self.score / 10
            }
            
            self.scoreviewHundreds.image = UIImage(named: "cartoon-number-\(hunScore)")
            self.scoreViewOnes.image = UIImage(named: "cartoon-number-\(onesScore)")
            self.scoreViewTens.image = UIImage(named: "cartoon-number-\(tensScore)")
            
        }
        times.fire()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch!.location(in: self.view)
        
        for i in 2...self.view.subviews.count {
            if self.view.subviews[i-1].layer.presentation()!.hitTest(touchLocation) != nil {
                print("touched subview \(i)")
                if i >= 12 {
                self.view.subviews[i-1].isHidden = true
                    score = score + self.view.subviews[i-1].tag
                }
            }
        }
        
        
        
    }
    
    func checkForEnd() {
        if (timerCount == 0) {
            times.invalidate()
            t.invalidate()
            let alert = UIAlertController(title: "Game Over!", message: "The game is over, would you like to play again?", preferredStyle: .alert)
            let myAction = UIAlertAction(title: "OK", style: .default, handler: { action in self.restart()})
            let second = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in self.performSegue(withIdentifier: "homeScreen", sender: self)});
            
            alert.addAction(myAction)
            alert.addAction(second)
            present(alert, animated: true, completion: nil)

        }
    }
    
    func restart() {
        setStartTime()
        startTimer()
        startTime()
        score = 0
    }
    
    func setStartTime() {
        if game_mode == 10 {
            timerCount = 60
            balloonDiff = 9
            difficultySpeed = 30.0
//            timeSec = 0
//            timeTenSec = 5
//            timeMin = 1
        }
        if game_mode == 11 {
            timerCount = 45
            balloonDiff = 7
            difficultySpeed = 50.0
//            timeSec = 5
//            timeTenSec = 4
//            timeMin = 1
        }
        if game_mode == 12 {
            timerCount = 30
            balloonDiff = 5
            difficultySpeed = 100.0
//            timeSec = 0
//            timeTenSec = 2
//            timeMin = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeScreen" {
            if segue.destination is PopVC {
                //sendMem.game_mode = isModeClicked
            }
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
