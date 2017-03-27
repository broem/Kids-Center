//
//  SortVC.swift
//  Kids Joy Center
//
//  Created by Ben on 3/23/17.
//  Copyright © 2017 Benjamin Leach. All rights reserved.
//

import UIKit
import GameplayKit

class SortVC: UIViewController {
    
    var game_mode = 0
    
    var buttonDrag = UIPanGestureRecognizer()
    
    var sortImg = [UIImage]()
    var buttonIcon = UIButton()
    var ogLoc = CGRect()
    var count = 0
    
    var land = UIView()
    var land2 = UIView()
    var sea = UIView()
    var sea2 = UIView()

    var isInBounds = 0
    
    var xloc = 0
    var yloc = 75
    
    
    // image frames for timer images
    let seconds = UIImageView()
    let tenSec = UIImageView()
    let minutes = UIImageView()
    
    // timer variables to be set
    var timeSec = 0
    var timeTenSec = 0
    var timeMin = 0
    
    var yspot = 700
    
    var timerCount = 0
    
    var times = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load up the array to display later
        print("game mode: \(game_mode)")
        
        for i in 1...3 {
            for j in 1...5 {
                let imgMe = UIImage(named: "\(i)-\(j)")
                imgMe?.accessibilityIdentifier = "\(i)-\(j)"
                sortImg.append(imgMe!)
            }
        }
        
