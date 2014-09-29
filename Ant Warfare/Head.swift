//
//  Head.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 09. 29..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

var instance: Head?

class Head: NSObject {
    var mainViewController : ViewController?
    var gameViewController : GameViewController?
    var settingsViewController : SettingsViewController?
    var textText : NSString?
    var preloadedSubview : UIView?
    
    class func shared() -> Head {
        if(instance == nil) {
            instance = Head()
        }
        return instance!
    }
    
    func preloadView(){
        if(preloadedSubview == nil){
            preloadedSubview = UIView(frame: CGRectMake(100, 100, 200, 200))
            preloadedSubview?.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        }
    }
}
