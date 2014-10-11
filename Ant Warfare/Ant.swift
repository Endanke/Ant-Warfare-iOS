//
//  Ant.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 10. 09..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class Ant: NSObject {
    var view : AntView?
    var position : CGPoint?
    var tpos : CGPoint?
    var size : CGFloat?
    var color : UIColor?
    var p : Perlin?
    
    override init(){
        super.init()
        size = 0.0
        position = CGPointMake(0, 0)
        tpos = CGPointMake(CGFloat(arc4random_uniform(10)), CGFloat(arc4random_uniform(10)))
        //tpos = CGPointMake(0, 0)
        p = Perlin(seed: 10)
    }
    
    func step(){
        let x = p!.interpolatedNoise1D(Float(tpos!.x))
        let y = p!.interpolatedNoise1D(Float(tpos!.y))
        let screenSize: CGRect = UIScreen.mainScreen().bounds

        println(y)
        
        view!.center = CGPointMake((CGFloat(x)*screenSize.width/3)+screenSize.width/2, (CGFloat(y)*screenSize.height/3)+screenSize.height/2)
        
        tpos = CGPointMake(tpos!.x + 0.01, tpos!.y + 0.01)
        
        if(size < 10.0){
            size! += 0.1
            view!.setNeedsDisplay()
        }
        
    }
    
    
}