        sortImg = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: sortImg) as! [UIImage]
        
        
        // Do any additional setup after loading the view.
        let bgImg = UIImageView(frame: self.view.bounds)
        bgImg.image = UIImage(named: "air-land-water")
        bgImg.contentMode = .scaleToFill
        bgImg.isUserInteractionEnabled = false
        self.view.addSubview(bgImg)
        self.view.sendSubview(toBack: bgImg)
        
        self.navigationController?.title = "Sort Game!"
        self.title = "Sort Game!"
        
        let imgContainer = UIView(frame: CGRect(x: 0, y: 65, width: 1024, height: 110))
        imgContainer.isUserInteractionEnabled = false
        imgContainer.backgroundColor = UIColor.blue
        imgContainer.alpha = 0.5
        self.view.addSubview(imgContainer)
        
        // setup imgviews across the top 80x80
        for i in 1...12 {
            
            buttonIcon = UIButton(frame: CGRect(x: xloc, y: yloc, width: 80, height: 80))
            buttonIcon.setBackgroundImage(sortImg[i], for: .normal)
            buttonIcon.tag = i
            buttonIcon.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(movingButton(sender:))))
            //icon = displayInitial(icon)
            //icon.isUserInteractionEnabled = true
            //icon.addGestureRecognizer(tapGesture)
            if game_mode == 10 {
                if i == 1 || i == 2 || i == 11 || i == 12{
                buttonIcon.isHidden = true
                }
            }
            if game_mode == 11 {
                if i == 1 || i == 12 {
                    buttonIcon.isHidden = true
                }
            }
            
            //buttonIcon.addTarget(self,
                            //action: #selector(drag(control:event:)),
                             //for: UIControlEvents.touchDragInside)
            //buttonIcon.addTarget(self,
              //               action: #selector(drag(control:event:)),
                //             for: [UIControlEvents.touchDragExit,
                  //                 UIControlEvents.touchDragOutside])
            //icon.isHidden = true
            xloc = xloc + 82
            self.view.addSubview(buttonIcon)
            self.view.bringSubview(toFront: buttonIcon)
            
            
            
        }
        //buttonIcon.addGestureRecognizer(buttonDrag)
        let timeImg = UIImageView(frame: CGRect(x: 0, y: yspot, width: 150, height: 55))
        setStartTime()
        startTimer()
        
        timeImg.image = UIImage(named: "time")
        //timeImg.contentMode = .topLeft
        self.view.addSubview(timeImg)
        
        
        
        
        minutes.frame = CGRect(x: 160, y: yspot, width: 45, height: 55)
        minutes.image = UIImage(named: "cartoon-number-\(timeMin)")
        self.view.addSubview(minutes)
        
        tenSec.frame = CGRect(x: 222, y: yspot, width: 45, height: 55)
        tenSec.image = UIImage(named: "cartoon-number-\(timeTenSec)")
        self.view.addSubview(tenSec)
        
        seconds.frame = CGRect(x: 272, y: yspot, width: 45, height: 55)
        seconds.image = UIImage(named: "cartoon-number-\(timeSec)")
        self.view.addSubview(seconds)
        
        
        
        createLandAreas()
        //self.view.addGestureRecognizer(buttonDrag)
        //displayInitial()
        
        
    }
    
    func createLandAreas() {
        land = UIView(frame: CGRect(x: 735, y: 432, width: 289, height: 336))
        land.isUserInteractionEnabled = false
        //land.backgroundColor = UIColor.yellow
        //land.alpha = 0.5
        self.view.addSubview(land)
        self.view.sendSubview(toBack: land)
        land2 = UIView(frame: CGRect(x: 502, y: 603, width: 240, height: 165))
        land2.isUserInteractionEnabled = false
        //land2.backgroundColor = UIColor.yellow
        //land2.alpha = 0.5
        self.view.addSubview(land2)
        self.view.sendSubview(toBack: land2)
        
        sea = UIView(frame: CGRect(x: 0, y: 432, width: 501, height: 336))
        sea.isUserInteractionEnabled = false
        //sea.backgroundColor = UIColor.green
        //sea.alpha = 0.5
        self.view.addSubview(sea)
        sea2 = UIView(frame: CGRect(x: 501, y: 432, width: 234, height: 170))
        sea2.isUserInteractionEnabled = false
        //sea2.backgroundColor = UIColor.green
        //sea2.alpha = 0.5
        self.view.addSubview(sea2)
    }
    
    //func imgTap(gesture: UIGestureRecognizer) {
     //   if (gesture.view as? UIImageView) != nil {
       //     print("Image Tapped")
        //}
   // }
    
    func displayInitial(){
        
        for i in 1...12 {
            let something = UIImageView().viewWithTag(i)
        if game_mode == 10 {
            // 1 2 11 12
            if something?.tag == 1 || something?.tag == 2 || something?.tag == 11 || something?.tag == 12 {
                something?.isHidden = true
               
            }
            }
            else if game_mode == 11 {
            // 1 12
            if something?.tag == 1 || something?.tag == 12 {
                something?.isHidden = true
               
            }
        }
        
        }
    }

    // hit test
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func movingButton(sender: UIPanGestureRecognizer) {
        print("move triggered")
        //let newLoc = buttonDrag.location(in: self.view)
        //var button = buttonIcon.center
        let buttonTag = (sender.view?.tag)!
        print("here with tag: \(buttonTag)")
        var ogCenter = CGPoint()
        
       
        //let buttSpot = CGRect(x: newLoc.x, y: newLoc.y, width: 80, height: 80)
        //self.buttonIcon.frame = buttSpot
        //let location = sender.location(in: view)
        //let velocity = sender.velocity(in: view)
        //let translation = sender.translation(in: view)
        
        
        if let button = view.viewWithTag(buttonTag) as? UIButton {
            if count == 0 {
                ogLoc = button.frame }
        /*if sender.state == .began {
            print("Gesture began")
        } else if sender.state == .changed {
            button.center = CGPoint(x: button.x + translation.x, y: button.y + translation.y)
            print("Gesture is changing")
        } else if sender.state == .ended {
            print("Gesture ended")
        }*/
            if sender.state == .began {
               ogCenter = button.center // store old button center
            } else if sender.state == .failed || sender.state == .cancelled {
                button.center = ogCenter // restore button center
            } else if sender.state == .changed{
                let location = sender.location(in: view) // get pan location
                count = count + 1
                button.center = location // set button to where finger is
            } else if sender.state == .ended {
                // this is where we can check if its in bounds
                buttonLocCheck(button)
                
                
                if isInBounds == 1 {
                    print("ok it works")
                    let location = sender.location(in: view) // get pan location
                    button.center = location
                    button.isEnabled = false
                    isInBounds = 0
                }
                
                else {
                    // animate that transition back
                    //button.frame = ogLoc
                    //button.isHidden = true
                    //var buttonplay = button
                    animBack(v: button)
                    //buttonplay.frame = ogLoc
                    //button.isHidden = false
                    //button.center = ogLoc
                    count = 0
                }
            }
            
        }
        
    }
    
    func myPanAction(recognizer: UIPanGestureRecognizer) {
    let translation = recognizer.translation(in: self.view)
    if let myView = recognizer.view {
    myView.center = CGPoint(x: myView.center.x + translation.x, y: myView.center.y + translation.y)
    }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }

    
    func drag(control: UIControl, event: UIEvent) {
        if let center = event.allTouches?.first?.location(in: self.view) {
            control.center = center
        }
    }
    
    func animBack(v: UIButton){
        
        //let speedx = v.center.x/100
        let speed = v.center.y/100
        //let speed = CGPoint(x: speedx, y: speedy)
        

        
        UIButton.animate(withDuration: TimeInterval(speed), delay: 0, options: [], animations: {
            v.frame.origin.y = self.ogLoc.origin.y
            v.frame.origin.x = self.ogLoc.origin.x
            
        }, completion: nil)
    }

    
    
    func buttonLocCheck(_ button: UIButton) {
        let buttTag = button.tag
        let buttonCheck = sortImg[buttTag].accessibilityIdentifier!
        
        if buttonCheck == "1-1" || buttonCheck == "1-2" || buttonCheck == "1-3" || buttonCheck == "1-4" || buttonCheck == "1-5" {
            // air
            isInBounds = 1
        }
        if buttonCheck == "2-1" || buttonCheck == "2-2" || buttonCheck == "2-3" || buttonCheck == "2-4" || buttonCheck == "2-5" {
            // sea
            if sea.frame.contains(button.center) || sea2.frame.contains(button.center) {
                isInBounds = 1
            }
        }
        if buttonCheck == "3-1" || buttonCheck == "3-2" || buttonCheck == "3-3" || buttonCheck == "3-4" || buttonCheck == "3-5" {
            // land
            if land.frame.contains(button.center) || land2.frame.contains(button.center) {
                isInBounds = 1
            }
        }
        
    }
    
    // timer stuff below
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
