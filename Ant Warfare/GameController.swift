//
//  GameController.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 10. 09..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class GameController: NSObject {
    var ants : NSMutableArray
    
    override init() {
        ants = NSMutableArray()
        ants.addObject(Ant())
        ants.addObject(Ant())
        ants.addObject(Ant())
        super.init()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        for object in ants{
            let ant = object as Ant
            ant.step()
        }
    }
}
