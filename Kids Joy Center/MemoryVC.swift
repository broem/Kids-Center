//
//  MemoryVC.swift
//  Kids Joy Center
//
//  Created by Ben on 3/16/17.
//  Copyright © 2017 Benjamin Leach. All rights reserved.
//

import UIKit
import AVFoundation
import GameplayKit

class MemoryVC: UIViewController {
    
    var cheerPlayer = AVAudioPlayer()
    
    var saveScores = [Scores]()
    
    var score = 0
    var scoreviewHundreds = UIImageView()
    var scoreViewTens = UIImageView()
    var scoreViewOnes = UIImageView()
    
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
    
    var buttonArray = [UIButton]()
    
    var gameName = "Memory "
    
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
    
    var victoryScore = 0
    
    var scoreTimer = Timer()
    
    var numToCompare = "0"
    var lastClicked = -1
    var lastButton = UIButton()
    
    // score calculating
    var scoreStartTime = 0
    var scoreEndTime = 0
    
    
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
        
        if game_mode == 10 {
            gameName += "Easy"
        }
        if game_mode == 11 {
            gameName += "Medium"
        }
        if game_mode == 12 {
            gameName += "Hard"
        }
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
    }
    override func viewDidAppear(_ animated: Bool) {

        setupButtons()

        print("game lvl = \(game_mode)")
        
        generateBoard()
        
        let audioPath = Bundle.main.path(forResource: "cheer", ofType: "mp3")
        
        do{
            cheerPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch{
            
        }
    }
    
    func setupButtons() {
        if game_mode == 10 {
            gridSize = 3
            adjustable = 120
            //gameName += "Easy"
        }
        
        if game_mode == 11 {
            gridSize = 4
            adjustable = 60
            //gameName += "Medium"
        }
        
        if game_mode == 12 {
            gridSize = 5
            //gameName += "Hard"
        }
        
        arraySize = 4 * gridSize
        
        let maxSize = arraySize / 2
        
        print("max size: \(maxSize)")
        
        for i in 1...10 {
            let imgToAdd = UIImage(named: "\(i)")
            imgToAdd?.accessibilityIdentifier = "\(i)"
            
            randomGameImg.append(imgToAdd!)
        }
        // shuffle the images
        randomGameImg = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: randomGameImg) as! [UIImage]
        let ok = randomGameImg.count
        print("array size count: \(ok)")
        
        for i in 0...maxSize - 1 {
            
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
                //print("tagged: \(taggem)")
                gameButton.tag = taggem
                
                gameButton.addTarget(self, action: #selector(questionClicked(_:)), for: UIControlEvents.touchUpInside)
                
                buttonArray.append(gameButton)
                self.view.addSubview(gameButton)
            
                xStart = xStart + 120
                taggem =  taggem + 1
            }
            xStart = 210 + adjustable
            yStart = yStart + 120
            
        }
    }
    
    func restartBoard() {
//        taggem = 0
//        for _ in 1...4 {
//            for _ in 1...gridSize {
//                
//                gameButton.viewWithTag(taggem)?.sendSubview(toBack: self.view)
//                gameButton.viewWithTag(taggem)?.removeFromSuperview()
//                taggem += 1
//            }
//        }
        for btn in buttonArray {
            btn.removeFromSuperview()
        }
    }
    
    
    func questionClicked (_ sender: UIButton) {
        //scoreStartTime = 0
        print("sender: \(sender.tag)")
        sender.setBackgroundImage(shuffledArray[sender.tag], for: .normal)
        sender.isUserInteractionEnabled = false
        let imgsAreTheSame = shuffledArray[sender.tag].accessibilityIdentifier
        
        if lastClicked == -1 {
            // lastclicked now equals previous location
            lastClicked =  sender.tag
            lastButton = sender
            numToCompare = imgsAreTheSame!
            self.scoreStartTime = 0
            scoreTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
                //self.scoreStartTime = 0
                self.scoreStartTime = self.scoreStartTime + 1
            }
            
        }
        
        else if numToCompare == imgsAreTheSame {
            // both of these should remain unclickable
            //print("this actually works damn")
            
            print("Score timer: \(scoreStartTime)")
            scoreTimer.invalidate()
            numToCompare = "0"
            lastClicked = -1
            // play cheer sound
            cheerPlayer.play()
            //let timeBetweenGuesses = scoreEndTime - scoreStartTime
            if (scoreStartTime <= 3) {
                scoreStartTime = 0
                score = score + 5
            }
            else if (scoreStartTime <= 7) {
                scoreStartTime = 0
                score = score + 4
            }
            else {
                scoreStartTime = 0
                score = score + 3
            }
            victoryScore = victoryScore + 1
            checkVictory()
            
        }
        else {
            
            print("waiting...")
            
            numToCompare = imgsAreTheSame!
            scoreStartTime = 0
           
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
        scoreStartTime = 0
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
    
    func checkForEnd() {
        if (timerCount == 0) {
            times.invalidate()
            scoreTimer.invalidate()
            let alert = UIAlertController(title: "You LOSE!", message: "You've lost, would you like to play again?", preferredStyle: .alert)
            let myAction = UIAlertAction(title: "Yes", style: .default, handler: { action in self.checkVictory()})
            let second = UIAlertAction(title: "No", style: .cancel, handler: { action in self.performSegue(withIdentifier: "homeScreen", sender: self)});
            
            alert.addAction(myAction)
            alert.addAction(second)
            present(alert, animated: true, completion: nil)
            
            
            }
    }
    
    func winAlert() {
        times.invalidate()
        scoreTimer.invalidate()
        let alert = UIAlertController(title: "You Win!", message: "You've won, would you like to play again?", preferredStyle: .alert)
        let myAction = UIAlertAction(title: "Yes", style: .default, handler: { action in self.restart()})
        let second = UIAlertAction(title: "No", style: .cancel, handler: { action in self.performSegue(withIdentifier: "homeScreen", sender: self)});
        
        alert.addAction(myAction)
        alert.addAction(second)
        present(alert, animated: true, completion: nil)

        
    }
    
    func checkVictory() {
        if game_mode == 10 {
            if victoryScore == 6 {
               let ok = Scores(scores: score, rest: gameName)
                saveScores.append(ok)
                let scoreData = NSKeyedArchiver.archivedData(withRootObject: saveScores)
                UserDefaults.standard.set(scoreData, forKey: "savedScores")
                UserDefaults.standard.synchronize()
                winAlert()
            }
        }
        if game_mode == 11 {
            if victoryScore == 8 {
                // send home, store score
                let ok = Scores(scores: score, rest: gameName)
                saveScores.append(ok)
                let scoreData = NSKeyedArchiver.archivedData(withRootObject: saveScores)
                UserDefaults.standard.set(scoreData, forKey: "savedScores")
                UserDefaults.standard.synchronize()
                winAlert()
            }
            
        }
        if game_mode == 12 {
            if victoryScore == 10 {
                let ok = Scores(scores: score, rest: gameName)
                saveScores.append(ok)
                let scoreData = NSKeyedArchiver.archivedData(withRootObject: saveScores)
                UserDefaults.standard.set(scoreData, forKey: "savedScores")
                UserDefaults.standard.synchronize()
                winAlert()
            }
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeScreen" {
            if segue.destination is ViewController {
                //sendMem.game_mode = isModeClicked
                //sendScore.saveScores = saveScores
            }
        }
    }
    
    func restart() {
        score = 0
        xStart = 210
        yStart = 190
        restartBoard()
        setStartTime()
        startTimer()
        setupButtons()
        generateBoard()
        
        
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
