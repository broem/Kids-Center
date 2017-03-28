//
//  ViewController.swift
//  Kids Joy Center
//
//  Created by Ben on 3/16/17.
//  Copyright © 2017 Benjamin Leach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mem_btn: UIButton!
    @IBOutlet weak var sort_btn: UIButton!
    
    //@IBOutlet weak var popUp: UIView!
    @IBOutlet weak var play_btn: UIButton!
    @IBOutlet weak var hard_lvl_btn: UIButton!
    @IBOutlet weak var med_lvl_btn: UIButton!
    @IBOutlet weak var easy_lvl_btn: UIButton!
    @IBOutlet weak var pop_btn: UIButton!
    var popUp = UIView()
    var popTitle = UILabel()
    var popLabel1 = UILabel()
    var popLabel2 = UILabel()
    var popLabel3 = UILabel()
    var popLabel4 = UILabel()
    var popLabel5 = UILabel()
    var popButton = UIButton()
    var popBack = UIView()
    
    //@IBOutlet weak var centerPop: NSLayoutConstraint!
    var isGameClicked = 0
    var isModeClicked = 0
    var isPlayCLicked = 0
    
    var saveScores = [Scores]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImg = UIImageView(frame: self.view.bounds)
        bgImg.image = UIImage(named: "back-main")
        bgImg.contentMode = .scaleToFill
        bgImg.alpha = 0.2
        
        self.view.addSubview(bgImg)
        self.view.sendSubview(toBack: bgImg)
        
        popBack = UIView(frame: self.view.bounds)
        popBack.backgroundColor = UIColor.white
        popBack.alpha = 0.0
        self.view.addSubview(popBack)
        
        //let mem = UIImage(named: "memory")
        // Do any additional setup after loading the view, typically from a nib.
        mem_btn.setImage(UIImage(named: "memory")!, for: UIControlState.normal)
        sort_btn.setImage(UIImage(named: "sorting-icon")!, for: UIControlState.normal)
        pop_btn.setImage(UIImage(named: "balloon-game-logo3")!, for: .normal)
        
        mem_btn.tag = 1
        sort_btn.tag = 2
        pop_btn.tag = 3
        
        easy_lvl_btn.tag = 10
        med_lvl_btn.tag = 11
        hard_lvl_btn.tag = 12
        
        play_btn.tag = 20
        
        popUp = UIView(frame: CGRect(x: -800, y: 210, width: 350, height: 350))
        
        popTitle = UILabel(frame: CGRect(x: 145, y: 8, width: 200, height: 25))
        
        popTitle.textColor = UIColor.white
        popTitle.font = popTitle.font.withSize(16)
        popTitle.text = "High Scores!"
        
        popLabel1 = UILabel(frame: CGRect(x: 23, y: 55, width: 200, height: 25))
        popLabel1.text = "1. ---"
        popLabel1.textColor = UIColor.white
        popLabel1.tag = 1
        popLabel2 = UILabel(frame: CGRect(x: 23, y: 105, width: 200, height: 25))
        popLabel2.text = "2. ---"
        popLabel2.textColor = UIColor.white
        popLabel2.tag = 2
        popLabel3 = UILabel(frame: CGRect(x: 23, y: 155, width: 200, height: 25))
        popLabel3.text = "3. ---"
        popLabel3.textColor = UIColor.white
        popLabel3.tag = 3
        popLabel4 = UILabel(frame: CGRect(x: 23, y: 205, width: 200, height: 25))
        popLabel4.text = "4. ---"
        popLabel4.textColor = UIColor.white
        popLabel4.tag = 4
        popLabel5 = UILabel(frame: CGRect(x: 23, y: 255, width: 200, height: 25))
        popLabel5.text = "5. ---"
        popLabel5.textColor = UIColor.white
        popLabel5.tag = 5
        
        popButton = UIButton(frame: CGRect(x: 145, y: 312, width: 100, height: 25))
        popButton.setTitle("Dismiss", for: .normal)
        popButton.setTitleColor(UIColor.red, for: .normal)
        popButton.addTarget(self, action: #selector(popAway), for: .touchUpInside)
        popUp.backgroundColor = UIColor.blue
        //popUp.alpha = 0.4
        
        popUp.addSubview(popTitle)
        popUp.addSubview(popLabel1)
        popUp.addSubview(popLabel2)
        popUp.addSubview(popLabel3)
        popUp.addSubview(popLabel4)
        popUp.addSubview(popLabel5)
        popUp.addSubview(popButton)
        popUp.layer.cornerRadius = 10
        
        
        self.view.addSubview(popUp)
        
        //popUp.center.x = -800
        //self.view.addSubview(popUp)
       
        play_btn.setImage(UIImage(named: "PlayButton")!, for: .normal)
        self.navigationController?.title = "Kids Joy Center"
        self.title = "Kids Joy Center"
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        //button.setBackgroundImage(#imageLiteral(resourceName: "cart"), for: UIControlState.normal)
        button.setTitle("High Scores", for: UIControlState.normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(popItUp), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        if let savedScores = UserDefaults.standard.object(forKey: "savedScores") as? Data {
            saveScores = NSKeyedUnarchiver.unarchiveObject(with: savedScores) as! [Scores]
        }
        
        let count = saveScores.count
        print("saved? \(count)")
        
    }
    
//    @IBAction func popClick(_ sender: UIButton ) {
//        self.performSegue(withIdentifier: "popup", sender: self)
//    }
    
    func popAway() {
        popUp.frame.origin.x = -800
        popBack.alpha = 0.0
    }
    
    func popItUp() {
        
        print("adding pop up")
        popBack.alpha = 0.5
        popUp.frame.origin.x = 337
        //centerPop.constant = 0
        //popUp.center.x = 0
        //let newVC = UIViewController()
        //newVC.view.backgroundColor = UIColor.blue
        //newVC.view.isOpaque = true
//        self.addChildViewController(newVC)
//        newVC.modalPresentationStyle = .overCurrentContext
//        newVC.modalTransitionStyle = .crossDissolve
//        
//        newVC.preferredContentSize = CGSize(width: 300, height: 300)
//        self.addChildViewController(newVC)
        //let fr = CGRect(x: 30, y: 30, width: 1, height: 1)
        //let midView = UIView(frame: fr)
        //self.view.addSubview(midView)
        
        //let pop = newVC.popoverPresentationController
        //pop?.sourceView = midView
        
        //show(newVC, sender: midView)
        
        
    }
    
    func sortScores() {
        saveScores = saveScores.sorted { $0.score > $1.score}
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        print("game: \(isGameClicked)")
//        print("mode: \(isModeClicked)")
        
        // reset
        isGameClicked = 0
        isModeClicked = 0
        mem_btn.alpha = 1
        sort_btn.alpha = 1
        pop_btn.alpha = 1
        easy_lvl_btn.alpha = 1
        med_lvl_btn.alpha = 1
        hard_lvl_btn.alpha = 1
        if let savedScores = UserDefaults.standard.object(forKey: "savedScores") as? Data {
            saveScores = NSKeyedUnarchiver.unarchiveObject(with: savedScores) as! [Scores]
        }
        var count = saveScores.count
        if count > 5 {
            count = 5
        }
        print("save count: \(count)")
        
        sortScores()
        
        for i in 1...count {
            let lab = popUp.viewWithTag(i) as! UILabel
            lab.text = "\(i). \(saveScores[i-1].theRest) \(saveScores[i-1].score)"
        }
        //popUp.removeFromSuperview()
//        print("game: \(isGameClicked)")
//        print("mode: \(isModeClicked)")
    }
    
    
    
    
    @IBAction func game_click(_ sender: UIButton){
        if sender.tag <= 3 {
            isGameClicked = sender.tag
            sender.isHighlighted = true
            //sender.alpha = 0.2
            // this is going to be UGLY
            
                if sender.tag == mem_btn.tag {
                    mem_btn.alpha = 1
                    pop_btn.alpha = 0.2
                    sort_btn.alpha = 0.2
                    
                }
            if sender.tag == sort_btn.tag {
                mem_btn.alpha = 0.2
                pop_btn.alpha = 0.2
                sort_btn.alpha = 1
                
            }
            if sender.tag == pop_btn.tag {
                mem_btn.alpha = 0.2
                pop_btn.alpha = 1
                sort_btn.alpha = 0.2
                
            }
            
            //sender.isHighlighted = true
            print("clicked game: \(isGameClicked)")
        }
        else if sender.tag <= 12 && sender.tag >= 10 {
            isModeClicked = sender.tag
            if sender.tag == easy_lvl_btn.tag {
                easy_lvl_btn.alpha = 1
                med_lvl_btn.alpha = 0.2
                hard_lvl_btn.alpha = 0.2
                
            }
            if sender.tag == med_lvl_btn.tag {
                easy_lvl_btn.alpha = 0.2
                hard_lvl_btn.alpha = 0.2
                med_lvl_btn.alpha = 1
                
            }
            if sender.tag == hard_lvl_btn.tag {
                easy_lvl_btn.alpha = 0.2
                hard_lvl_btn.alpha = 1
                med_lvl_btn.alpha = 0.2
                
            }

            
            print("clicked mode: \(isModeClicked)")
        }
    }
    
    @IBAction func play_click(_ sender: UIButton) {
        if sender.tag == 20 && isGameClicked > 0 && isModeClicked > 0 {
            if isGameClicked == 1 {
                
                self.performSegue(withIdentifier: "memory", sender: self)
            }
            if isGameClicked == 2 {
                self.performSegue(withIdentifier: "sort", sender: self)
                print("sort!\n")
            }
            if isGameClicked == 3 {
                self.performSegue(withIdentifier: "pop", sender: self)
                print("pop\n")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "memory" {
            if let sendMem = segue.destination as? MemoryVC {
                sendMem.game_mode = isModeClicked
                sendMem.saveScores = saveScores
            }
        }
            if segue.identifier == "sort" {
                if let sendSort = segue.destination as? SortVC {
                   sendSort.game_mode = isModeClicked
                    sendSort.saveScores = saveScores
                }
        }
        if segue.identifier == "pop" {
            if let sendPop = segue.destination as? PopVC {
                sendPop.game_mode = isModeClicked
                sendPop.saveScores = saveScores
            }
        }
//        if segue.identifier == "popup" {
//            if let popup = segue.destination as? Pops {
//                
//            }
//        }
    }


}

