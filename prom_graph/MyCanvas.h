//
//  MyCanvas.h
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
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
    MCColorChoiseBrown,
    MCColorChoisePurple,
    MCColorChoiseGray,
    MCColorChoiseOrange,
    MCColorChoiseCyan,
    MCColorChoiseClear,
    MCColorChoiseCount
    
};

@interface MyCanvas : UIView
@property (nonatomic, assign) MCFigureType selectedType;
@property (nonatomic, assign) CGPoint vector;


- (instancetype)initWithType:(MCFigureType)typeOfFigure :(MCColorChoise)colorOfStroke :(MCColorChoise)colorOfFill;
- (instancetype)initWithType :(MCFigureType)typeOfFigure :(NSInteger) number :(MCColorChoise)colorOfStroke :(MCColorChoise)colorOfFill;



@end
