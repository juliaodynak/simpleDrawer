//
//  FigureController.m
//  prom_graph
//
//  Created by adminaccount on 9/11/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "FigureController.h"
#import "MyCanvas.h"
#import "ScoreControler.h"


static NSInteger const kNumberOfFigures = 10;

@interface FigureController ()

@property (nonatomic, strong)  NSMutableArray *figures;
@property (nonatomic, assign) CGFloat originSize;
@property (nonatomic, assign) CGFloat firstX;
@property (nonatomic, assign) CGFloat firstY;
@property (nonatomic, strong) MyCanvas *contView;
@property (nonatomic, strong) MyCanvas *chosenView;
@property (nonatomic, assign) float distance;
@property (nonatomic, strong) MyCanvas *viewToCompare;
@property (nonatomic, assign) CGFloat vector;
//@property (nonatomic, strong) NSTimer *time;
@property(nonatomic,strong) NSString *contstr;
@property(nonatomic,assign) double score;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FigureController




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createFigures];
    self.distance = 1000000.0;
    self.vector = -1;
    self.score = 0;
    self.contstr = @"";
//    self.time = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerVector:) userInfo:nil repeats:YES];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panRecognizer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
}

- (void)timerFire
{
    CGFloat distance = 35.0f;
    CGFloat viewHeight = self.view.frame.size.height - 30;
    CGFloat viewWidth = self.view.frame.size.width - 30;
   // CACurrentMediaTime();
    
    __weak typeof(MyCanvas) *weakView = self.contView;
    [UIView animateWithDuration:0.1 animations:^{
        self.score = CACurrentMediaTime();
        for (MyCanvas* figure in self.figures)
        {
           // [self timerVector:figure];
            if (weakView == nil || (weakView && ![figure isEqual:weakView]))
            {
                CGFloat diffX = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
                CGFloat diffY = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
                
                
                if(figure.center.x >= viewWidth)
                {
                    if(diffX > 0)
                    {
                        diffX *= self.vector;
                    }
                }
                if(figure.center.x <= 50)
                {
                    if(diffX < 0)
                    {
                        diffX *= self.vector;
                    }
                }
                if(figure.center.y >= viewHeight)
                {
                    if(diffY > 0)
                    {
                        diffY *= self.vector;
                    }
                }
                if(figure.center.y <= 50)
                {
                    if(diffY < 0)
                    {
                        diffY *= self.vector;
                    }
                }
                figure.center = CGPointMake(figure.center.x + diffX, figure.center.y + diffY);

            }
        }
        
    }];
    self.score = CACurrentMediaTime() - self.score ;
}

//- (void)timerVector:(MyCanvas*)fig
//{
//    fig.center = CGPointMake(fig.center.x * self.vector, fig.center.y );
//}

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
        
        self.contView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        self.contView.layer.shadowOpacity = 0.5f;
        
        for(int i=0; i<self.figures.count;i++)
        {
            if (![self.figures[i] isEqual:self.contView]) {
                self.viewToCompare = self.figures[i];
                self.viewToCompare.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
                self.viewToCompare.layer.shadowOpacity = 0.0f;
            }
            
            if(CGRectIntersectsRect(self.contView.frame, [self.figures[i] frame]) && self.contView != self.figures[i])
            {
                self.viewToCompare.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
                self.viewToCompare.layer.shadowOpacity = 0.5f;
            }
        }
    }
    
    if( paramsender.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.1 animations:^{
            self.contView.transform = CGAffineTransformIdentity;
        } /*completion:^(BOOL finished) {
            self.contView = nil;
        }*/];
        
        self.contView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.contView.layer.shadowOpacity = 0.0f;
        
        for(int i=0; i<self.figures.count;i++)
        {
            if(CGRectIntersectsRect(self.contView.frame, [self.figures[i] frame]) && self.contView != self.figures[i])
            {
                self.viewToCompare = self.figures[i];
                self.viewToCompare.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
                self.viewToCompare.layer.shadowOpacity = 0.0f;
                self.contView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
                self.contView.layer.shadowOpacity = 0.0f;
                
                CGPoint center = self.contView.center;
                CGPoint currentFigureCenter = self.viewToCompare.center;

                CGFloat xDist = (center.x - currentFigureCenter.x);
                CGFloat yDist = (center.y - currentFigureCenter.y);
                CGFloat currentDistance = sqrt((xDist * xDist) + (yDist * yDist));
                if(self.distance > currentDistance)
                {
                    self.distance = currentDistance;
                    self.chosenView = self.figures[i];
                }
            }
        }

        if ([self.contView selectedType] == [self.chosenView selectedType]&& self.chosenView!=nil && self.contView!=nil)
        {
            [self.contView removeFromSuperview];
            [self.chosenView removeFromSuperview];

            for(int j = 0;j < self.figures.count; j++)
            {
                if ([self.figures[j] isEqual: self.contView] || [self.figures[j] isEqual: self.chosenView])
                {
                    [self.figures removeObjectAtIndex:j];
                }
            }
            [self makeNill];
    
        }
        
        else if ([self.contView selectedType] != [self.chosenView selectedType] && self.chosenView!=nil && self.contView!=nil)
        {
            [self placeFigure];
            self.contView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            self.contView.layer.shadowOpacity = 0.0f;
            
            self.chosenView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            self.chosenView.layer.shadowOpacity = 0.0f;
            
            [self makeNill];
        }
        [self makeNill];
    }
    
    if( paramsender.state == UIGestureRecognizerStateCancelled)
    {
        self.contView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        self.contView.layer.shadowOpacity = 0.5f;
        [self makeNill];
    }
    
    if(paramsender.state == UIGestureRecognizerStateFailed)
    {
        [self makeNill];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint location = [touches.anyObject locationInView:self.view];
    for(int i = 0; i < self.figures.count; i++)
    {
        if(CGRectContainsPoint([self.figures[i] frame], location))
        {
            self.contView = self.figures[i];
            [UIView animateWithDuration:0.1 animations:^{
                self.contView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
            }];
        }
    }
    
    [self.view bringSubviewToFront:self.contView];
    self.contView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.contView.layer.shadowOpacity = 0.5f;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    self.contView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.contView.layer.shadowOpacity = 0.0f;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.contView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.contView = nil;
        
    }];
}

