//
//  FigureController.m
//  prom_graph
//
//  Created by adminaccount on 9/11/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "FigureController.h"
#import "MyCanvas.h"

static NSInteger const kNumberOfFigures = 10;

@interface FigureController ()

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (nonatomic, strong)  NSMutableArray *figures;
@property (nonatomic, assign) NSInteger counter;

@end

@implementation FigureController




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createFigures];
    _figures = [[NSMutableArray alloc] init];
}

- (void)createFigures
{
    _figures = [[NSMutableArray alloc] init];
    _counter = 0;
    while (_counter != kNumberOfFigures)
    {
        [self placeFigure];
        
    }
    
}

- (void)placeFigure
{
    NSInteger type = ((float)rand() / (float)RAND_MAX) * MCFigureTypeCount;
    NSInteger colorStroke = ((float)rand() / (float)RAND_MAX) * MCColorChoiseCount;
    NSInteger colorFill = ((float)rand() / (float)RAND_MAX) * MCColorChoiseCount;
    MyCanvas *ob;
   
    
        if (type!=4 && type!=9)
        {
            ob = [[MyCanvas alloc] initWithType: type:colorStroke: colorFill];
        }
        if (type == 4)
        {
            ob = [[MyCanvas alloc] initWithType: MCFigureTypeNAngles: colorStroke: colorFill: 6];
        }
        if (type == 9)
        {
            ob = [[MyCanvas alloc] initWithType:MCFigureTypeNAngles:colorStroke: colorFill: 12];
        }
        CGSize size = self.view.frame.size;
        CGFloat figureSize = 50 + ((float)rand() / (float)RAND_MAX);
        
        CGRect figureFrame = CGRectMake(((float)rand() / (float)RAND_MAX) * (size.width - figureSize),
                                        ((float)rand() / (float)RAND_MAX) * (size.height - figureSize),
                                        figureSize, figureSize);
        
        ob.frame = figureFrame;
        if(_figures.count==0)
        {
            [self.figures insertObject:ob atIndex:0];
        }
        for(int i=0; i<_figures.count;i++)
        {
            if(CGRectIntersectsRect(figureFrame, [_figures[i] frame]))
            {
                break;
            }
            else if(i==_figures.count-1)
            {
                [_figures addObject:ob];
                [self.view addSubview:ob];
                _counter++;
            }
        }
}

@end


