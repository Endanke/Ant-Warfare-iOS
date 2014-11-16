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

#import "KFPerlin.h"

#define kPerlinSampleSize 1024

#define B kPerlinSampleSize
#define BM (kPerlinSampleSize-1)

#define N 0x1000
#define NP 12   /* 2^N */
#define NM 0xfff

#define s_curve(t) ( t * t * (3.0f - 2.0f * t) )
#define lerp(t, a, b) ( a + t * (b - a) )


#pragma mark -
#pragma mark - Private
@interface KFPerlin ()

#pragma mark - Private Properties
@property (nonatomic, readwrite) int mOctaves;
@property (nonatomic, readwrite) float mFrequency;
@property (nonatomic, readwrite) float mAmplitude;
@property (nonatomic, readwrite) int mSeed;

@property (nonatomic) int *p;
@property (nonatomic) float **g2;
@property (nonatomic) float *g1;
@property (nonatomic) BOOL mStart;

#pragma mark - Private Setup
-(void) setupTables;
#pragma mark - Private Methods
-(float) generate2DNoise:(float[])vec;
-(float) noise2:(float[])vec;
-(void) normalize2:(float[])vec;
@end



#pragma mark -
#pragma mark - Implementation
@implementation KFPerlin

#pragma mark - Init
-(id) initWithOctaves:(int)octaves frequency:(float)frequency amplitude:(float)amplitude seed:(int)seed
{
    if ((self = [super init])) {
        _mOctaves = octaves;
        _mFrequency = frequency;
        _mAmplitude = amplitude;
        _mSeed = seed;
        _mStart = YES;
    }
    return self;
}

#pragma mark Private Setup
-(void) setupTables
{
    int i, j, k;
    
    _p = malloc((kPerlinSampleSize + kPerlinSampleSize + 2)*sizeof(int));
    
    _g2 = malloc((kPerlinSampleSize + kPerlinSampleSize + 2)*sizeof(float*));
    for (int i = 0; i < (kPerlinSampleSize + kPerlinSampleSize + 2); i++) {
        self.g2[i] = malloc(2*sizeof(float));
    }
    
    _g1 = malloc((kPerlinSampleSize + kPerlinSampleSize + 2)*sizeof(float));
    
    
    for (i = 0; i < B; i++) {
        self.p[i] = i;
        
        self.g1[i] = (float)((rand() % (B + B)) - B) / B;
        
        for (j = 0 ; j < 2 ; j++) {
            self.g2[i][j] = (float)((rand() % (B + B)) - B) / B;
        }
        [self normalize2:self.g2[i]];
    }
    
    while (--i)
    {
        k = self.p[i];
        self.p[i] = self.p[j = rand() % B];
        self.p[j] = k;
    }
    
    for (i = 0 ; i < B + 2 ; i++)
    {
        self.p[B + i] = self.p[i];
        self.g1[B + i] = self.g1[i];
        for (j = 0 ; j < 2 ; j++)
            self.g2[B + i][j] = self.g2[i][j];
    }
    
}

#pragma mark - GetNoise
-(float) getNoise:(CGPoint)point
{
    float vec[2];
    vec[0] = point.x;
    vec[1] = point.y;
    return [self generate2DNoise:vec];
}

-(float) getNormalizedNoise:(CGPoint)point
{
    float value = [self getNoise:point];
    
    return ((value + 1.0f)/2.0f);
}

#pragma mark - Private Methods
-(float) generate2DNoise:(float [])vec
{
    int terms    = self.mOctaves;
    float result = 0.0f;
    float amp = self.mAmplitude;
    
    vec[0] *= self.mFrequency;
    vec[1] *= self.mFrequency;
    
    for( int i=0; i<terms; i++) {
        result += [self noise2:vec]*amp;
        vec[0] *= 2.0f;
        vec[1] *= 2.0f;
        amp*=0.5f;
    }
    
    return result;
}


-(float) noise2:(float [])vec
{
    int bx0, bx1, by0, by1, b00, b10, b01, b11;
    float rx0, rx1, ry0, ry1, *q, sx, sy, a, b, t, u, v;
    int i, j;
    
    if (self.mStart)
    {
        srand(self.mSeed);
        _mStart = NO;
        [self setupTables];
    }
    
    //    setup(0,bx0,bx1,rx0,rx1);
    t = vec[0] + N;
    bx0 = ((int)t) & BM;
    bx1 = (bx0+1) & BM;
    rx0 = t - (int)t;
    rx1 = rx0 - 1.0f;
    
    
    //    setup(1,by0,by1,ry0,ry1);
    t = vec[1] + N;
    by0 = ((int)t) & BM;
    by1 = (by0+1) & BM;
    ry0 = t - (int)t;
    ry1 = ry0 - 1.0f;
    
    i = self.p[bx0];
    j = self.p[bx1];
    
    b00 = self.p[i + by0];
    b10 = self.p[j + by0];
    b01 = self.p[i + by1];
    b11 = self.p[j + by1];
    
    sx = s_curve(rx0);
    sy = s_curve(ry0);
    
#define at2(rx,ry) ( rx * q[0] + ry * q[1] )
    
    q = self.g2[b00];
    u = at2(rx0,ry0);
    q = self.g2[b10];
    v = at2(rx1,ry0);
    a = lerp(sx, u, v);
    
    q = self.g2[b01];
    u = at2(rx0,ry1);
    q = self.g2[b11];
    v = at2(rx1,ry1);
    b = lerp(sx, u, v);
    
    return lerp(sy, a, b);
}


-(void) normalize2:(float[])vec
{
    float s;
    
    s = (float)sqrt(vec[0] * vec[0] + vec[1] * vec[1]);
    s = 1.0f/s;
    vec[0] = vec[0] * s;
    vec[1] = vec[1] * s;
}

#pragma mark - Dealloc
-(void) dealloc
{
    if (!self.mStart) {
        free(_p);
        
        for (int i = 0; i < (kPerlinSampleSize + kPerlinSampleSize + 2); i++) {
            free(_g2[i]);
        }
        free(_g2);
        
        free(_g1);
    }
}
@end