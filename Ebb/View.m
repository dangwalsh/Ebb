//
//  View.m
//  Ebb
//
//  Created by Daniel Walsh on 5/28/12.
//  Copyright (c) 2012 Walsh walsh Studio. All rights reserved.
//

#import "View.h"
#import "ViewController.h"
#import "Model.h"

@implementation View

/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
*/

- (id)initWithFrame:(CGRect) frame
         controller: (ViewController *) c
              model: (Model *) m 
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        model = m;
    }
    return self;    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGSize s = self.bounds.size;
    int m = 20;
    
    arrays = [model outputDetailValuesToPlot];
    NSArray *sepBalA = [arrays objectAtIndex:10];
    
    float maxVal = 0;
    for (NSNumber *val in sepBalA) {
        if ([val floatValue] > maxVal) {
            maxVal = [val floatValue];
        }
    }

    int yHeight = (s.height - (2 * m));
    int xWidth = (s.width - (2 * m));
    int years = (model.lifeExpectancy - model.currentAge);
    int xSpacing = (s.width - (2 * m)) / years;
    int year = 0;

    
    CGContextTranslateCTM(
                          c, 
                          s.width - (s.width - m), 
                          s.height - m
                          );
    CGContextScaleCTM(c, 1, -1);
    
    //y axis
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, 0, 0);
    
    CGContextAddLineToPoint(c, 0,yHeight);
    
    CGContextStrokePath(c);
    
    //x axis
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, 0, 0);
    
    CGContextAddLineToPoint(c, xWidth, 0);
    
    CGContextStrokePath(c);
    
    //plot
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, 0, 0);
    
    for (int i = 0; i < years; ++i) {
        int value = [[sepBalA objectAtIndex:i] intValue];    
        CGContextAddLineToPoint(c, year, value/maxVal * yHeight);
        year = year + xSpacing;
    }
    CGContextSetStrokeColorWithColor(c, [UIColor redColor].CGColor);
    CGContextSetLineWidth(c, 3);
    CGContextStrokePath(c);
}


@end
