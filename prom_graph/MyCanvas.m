//
//  MyCanvas.m
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "MyCanvas.h"

@interface MyCanvas ()
@property (nonatomic, assign) MCFigureType selectedType;
@property (nonatomic, assign) NSInteger amount;

- (void)makeCircle:(CGRect)rect;
- (void)makeTriangle:(CGRect)rect;
- (void)makeEllipse: (CGRect) rect;
- (void)makeSquare: (CGRect) rect;
- (void)makeSinusoid: (CGRect) rect;
- (void)makeMeSmile: (CGRect) rect;
- (void)makeRhomb: (CGRect) rect;
- (void)makeTrapeze: (CGRect) rect;
- (void)makeYourChoise:(CGRect) rect;
- (void)makeNAngles: (CGRect) rect;
- (NSArray*)setPointsForNAngles:(CGRect)rect;

@end
@implementation MyCanvas
@synthesize selectedType  = _selectedType;
@synthesize amount = _amount;


- (instancetype)initWithType:(MCFigureType)typeOfFigure
{
    self = [super init];
    if (self)
    {
        self.selectedType = typeOfFigure;
        [self setBackgroundColor: [[UIColor clearColor] colorWithAlphaComponent: 0]];
    }
    return self;
}

- (instancetype)initWithType:(MCFigureType)typeOfFigure : (NSInteger) number
{
    self = [super init];
    if (self)
    {
        self.selectedType = typeOfFigure;
        self.amount = number;
        [self setBackgroundColor: [[UIColor clearColor] colorWithAlphaComponent: 0]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    [self makeYourChoise:rect];
}

- (void)makeNAngles: (CGRect) rect 
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray *arr =[self setPointsForNAngles:rect];
    CGContextBeginPath (context);
    CGContextSetLineWidth(context,5);
    for(NSValue * point in arr)
    {
        CGPoint val = [point CGPointValue];
        if([arr indexOfObject:point]==0)
        {
            CGContextMoveToPoint (context, val.x, val.y);
        }
        else
        {
            CGContextSetRGBStrokeColor(context, 0, 255, 0, 1);
            CGContextAddLineToPoint (context, val.x, val.y);
        }
    
    }
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 20.0 /255, 101.0 / 255.0, 18.0 / 255.0, 1.0);
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

- (NSArray*)setPointsForNAngles:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = 0.90 * center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / _amount;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5 * exteriorAngle);
    for (int currentAngle = 0; currentAngle < _amount; currentAngle++) {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:CGPointMake(center.x + curX,
                                                                center.y + curY)]];
    }
    return result;
}

- (void)makeYourChoise:(CGRect) rect
{
    switch (_selectedType) {
        case 0:
            [self makeTriangle:rect];
            break;
        case 1:
            [self makeCircle:rect];
            break;
        case 2:
            [self makeSquare:rect];
            break;
        case 3:
            [self makeRhomb:rect];
            break;
        case 4:
            [self makeNAngles:rect];
            //_amount = 6;
            break;
        case 5:
            [self makeEllipse:rect];
            break;
        case 6:
            [self makeTrapeze:rect];
            break;
        case 7:
            [self makeSinusoid:rect];
            break;
        case 8:
            [self makeMeSmile:rect];
            break;
        case 9:
            [self makeNAngles:rect];
           // _amount = 12;
            break;
        default:
            break;
    }
}

- (void)makeCircle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 255, 0, 1);
    CGContextSetLineWidth(context, 3.0);
    CGRect circleRect = CGRectMake(3, 3, rect.size.width-6, rect.size.height-6);
    CGContextStrokeEllipseInRect(context, circleRect);
}

- (void)makeTriangle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 221, 221, 1);
    CGPoint points[6] = {CGPointMake(rect.size.width/2, 26), CGPointMake(rect.size.width-6, rect.size.height-6),
        CGPointMake(rect.size.width-6, rect.size.height-6), CGPointMake(6, rect.size.height-6),
        CGPointMake(6, rect.size.height-6), CGPointMake(rect.size.width/2, 26)};
    CGContextStrokeLineSegments(context, points, 6);
}

- (void)makeEllipse: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 255, 156, 0, 1);
    CGContextSetLineWidth(context, 3.0);
    CGRect ellipseRect = CGRectMake(rect.size.width/4, 3, rect.size.width/2-6, rect.size.height-6);
    CGContextStrokeEllipseInRect(context, ellipseRect);
    
}

