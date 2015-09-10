//
//  MyCanvas.h
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MCFigureType)
{
    MCFigureTypeTriangle,
    MCFigureTypeCircle,
    MCFigureTypeSquare,
    MCFigureTypeRhomb,
    MCFigureTypeHexagon,
    MCFigureTypeEllipse,
    MCFigureTypeTrapeze,
    MCFigureTypeSinusoid,
    MCFigureTypeSmile,
    MCFigureTypeNAngles,
    MCFigureTypeCount
};

typedef NS_ENUM(NSInteger, MCColorChoise)
{
    MCColorChoiseBlue,
    MCColorChoiseYellow,
    MCColorChoiseGreen,
    MCColorChoiseRed,
    MCColorChoiseBlack,
    MCColorChoiseBlown,
    MCColorChoisePurple,
    MCColorChoiseGray,
    MCColorChoiseOrange,
    MCColorChoiseCyan,
    MCColorChoiseClear,
    MCColorChoiseCount
    
};

@interface MyCanvas : UIView



- (instancetype)initWithType:(MCFigureType)typeOfFigure;
- (instancetype)initWithType:(MCFigureType)typeOfFigure : (NSInteger) number;



@end
