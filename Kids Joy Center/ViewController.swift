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
    
    @IBOutlet weak var play_btn: UIButton!
    @IBOutlet weak var hard_lvl_btn: UIButton!
    @IBOutlet weak var med_lvl_btn: UIButton!
    @IBOutlet weak var easy_lvl_btn: UIButton!
    @IBOutlet weak var pop_btn: UIButton!
    
    var isGameClicked = 0
    var isModeClicked = 0
    var isPlayCLicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImg = UIImageView(frame: self.view.bounds)
        bgImg.image = UIImage(named: "back-main")
        bgImg.contentMode = .scaleToFill
        bgImg.alpha = 0.2
        
        self.view.addSubview(bgImg)
        self.view.sendSubview(toBack: bgImg)
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
        
        
        
        play_btn.setImage(UIImage(named: "PlayButton")!, for: .normal)
        
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
            }
        }
            if segue.identifier == "sort" {
                if let sendSort = segue.destination as? SortVC {
                   sendSort.game_mode = isModeClicked
                }
        }
        if segue.identifier == "pop" {
            if let sendPop = segue.destination as? PopVC {
                sendPop.game_mode = isModeClicked
            }
        }
    }


}

