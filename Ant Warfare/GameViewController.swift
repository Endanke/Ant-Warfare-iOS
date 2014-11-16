//
//  GameViewController.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 09. 29..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, MPGameDelegate{
    
    var background : Background?
    var counter : CGFloat = 0.0
    var color = UIColor.redColor()
    var timer : NSTimer?
    
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var gameOverLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MPManager.sharedInstance().gameDelegate = self
        
        if(background == nil){
            background = Background(frame: self.view.bounds)
            self.view.addSubview(background!)
        }
        
        color = MPManager.sharedInstance().position == 0 ? UIColor.redColor() : UIColor.grayColor()
        
        GameController.sharedInstance.newGame()
        
        for object in GameController.sharedInstance.ants{
            let ant = object as Ant
            ant.view = AntView(frame: CGRectMake(0, 0, 50, 50))
            ant.view!.ant = ant
            ant.view!.color = color
            self.view.addSubview(ant.view!)
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.background!.alpha = 1
        self.gameOverLabel.alpha = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.view.bringSubviewToFront(testButton)
        testButton.center = MPManager.sharedInstance().position == 0 ? CGPointMake(testButton.center.x + 100, testButton.center.y) : CGPointMake(testButton.center.x - 100, testButton.center.y)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer!.invalidate()
    }
    
    @IBAction func testPressed(sender: AnyObject) {
        GameController.sharedInstance.send(CGPointMake(MPManager.sharedInstance().position == 0 ? self.view.bounds.size.width+30 : -30, self.view.bounds.size.height/2))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        if(!GameController.sharedInstance.gameOver){
            counter += 0.01
            if(counter >= 5){
                if(GameController.sharedInstance.ants.count < 10){
                    // TODO: maximize number of ants
                    println("5secpassed")
                    let ant = Ant()
                    ant.view = AntView(frame: CGRectMake(0, 0, 50, 50))
                    ant.view!.ant = ant
                    ant.view!.color = color
                    ant.view!.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2)
                    self.view.addSubview(ant.view!)
                    GameController.sharedInstance.ants.append(ant)
                }
                counter = 0.0
            }
            
            GameController.sharedInstance.update()
            self.background!.scale += 0.01
            self.background!.setNeedsDisplay()
        }else{
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.background!.alpha = 0
                self.gameOverLabel.alpha = 1
            })
        }
    }
    
    //MARK: - MPGameDelegate methods
    
    func setWin(){
        GameController.sharedInstance.gameOver = true
        self.gameOverLabel.text = "YOU WIN!\n▐ ・ ‿ ・▐"
    }
    
    func incomingAntWithY(y: Int32) {
        let ant = Ant()
        ant.enemy = true
        ant.view = AntView(frame: CGRectMake(0, 0, 50, 50))
        ant.view!.ant = ant
        ant.size = ant.targetSize
        ant.randomStep = false
        ant.view?.center = MPManager.sharedInstance().position == 0 ? CGPointMake(self.view.bounds.size.width + 30, self.view.bounds.size.height/2) : CGPointMake(-30, self.view.bounds.size.height/2)
        ant.destination = CGPointMake(self.view.bounds.size.width/2 , self.view.bounds.size.height/2)
        // Switched colors
        ant.view!.color = MPManager.sharedInstance().position == 0 ? UIColor.grayColor() : UIColor.redColor()
        self.view.addSubview(ant.view!)
        GameController.sharedInstance.ants.append(ant)
       // gc.send(ant, to:self.view.center)
    }
    
    func playerSetMayHaveChanged() {
        
    }

}
