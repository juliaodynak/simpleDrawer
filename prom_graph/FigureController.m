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
@property (nonatomic, strong) NSTimer *timeToNew;
@property (nonatomic, strong) NSString *scoreString;
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, strong) NSString* currentUser;
@property (nonatomic, assign) BOOL pauseTap;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval timerWait;

@end

@implementation FigureController




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    [self createFigures];
    self.distance = 1000000.0;
    self.startTime = CACurrentMediaTime();
    self.scoreString = @"";
    self.pauseTap = NO;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panRecognizer];
    [self startGame];
}

-(void) startGame
{
    if (self.pauseTap == NO)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        self.timeToNew = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(placeFigure) userInfo:nil repeats:YES];
    }
    
}

- (IBAction)wer:(id)sender
{
    if (self.pauseTap == NO)
    {
        self.pauseTap = YES;
        [self.timer invalidate];
        [self.timeToNew invalidate];
        self.timerWait = CACurrentMediaTime();
    }
    else
    {
        self.pauseTap = NO;
        [self startGame];
        self.timerWait = CACurrentMediaTime() - self.timerWait;
        self.startTime = self.startTime + self.timerWait;
    }
}


- (void)timerFire
{
    CGFloat viewHeight = self.view.frame.size.height;
    CGFloat viewWidth = self.view.frame.size.width;
    __weak typeof(MyCanvas) *weakView = self.contView;
    if (self.pauseTap == NO)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            for (MyCanvas* figure in self.figures)
            {
                if (weakView == nil || (weakView && ![figure isEqual:weakView]))
                {
                    CGPoint vector = figure.vector;
                    
                    if (figure.center.x + figure.frame.size.width / 2 >= viewWidth)
                    {
                        vector = [self generateVec];
                        if (vector.x > 0)
                        {
                            vector.x = -vector.x;
                        }
                    }
                    else if (figure.center.x <= figure.frame.size.width / 2)
                    {
                        vector = [self generateVec];
                        if(vector.x < 0)
                        {
                            vector.x *= -1;
                        }
                    }
                    
                    if (figure.center.y + figure.frame.size.height / 2 >= viewHeight)
                    {
                        vector = [self generateVec];
                        if(vector.y > 0)
                        {
                            vector.y *= -1;
                        }
                    }
                    else if (figure.center.y <= figure.frame.size.height / 2 + 50)
                    {
                        vector = [self generateVec];
                        if(vector.y < 0)
                        {
                            vector.y *= -1;
                        }
                    }
                    
                    figure.center = CGPointMake(figure.center.x + vector.x, figure.center.y + vector.y);
                    figure.vector = vector;
                }
            }
            
        }];
    }
    
    
    [self setScoreLabelTime];
}
- (CGPoint)generateVec
{
    CGFloat distance = 35.0f;
    CGFloat diffX = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
    CGFloat diffY = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
    
    return CGPointMake(diffX, diffY);
    
}

- (void)handlePan:(UIPanGestureRecognizer*)paramsender
{
    if (self.pauseTap == NO)
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
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.pauseTap == NO)
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
    ob.vector = [self generateVec];
    CGSize size = self.view.frame.size;
    CGFloat figureSize = 50 + ((float)rand() / (float)RAND_MAX);
    
    CGRect figureFrame = CGRectZero;
    int j = 0;
    for (; j < 20; ++j)
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
    
    if (j >= 20)
    {
        // Game Over
        [self performSegueWithIdentifier:@"goToExit" sender:self];
        [self putTimeNil];
    }
    else
    {
        ob.frame = figureFrame;
        ob.userInteractionEnabled = NO;
        [self.figures addObject:ob];
        [self.view addSubview:ob];
    }
}

- (void) putTimeNil
{
    [self.timer invalidate];
    self.timer = nil;
    [self.timeToNew invalidate];
    self.timeToNew = nil;
}
- (void)keepScore
{
    self.startTime = CACurrentMediaTime() - self.startTime;
    NSString* hrt= [NSString stringWithFormat:@"%.2f", self.startTime];
    self.scoreString = hrt;
}

- (void) putName: (NSString*) name
{
    self.currentUser = name;
}

- (void)setScoreLabelTime
{
    NSTimeInterval score = CACurrentMediaTime() - self.startTime;
    
    NSString* scoreText= [NSString stringWithFormat:@"%.2f", score];
    self.scoreLabel.text = scoreText;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToExit"])
    {
        [self keepScore];
        ScoreControler *vievController = (ScoreControler*)segue.destinationViewController;
        [vievController putScoreToDisplay:self.scoreString: self.currentUser];
    }
    [self putTimeNil];
}

@end
