//
//  Canvas.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 09. 29..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class Background: UIView {

    var size : CGFloat = 250
    var scale : Float = 0.0
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    override func willMoveToSuperview(newSuperview: UIView?) {
        backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect){
        let context = UIGraphicsGetCurrentContext()
        
        let color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.000)
        
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(screenSize.width/2-size/2, screenSize.height/2-size/2, size, size))
        CGContextSaveGState(context)
        color.setStroke()
        ovalPath.lineWidth = 5.0
        ovalPath.stroke()
        
        //// Oval 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, screenSize.width/2, screenSize.height/2)
        CGContextScaleCTM(context, CGFloat((sinf(scale)+1.0)/2), CGFloat((sinf(scale)+1.0)/2))
        
        var oval2Path = UIBezierPath(ovalInRect: CGRectMake(-size/2, -size/2, size, size))
        UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).setFill()
        oval2Path.fill()
        
        CGContextRestoreGState(context)
    }
    
}
