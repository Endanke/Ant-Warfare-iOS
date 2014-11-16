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
    var destination : CGPoint?
    var size : CGFloat?
    var targetSize : CGFloat?
    var color : UIColor?
    var p : KFPerlin?
    var randomStep = true
    var out = false
    var enemy = false
    var strike = 0
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    override init(){
        super.init()
        size = 0.0
        targetSize = 50.0
        position = CGPointMake(0, 0)
        tpos = CGPointMake(CGFloat(arc4random_uniform(10)), CGFloat(arc4random_uniform(10)))
        //tpos = CGPointMake(0, 0)
        p = KFPerlin(octaves: 1, frequency: 0.5, amplitude: 1.2, seed: 10)
    }
    
    func arrived(){
        if(enemy){
           randomStep = false
        }else{
           out = true
        }
    }
    
    func step(){
        if(randomStep){
            if(tpos!.x > 10){
                tpos = CGPointMake(0, 0)
            }

            let x = p!.getNoise(CGPointMake(tpos!.x, 0))
            let y = p!.getNoise(CGPointMake(0, tpos!.y))
            
            println(y)
            
            view!.center = CGPointMake((CGFloat(x)*screenSize.width/3)+screenSize.width/2, (CGFloat(y)*screenSize.height/3)+screenSize.height/2)
            
            tpos = CGPointMake(tpos!.x + 0.01, tpos!.y + 0.01)
            
        }else{
            if(view!.center.x < destination?.x){
                view!.center = CGPointMake(view!.center.x + 0.3, view!.center.y)
            }
            if(view!.center.x > destination?.x){
                view!.center = CGPointMake(view!.center.x - 0.3, view!.center.y)
            }
            
            if(view!.center.y < destination?.y){
                view!.center = CGPointMake(view!.center.x, view!.center.y + 0.3)
            }
            if(view!.center.y > destination?.y){
                view!.center = CGPointMake(view!.center.x, view!.center.y - 0.3)
            }
            if(view!.center.x > screenSize.width || view!.center.x < 0 || view!.center.y < 0 || view!.center.y > screenSize.height){
                arrived()
            }
            
        }
        if(targetSize == 0){
            if(size > targetSize){
                size! -= 0.2
                view!.setNeedsDisplay()
            }else{
                self.view!.hidden = true
                GameController.sharedInstance.ants.removeAtIndex(find(GameController.sharedInstance.ants, self)!)
            }
        }else if(size < targetSize){
            size! += 0.1
            view!.setNeedsDisplay()
        }
    }
    
    
}
