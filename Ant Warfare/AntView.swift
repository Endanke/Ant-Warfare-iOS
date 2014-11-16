//
//  AntView.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 10. 09..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class AntView: UIView {
    var color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.000)
    var ant = Ant()
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        backgroundColor = UIColor.clearColor()
    }

    override func drawRect(rect: CGRect){
        let context = UIGraphicsGetCurrentContext()
        
        let shadow = UIColor.blackColor().colorWithAlphaComponent(0.9)
        let shadowOffset = CGSizeMake(0.1, 1.1)
        let shadowBlurRadius: CGFloat = 3
        
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(ant.size!/4, ant.size!/4, ant.size!/2, ant.size!/2))
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor)
        color.setFill()
        ovalPath.fill()
        CGContextRestoreGState(context)
    }

}
