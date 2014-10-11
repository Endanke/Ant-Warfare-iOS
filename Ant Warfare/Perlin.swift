//
//  Perlin.swift
//  Ant Warfare
//
//  Created by Eke Dániel on 2014. 10. 10..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class Perlin: NSObject {
    /*
    
    - (id)initWithSeed:(int)seed;
    - (float)perlin1DValueForPoint:(float)x;
    - (float)perlin2DValueForPoint:(float)x :(float)y;
    
    */
    
    enum InterpolationType : Int{
        case kLinearInterpolation = 0
        case kCosineInterpolation = 1
    }
    
    var seed : Int?
    var octaves : Int?
    var persistence : Float?
    var scale : Float?
    var frequency : Float?
    var amplitude : Float?
    var interpolationMethod : InterpolationType?
    var smoothing : Bool?
    
    init(seed : Int){
        self.seed = seed
        self.smoothing = false
        self.interpolationMethod = InterpolationType.kLinearInterpolation
        self.octaves = 1
        self.scale = 1
        self.frequency = 0.5
        self.amplitude = 0.0
        self.persistence = sqrt(self.amplitude!)
        super.init()
    }
    
    func linearInterpolationBetween(a : Float, b : Float, x: Float) -> Float{
        return a * (1 - x) + b * x ;
    }
    
    func cosineInterpolationBetween(a : Float, b : Float, x: Float) -> Float{
        var ft = x * 3.1415927;
        var f = (1 - Float(cos(ft))) * 0.5;
        return a * (1 - f) + b * f;
    }
    
    func makeNoise1D(var x : Int) -> Float{
        x = (x >> 13) ^ x;
        x = (x &* (x &* x &* seed! + 19990303) + 1376312589) & 0x7fffffff
        var inner = (x &* (x &* x &* 15731 &+ 789221) &+ 1376312589) & 0x7fffffff
        let a = Float(inner)
        return ( 1.0 - ( Float(inner) ) / 1073741824.0)
    }
    
    func smoothedNoise1D(var x : Float) -> Float{
        return (self.makeNoise1D(Int(x)) / 2 + self.makeNoise1D(Int(x)-1)/4 + self.makeNoise1D(Int(x)+1)/4)
    }
    
    func interpolatedNoise1D(var x : Float) -> Float{
        var integer_x = Int(x)
        var fractional_x = x - Float(integer_x)
        
        var v1 = self.smoothedNoise1D(Float(integer_x))
        var v2 = self.smoothedNoise1D(Float(integer_x)+1)
        
        if (interpolationMethod == InterpolationType.kCosineInterpolation) {
            return self.cosineInterpolationBetween(v1, b: v2, x: fractional_x)
        } else {
            return self.linearInterpolationBetween(v1, b: v2, x: fractional_x)
        }
        
    }
    
    func perlin1DValueForPoint(var x : Float) -> Float{
        var value = 0 as Float
        var persistence = self.persistence;
        var frequency = self.frequency;
        var amplitude : Float
        
        for (var i = 0; i < octaves; i++) {
            frequency = powf(frequency!, Float(i));
            amplitude = powf(persistence!, Float(i));
            
            if ((smoothing) != nil) {
                value = value + self.interpolatedNoise1D(x * frequency!) * frequency! * amplitude
            } else {
                value = value + self.makeNoise1D(Int(x * frequency!)) * frequency! * amplitude
            }
        }
        
        value = value / Float(octaves!) * scale!
        
        return value
        
    }
}
