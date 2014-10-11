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
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect){
        let context = UIGraphicsGetCurrentContext()
        
        let color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.000)
        
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(frame.size.width/2-size/2, frame.size.height/2-size/2, size, size))
        CGContextSaveGState(context)
        color.setStroke()
        ovalPath.lineWidth = 5.0
        ovalPath.stroke()
        CGContextRestoreGState(context)
    }
    
}
