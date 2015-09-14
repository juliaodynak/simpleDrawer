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
@property (nonatomic, assign) CGFloat originSize;
@property (nonatomic, assign) CGFloat firstX;
@property (nonatomic, assign) CGFloat firstY;
@property (nonatomic, strong) UIView *contView;

@end

@implementation FigureController




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createFigures];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panRecognizer];
    
    
}

- (void)handlePan:(UIPanGestureRecognizer*)paramsender
{
    if (paramsender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [paramsender locationInView:paramsender.view];
        for(int i=0; i<self.figures.count;i++)
        {
            if(CGRectContainsPoint([self.figures[i] frame], location))
            {
                self.contView = self.figures[i];
                self.originSize  = self.contView.frame.size.width;
                
//                [UIView animateWithDuration:0.1 animations:^{
//                    self.contView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
//                }];
                
                break;
            }
        }
    }
    
    if (paramsender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint center = self.contView.center;
        CGPoint translation = [paramsender translationInView:self.view];
        
        center.x += translation.x;
        center.y += translation.y;
        
        self.contView.center = center;
        
        [paramsender setTranslation:CGPointZero inView:self.view];
    }
    
    if( paramsender.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.1 animations:^{
            self.contView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.contView = nil;
            
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint location = [touches.anyObject locationInView:self.view];
    for(int i=0; i<self.figures.count;i++)
    {
        if(CGRectContainsPoint([self.figures[i] frame], location))
        {
            self.contView = self.figures[i];
            [UIView animateWithDuration:0.1 animations:^{
                self.contView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
            }];
        }
    }

    
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


