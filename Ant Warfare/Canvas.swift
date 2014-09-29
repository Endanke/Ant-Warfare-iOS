//
//  Canvas.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 09. 29..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class Canvas: UIView {

    override func drawRect(rect: CGRect){
        var ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(ctx, 0.0, 0.0, 0.0, 1);
        CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    }
    
}
