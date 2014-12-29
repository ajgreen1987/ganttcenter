//
//  AJGLineView.m
//  GanttCenter
//
//  Created by AJ Green on 12/29/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "AJGLineView.h"

@implementation AJGLineView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
    CGContextSetLineWidth(context, 3.0);
    CGContextMoveToPoint(context, 10.0, 10.0);
    CGContextAddLineToPoint(context, 100.0, 100.0);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
