//
//  MyCanvas.h
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FigureType)
{
    Triangle = 1,
    Circle = 2,
    Square = 3,
    Rhomb = 4,
    Hexagon = 5,
    Ellipse = 6,
    Trapeze = 7,
    Sinusoid = 8,
    Smile  = 9
    
};

@interface MyCanvas : UIView

@property (nonatomic, assign) FigureType* selectedType;

-(void) initWithType :(FigureType) figure;
-(void) makeCircle:(CGRect)rect;
-(void) makeTriangle:(CGRect)rect;
-(void) makeEllipse: (CGRect) rect;
-(void) makeSquare: (CGRect) rect;
-(void) makeSinusoid: (CGRect) rect;
-(void) makeMeSmile: (CGRect) rect;
-(void) makeRhomb: (CGRect) rect;
-(void) makeTrapeze: (CGRect) rect;
-(void) makeYourChoise:(CGRect) rect:(FigureType) figure;

@end
