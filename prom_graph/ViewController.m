//
//  ViewController.m
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "ViewController.h"
#import "MyCanvas.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *display;

@end

@implementation ViewController

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    for (int item = 0; item < 20; ++item)
//    {
//        [self placeFigure];
//    }
//}
//
//- (void)placeFigure
//{
//    NSInteger type = ((float)rand() / (float)RAND_MAX) * MCFigureTypeCount;
//    NSInteger colorStroke = ((float)rand() / (float)RAND_MAX) * MCColorChoiseCount;
//    NSInteger colorFill = ((float)rand() / (float)RAND_MAX) * MCColorChoiseCount;
//    MyCanvas *ob;
//    if (type!=4 && type!=9)
//    {
//        ob = [[MyCanvas alloc] initWithType: type:colorStroke: colorFill];
//    }
//    if (type == 4)
//    {
//        ob = [[MyCanvas alloc] initWithType: MCFigureTypeNAngles: colorStroke: colorFill: 6];
//    }
//    if (type == 9)
//    {
//        ob = [[MyCanvas alloc] initWithType:MCFigureTypeNAngles:colorStroke: colorFill: 12];
//    }
//    //ob.frame = CGRectMake(0, 100, 375, 375);
//    CGSize size = self.view.frame.size;
//    CGFloat figureSize = 100 + ((float)rand() / (float)RAND_MAX);
//    
//    CGRect figureFrame = CGRectMake(((float)rand() / (float)RAND_MAX) * (size.width - figureSize),
//                              ((float)rand() / (float)RAND_MAX) * (size.height - figureSize),
//                              figureSize, figureSize);
//    
//    ob.frame = figureFrame;
////    ob = [[MyCanvas alloc] initWithType:MCFigureTypeCircle];
////    ob.frame = CGRectMake(0, 100, 375, 375);
//    [self.view addSubview:ob];
//}

@end
