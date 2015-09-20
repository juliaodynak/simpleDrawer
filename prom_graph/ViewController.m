//
//  ViewController.m
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "ViewController.h"
#import "MyCanvas.h"
#import "TableViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userName;
@end


@implementation ViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"goToLeader"])
//    {
//        TableViewController *tabController = (TableViewController*)segue.destinationViewController;
//        [tabController putNameToDictionary:self.userName];
//    }
//}

//- (void)keepScore
//{
//    self.startTime = CACurrentMediaTime() - self.startTime;
//    NSString* hrt= [NSString stringWithFormat:@"%.2f", self.startTime];
//    self.scoreString = hrt;
//}
//
//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"goToExit"])
//    {
//        [self keepScore];
//        ScoreControler *vievController = (ScoreControler*)segue.destinationViewController;
//        [vievController putScoreToDisplay:self.scoreString];
//    }
//}

@end
