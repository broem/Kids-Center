//
//  PopVC.swift
//  Kids Joy Center
//
//  Created by Ben on 3/24/17.
//  Copyright © 2017 Benjamin Leach. All rights reserved.
//

import UIKit

class PopVC: UIViewController {
    
    var score = 0
    
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
        
        //createBalloonContainers()
        container1 = UIView(frame: CGRect(x: 0, y: 700, width: 100, height: 120))
        container1.tag = 1
        container1.backgroundColor = UIColor.red

        self.view.addSubview(container1)
        
        container2 = UIView(frame: CGRect(x: 100, y: 700, width: 100, height: 120))
        container2.tag = 2
        container2.backgroundColor = UIColor.blue

        self.view.addSubview(container2)
        
        container3 = UIView(frame: CGRect(x: 200, y: 700, width: 100, height: 120))
        container3.tag = 3
        container3.backgroundColor = UIColor.red

        self.view.addSubview(container3)
        
        container4 = UIView(frame: CGRect(x: 300, y: 700, width: 100, height: 120))
        container4.tag = 4
        container4.backgroundColor = UIColor.blue

        self.view.addSubview(container4)
        
        container5 = UIView(frame: CGRect(x: 400, y: 700, width: 100, height: 120))
        container5.backgroundColor = UIColor.red

        container5.tag = 5
        self.view.addSubview(container5)
        
        container6 = UIView(frame: CGRect(x: 500, y: 700, width: 100, height: 120))
        container6.backgroundColor = UIColor.blue

        container6.tag = 6
        self.view.addSubview(container6)
        
        container7 = UIView(frame: CGRect(x: 600, y: 700, width: 100, height: 120))
        container7.backgroundColor = UIColor.red

        container7.tag = 7
        self.view.addSubview(container7)
        
        container8 = UIView(frame: CGRect(x: 700, y: 700, width: 100, height: 120))
        container8.backgroundColor = UIColor.blue

        container8.tag = 8
        self.view.addSubview(container8)
        
        container9 = UIView(frame: CGRect(x: 800, y: 700, width: 100, height: 120))
        container9.backgroundColor = UIColor.red

        container9.tag = 9
        self.view.addSubview(container9)
        
        container10 = UIView(frame: CGRect(x: 900, y: 700, width: 100, height: 120))
        container10.backgroundColor = UIColor.blue

        container10.tag = 10
        self.view.addSubview(container10)
        
        
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
        
        //createBalloon()
        
        /*let testm = UIView(frame: CGRect(x: 50, y: 100, width: 105, height: 135))
        let testBG = UIImageView(frame: testm.frame)
        testBG.image = UIImage(named: "color5")
        let testnum = UIImageView(frame: testm.frame)
        
        testnum.frame.size.height = 60
        testnum.frame.size.width = 45
        testnum.center = testm.center
        //testnum.frame.origin.y = testm.center.y
        
        testnum.image = UIImage(named: "cartoon-number-9")
        testm.addSubview(testBG)
        testm.addSubview(testnum)
        testm.sendSubview(toBack: testBG)
        
        self.view.addSubview(testm)*/
        
        let t = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(createBalloon), userInfo: nil, repeats: true)
        t.fire()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createBalloonContainers() {
        // instantiate each one so next to each other
        container1 = UIView(frame: CGRect(x: 0, y: 900, width: 100, height: 120))
        container1.backgroundColor = UIColor.red
        container1.tag = 1
        self.view.addSubview(container1)
        
        container2 = UIView(frame: CGRect(x: 100, y: 900, width: 100, height: 120))
        container2.backgroundColor = UIColor.red
        container2.tag = 2
        self.view.addSubview(container2)
        
        container3 = UIView(frame: CGRect(x: 200, y: 900, width: 100, height: 120))
        container3.backgroundColor = UIColor.red

        container3.tag = 3
        self.view.addSubview(container3)
        
        container4 = UIView(frame: CGRect(x: 300, y: 900, width: 100, height: 120))
        container4.tag = 4
        self.view.addSubview(container4)
        
        container5 = UIView(frame: CGRect(x: 400, y: 900, width: 100, height: 120))
        container5.tag = 5
        self.view.addSubview(container5)
        
        container6 = UIView(frame: CGRect(x: 500, y: 900, width: 100, height: 120))
        container6.tag = 6
        self.view.addSubview(container6)
        
        container7 = UIView(frame: CGRect(x: 600, y: 900, width: 100, height: 120))
        container7.tag = 7
        self.view.addSubview(container7)
        
        container8 = UIView(frame: CGRect(x: 700, y: 900, width: 100, height: 120))
        container8.tag = 8
        self.view.addSubview(container8)
        
        container9 = UIView(frame: CGRect(x: 800, y: 900, width: 100, height: 120))
        container9.tag = 9
        self.view.addSubview(container9)
        
        container10 = UIView(frame: CGRect(x: 900, y: 900, width: 100, height: 120))
        container10.tag = 10
        self.view.addSubview(container10)
    }
    
    func balloonArrayMake() {
        
    }
    
    
    func createBalloon() {
        
        //print("score = \(score)")
        
        let randContainer = Int(arc4random_uniform(10) + 1)
        let randColor = Int(arc4random_uniform(10) + 1)
        let randNum = Int(arc4random_uniform(9) + 1)
        //print("Rand: \(randNum)")
        
        if let balloon = self.view.viewWithTag(randContainer) {

            balloon.isHidden = false
        
        
        //let testm = UIView(frame: CGRect(x: 100, y: -120, width: 100, height: 120))
        let testBG = UIImageView(frame: balloon.frame)
        testBG.image = UIImage(named: "color\(randColor)")
        let testnum = UIImageView(frame: balloon.frame)
        
        testnum.frame.size.height = 50
        testnum.frame.size.width = 35
        testnum.center = balloon.center
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
        }
        
    }
    
    func animateView(v: UIView){
        
        let speed = v.frame.origin.y/100
        
        UIView.animate(withDuration: TimeInterval(speed), delay: 0, options: .allowUserInteraction, animations: {
            v.frame.origin.y = -100
        }, completion: {_ in v.removeFromSuperview() })
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch!.location(in: self.view)
        
        for i in 2...self.view.subviews.count {
            if self.view.subviews[i-1].layer.presentation()!.hitTest(touchLocation) != nil {
                print("touched subview \(i)")
                if i >= 8 {
                self.view.subviews[i-1].isHidden = true
                    score = score + self.view.subviews[i-1].tag
                }
            }
        }
        
        
        
    }
    
    func checkForEnd() {
        if (timerCount == 0) {
            times.invalidate()
        }
    }
    
    
    func setStartTime() {
        if game_mode == 10 {
            timerCount = 60
            timeSec = 0
            timeTenSec = 5
            timeMin = 1
        }
        if game_mode == 11 {
            timerCount = 45
            timeSec = 5
            timeTenSec = 4
            timeMin = 1
        }
        if game_mode == 12 {
            timerCount = 30
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