- (void) makeNill
{
    self.contView = nil;
    self.chosenView = nil;
    self.viewToCompare = nil;
    self.distance = 1000000.0;
}

- (void)createFigures
{
    self.figures = [[NSMutableArray alloc] init];
    //_counter = 0;
    for (int i = 0; i < kNumberOfFigures; ++i)
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
            ob = [[MyCanvas alloc] initWithType: MCFigureTypeNAngles: 6: colorStroke: colorFill];
        }
        if (type == 9)
        {
            ob = [[MyCanvas alloc] initWithType:MCFigureTypeNAngles: 12: colorStroke: colorFill];
        }
        CGSize size = self.view.frame.size;
        CGFloat figureSize = 50 + ((float)rand() / (float)RAND_MAX);
        
        CGRect figureFrame = CGRectZero;
        for (int j = 0; j < 100; ++j)
        {
            figureFrame = CGRectMake(((float)rand() / (float)RAND_MAX) * (size.width - figureSize),
                                     ((float)rand() / (float)RAND_MAX) * (size.height - figureSize),
                                     figureSize, figureSize);
            
            
            BOOL intersects = NO;
            for (MyCanvas* figure in self.figures)
            {
                if (CGRectIntersectsRect(figureFrame, [figure frame]))
                {
                    intersects = YES;
                    break;
                }
            }
            
            if (!intersects)
            {
                break;
            }
        }
        ob.frame = figureFrame;
    ob.userInteractionEnabled = NO;
        [self.figures addObject:ob];
        [self.view addSubview:ob];
}

- (void) keepScore
{
    NSString* hrt= [NSString stringWithFormat:@"%f", self.score];
    self.contstr = hrt;
   // [self performSegueWithIdentifier:@"goToExit" sender:nil];
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self keepScore];
    UILabel* contlab;
    contlab.text = self.contstr;
    if([segue.identifier isEqualToString:@"goToExit"])
    {
        ScoreControler *vievController = (ScoreControler*)segue.destinationViewController;
        [vievController putScoreToDisplay: _contstr];
    }
}

//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    needValue = idexPath.row; //Инициализируем номер ячейки
//    [tableView deselectRowAtIndexPath:indexPath animated:true]; //Убираем select с ячейки, что бы при возвращении она не была выбрана
//    [self performSegueWithIdentifier:@"schoolsToLogin" sender:nil]; //Инициализируем переход
//}
//
//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"yourSegue"]) //Проверяем тот ли это segue, который нам нужен
//    {
//        nextViewController *nextController = (nextViewController *)segue.destinationViewController; //Создаем ссылку на viewController который будет вызван в результате segue
//        
//        [nextController setNeedValue: _needValue]; //инициализируем значение нужного viewController
//    }
//}

@end


