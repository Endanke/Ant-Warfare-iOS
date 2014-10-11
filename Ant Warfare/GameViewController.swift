//
//  GameViewController.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 09. 29..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var background : Background?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var gc = GameController();
        
        background = Background(frame: self.view.bounds)
        self.view.addSubview(background!)
        
        for object in gc.ants{
            let ant = object as Ant
            ant.view = AntView(frame: CGRectMake(100, 100, 50, 50))
            self.view.addSubview(ant.view!)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
