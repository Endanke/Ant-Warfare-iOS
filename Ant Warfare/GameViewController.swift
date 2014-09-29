//
//  GameViewController.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 09. 29..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var centerLabel: UILabel!
    var canvas : Canvas?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas = Canvas(frame: CGRectMake(0, 0, 200, 200))
        self.view.addSubview(canvas!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        centerLabel.text = Head.shared().textText
        if(Head.shared().preloadedSubview != nil){
            self.view.addSubview(Head.shared().preloadedSubview!)
        }
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
