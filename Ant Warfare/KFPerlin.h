/* coherent noise function over 1, 2 or 3 dimensions */
/* (copyright Ken Perlin) */
/* http://www.flipcode.com/archives/Perlin_Noise_Class.shtml */
/*
 * Use Perlin *perlin = new Perlin(x,x,x,x) to create the noise
 * then use perlin.Get(x,y) to retrive the noise in that spot.
 * Note: any point coordinate has to be normalized first!
 *
 * The first parameter is the number of octaves, this is how noisy or smooth the function is.
 * This is valid between 1 and 16. A value of 4 to 8 octaves produces fairly conventional noise results.
 *
 * The second parameter is the noise frequency. Values betwen 1 and 8 are reasonable here.
 * You can try sampling the data and plotting it to the screen to see what numbers you like.
 *
 * The third parameter is the amplitude. Setting this to a value of 1 will return randomized samples between -1 and +1.
 *
 * The last parameter is the random number seed
 */
/*
 MIT License
 
 Copyright (c) 2013 Fredrik Sjöberg
 
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 * Created by Fredrik Sjöberg on 2013-02-17.
 *
 * Objective-c implementation of Ken Perlin's noise function
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark - Interface
@interface KFPerlin : NSObject {
}

@property (nonatomic, readonly) int mOctaves;
@property (nonatomic, readonly) float mFrequency;
@property (nonatomic, readonly) float mAmplitude;
@property (nonatomic, readonly) int mSeed;


#pragma mark - Init
-(id) initWithOctaves:(int)octaves frequency:(float)frequency amplitude:(float)amplitude seed:(int)seed;

#pragma mark - GetNoise
-(float) getNoise:(CGPoint)point;
-(float) getNormalizedNoise:(CGPoint)point;


@end