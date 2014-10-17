//
//  MenuAnt.swift
//  Ant Warfare
//
//  Created by Eke Dániel on 2014. 10. 17..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class MenuAnt: UIView {

    var jumpVal : CGFloat = 1.0
    var counter : CGFloat = 1.0
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        backgroundColor = UIColor.clearColor()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        counter = counter + 0.1
        jumpVal = CGFloat((sin(counter)+1)/2)
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect){
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let color = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1.000)
        
        //// Variable Declarations
        let jumpPos = jumpVal * 30
        let shadowSize = -1 * jumpVal
        
        //// Oval 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 160, 98.5)
        CGContextScaleCTM(context, shadowSize, shadowSize)
        
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(-6, -3.5, 12, 7))
        color.setFill()
        oval2Path.fill()
        
        CGContextRestoreGState(context)
        
        
        //// Oval Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 160, 60)
        
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(-5, jumpPos, 10, 10))
        UIColor.grayColor().setFill()
        ovalPath.fill()
        
        CGContextRestoreGState(context)
    }


}
