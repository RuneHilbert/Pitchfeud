//
//  LineView.m
//  PitchFeud
//
//  Created by Aleksandras Smirnovas on 12/9/12.
//  Copyright (c) 2012 coder.lt. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
- (void)setNeedsDisplayInRect:(CGRect)invalidRect
{
    [super setNeedsDisplayInRect:invalidRect];

    NSLog(@"setNeedsDisplayInRect");
    
    CGContextRef context    = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);

    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);

    CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y); //start at this point

    CGContextAddLineToPoint(context, self.finishPoint.x, self.finishPoint.y); //draw to this point

    // and now draw the Path!
    CGContextStrokePath(context);
}
*/

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    NSLog(@"drawRect x %f, y %f to x %f, y %f", self.startPoint.x, self.startPoint.y, self.finishPoint.x, self.finishPoint.y);
    //74.904762, 185.271423;   28.809525, 115.092857
    CGContextRef context    = UIGraphicsGetCurrentContext();
    
    
    /*
     CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
     CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
     CGColorRef color = CGColorCreate(colorspace, components);
     */
    
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    //CGFloat dashArray[] = {2,6,4,2};
    //CGContextSetLineDash(context, 3, dashArray, 4);
    
    CGFloat dashes[] = { 6, 3 };//painted, unpainted length
    //3 - A floating point value that specifies how far into the dash pattern the line starts
    //2 - A count of the number of items in the lengths array
    CGContextSetLineDash( context, 3, dashes, 2 );
    
    CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, self.finishPoint.x, self.finishPoint.y); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);

    //CGColorSpaceRelease(colorspace);
    //CGColorRelease(color);
}


@end
