//
//  MyCanvas.m
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "MyCanvas.h"

@implementation MyCanvas
@synthesize selectedType  =_selectedType;

//+ (MyCanvas*)SharedInstance
//{
//    static MyCanvas *ob;
//    static dispatch_once_t predicat;
//    
//    dispatch_once(&predicat, ^{
//        ob = [[MyCanvas alloc]init];
//    });
//    
//    return ob;
//}
-(void) initWithType: (FigureType) typeOfFigure
{
    self.selectedType = &(typeOfFigure);
}



- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 255, 255, 255, 1);
    CGContextFillRect(context, CGRectMake(0, 20, 375, 375));
    rect.size.height = 375;
    rect.size.width = 375;
    
    [self makeYourChoise:rect:Smile];
}

-(void) makeYourChoise:(CGRect) rect :(FigureType) figure
{
    switch (figure) {
        case 1:
            [self makeTriangle:rect];
            break;
        case 2:
            [self makeCircle:rect];
            break;
        case 3:
            [self makeSquare:rect];
            break;
        case 4:
            [self makeRhomb:rect];
            break;
//        case 5:
//            [self makeTriangle:rect];
//            break;
        case 6:
            [self makeEllipse:rect];
            break;
        case 7:
            [self makeTrapeze:rect];
            break;
        case 8:
            [self makeSinusoid:rect];
            break;
        case 9:
            [self makeMeSmile:rect];
            break;
        default:
            break;
    }
}

-(void) makeCircle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 255, 0, 1);
    CGContextSetLineWidth(context, 3.0);
    CGRect circleRect = CGRectMake(3, 23, rect.size.width-6, rect.size.height-6);
    CGContextStrokeEllipseInRect(context, circleRect);
}

-(void) makeTriangle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 221, 221, 1);
    CGPoint points[6] = {CGPointMake(rect.size.width/2, 26), CGPointMake(rect.size.width-6, rect.size.height-6),
        CGPointMake(rect.size.width-6, rect.size.height-6), CGPointMake(6, rect.size.height-6),
        CGPointMake(6, rect.size.height-6), CGPointMake(rect.size.width/2, 26)};
    CGContextStrokeLineSegments(context, points, 6);
}

-(void) makeEllipse: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 255, 156, 0, 1);
    CGContextSetLineWidth(context, 3.0);
    CGRect ellipseRect = CGRectMake(rect.size.width/4, 23, rect.size.width/2-6, rect.size.height-6);
    CGContextStrokeEllipseInRect(context, ellipseRect);
    
}

-(void) makeSquare: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 128, 0, 50, 1);
    CGContextSetLineWidth(context, 3.0);
    CGRect squareRect = CGRectMake(3, 23, rect.size.width-6, rect.size.height-6);
    CGContextStrokeRect(context, squareRect);
    
}

-(void) makeSinusoid: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 128, 0, 50, 1);
    CGContextSetLineWidth(context, 3.0);
    

    int y;
    for(int x=rect.origin.x; x < rect.size.width; x++)
    {
        y = ((rect.size.height/2) * sin(((x*4) % 360) * M_PI/180)) +208;
        if (x == 0) CGContextMoveToPoint(context, x, y);
        else CGContextAddLineToPoint(context, x, y);
    }
    CGContextStrokePath(context);
}

-(void) makeMeSmile: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 255, 255, 1);
    CGContextSetLineWidth(context, 3.0);
    CGRect circleRect = CGRectMake(3, 23, rect.size.width-6, rect.size.height-6);
    CGContextStrokeEllipseInRect(context, circleRect);
    
    CGRect eye1Rect = CGRectMake(rect.size.width/3-40, rect.size.height/3, 40, 40);
    CGContextStrokeEllipseInRect(context, eye1Rect);
    CGRect ellipse1Rect = CGRectMake(rect.size.width/3-28, rect.size.height/3, 12, 40);
    CGContextSetRGBFillColor(context, 0, 255, 255, 1);
    CGContextFillEllipseInRect(context, ellipse1Rect);
    
    CGRect eye2Rect = CGRectMake((rect.size.width/3)*2, rect.size.height/3, 40, 40);
    CGContextStrokeEllipseInRect(context, eye2Rect);
    CGRect ellipse2Rect = CGRectMake((rect.size.width/3)*2+15, rect.size.height/3, 12, 40);
    CGContextSetRGBFillColor(context, 0, 255, 255, 1);
    CGContextFillEllipseInRect(context, ellipse2Rect);
    
    CGPoint bezierStart = {80, 260};
    CGPoint bezierEnd = {300, 260};
    CGPoint bezierHelper1 = {145, 320};
    CGPoint bezierHelper2 = {240, 320};
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, bezierStart.x, bezierStart.y);
    CGContextAddCurveToPoint(context,
                             bezierHelper1.x, bezierHelper1.y,
                             bezierHelper2.x, bezierHelper2.y,
                             bezierEnd.x, bezierEnd.y);
    CGContextStrokePath(context);
}

-(void) makeRhomb: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 255, 255, 1);
    CGContextSetLineWidth(context, 3.0);
    
    CGContextMoveToPoint(context, rect.size.width/2, 22);
    CGContextAddLineToPoint(context, rect.size.width-50, rect.size.height/2+15);
    CGContextAddLineToPoint(context, rect.size.width/2, rect.size.height+18);
    CGContextAddLineToPoint(context, 50, rect.size.height/2+15);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

-(void) makeTrapeze: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 255, 255, 1);
    CGContextSetLineWidth(context, 3.0);
    
    CGContextMoveToPoint(context, 60, rect.size.height/10);
    CGContextAddLineToPoint(context, rect.size.width-60, rect.size.height/10);
    CGContextAddLineToPoint(context, rect.size.width-3, rect.size.height-5);
    CGContextAddLineToPoint(context, 3, rect.size.height-5);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}






@end