- (void)makeSquare: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 128, 0, 50, 1);
    CGContextSetLineWidth(context, 3.0);
    CGRect squareRect = CGRectMake(3, 3, rect.size.width-6, rect.size.height-6);
    CGContextStrokeRect(context, squareRect);
    
}

- (void)makeSinusoid: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 128, 0, 50, 1);
    CGContextSetLineWidth(context, 3.0);
    

    int y;
    for(int x=rect.origin.x; x < rect.size.width; x++)
    {
        y = ((rect.size.height/2) * sin(((x*4) % 360) * M_PI/180)) + rect.size.height/2;
        if (x == 0) CGContextMoveToPoint(context, x, y);
        else CGContextAddLineToPoint(context, x, y);
    }
    CGContextStrokePath(context);
}

- (void)makeMeSmile: (CGRect) rect
{
    CGFloat width = rect.size.width-rect.size.width/100*3;
    CGFloat height = rect.size.height-rect.size.height/100*3;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 255, 255, 1);
    CGContextSetLineWidth(context, 3.0);
    CGRect circleRect = CGRectMake(3, 3, width, height);
    CGContextStrokeEllipseInRect(context, circleRect);
    
    CGRect eye1Rect = CGRectMake(width/3, height/3, width/10, height/10);
    CGContextStrokeEllipseInRect(context, eye1Rect);
    CGRect ellipse1Rect = CGRectMake(width/3+width/100*4, height/3, width/40, height/10);
    CGContextSetRGBFillColor(context, 0, 255, 255, 1);
    CGContextFillEllipseInRect(context, ellipse1Rect);
    
    CGRect eye2Rect = CGRectMake((width/3)*2, height/3, width/10, height/10);
    CGContextStrokeEllipseInRect(context, eye2Rect);
    CGRect ellipse2Rect = CGRectMake((width/3)*2+width/100*4, height/3, width/40, height/10);
    CGContextSetRGBFillColor(context, 0, 255, 255, 1);
    CGContextFillEllipseInRect(context, ellipse2Rect);
    
    CGPoint bezierStart = {rect.size.width/3, rect.size.height-rect.size.height/3};
    CGPoint bezierEnd = {rect.size.width-rect.size.width/3, rect.size.height-rect.size.height/3};
    CGPoint bezierHelper1 = {rect.size.width/2, rect.size.height-rect.size.height/4};
    CGPoint bezierHelper2 = {rect.size.width/2, rect.size.height-rect.size.height/5};
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, bezierStart.x, bezierStart.y);
    CGContextAddCurveToPoint(context,
                             bezierHelper1.x, bezierHelper1.y,
                             bezierHelper2.x, bezierHelper2.y,
                             bezierEnd.x, bezierEnd.y);
    CGContextStrokePath(context);
}

- (void)makeRhomb: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 255, 255, 1);
    CGContextSetLineWidth(context, 3.0);
    
    CGContextMoveToPoint(context, rect.size.width/2, 2);
    CGContextAddLineToPoint(context, rect.size.width-50, rect.size.height/2);
    CGContextAddLineToPoint(context, rect.size.width/2, rect.size.height);
    CGContextAddLineToPoint(context, 50, rect.size.height/2);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)makeTrapeze: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 255, 255, 1);
    CGContextSetLineWidth(context, 3.0);
    int width = rect.size.width, hight = rect.size.height;
    CGContextBeginPath(context);
    CGPoint points[4] = {CGPointMake(0+width/3, 0), CGPointMake(width-width/3, 0), CGPointMake(width, hight), CGPointMake(0, hight)};
    
   // CGContextMoveToPoint(context, points[0].x, points[0].y);
   // CGContextAddLineToPoint(context, points[1].x, points[1].y);
    //CGContextAddLineToPoint(context, points[2].x, points[2].y);
   // CGContextAddLineToPoint(context, points[3].x, points[3].y);
    CGContextAddLines(context, points, 4);
    CGContextClosePath(context);
    CGContextStrokePath(context);
   // CGContextStrokeLineSegments(context, points, 4);
//    CGContextMoveToPoint(context, 60, rect.size.height/10);
//    CGContextAddLineToPoint(context, rect.size.width-60, rect.size.height/10);
//    CGContextAddLineToPoint(context, rect.size.width-3, rect.size.height-5);
//    CGContextAddLineToPoint(context, 3, rect.size.height-5);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
}






@end
