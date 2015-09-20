//
//  ScoreControler.m
//  prom_graph
//
//  Created by adminaccount on 9/17/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "ScoreControler.h"
#import "TableViewController.h"
#import "ViewController.h"

@interface ScoreControler ()

@end

@implementation ScoreControler
@synthesize display;
@synthesize strWithScore;

- (void)viewDidLoad {
    [super viewDidLoad];
    display.text = self.strWithScore;
    self.strWithScore =@"";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) putScoreToDisplay:(NSString *)scor
{
    display.text = scor;
    self.strWithScore = scor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onStartTap:(id)sender
{
    [self performSegueWithIdentifier:@"goToStartSegue" sender:self];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString* contForName = self.nameOfUser;
    if (contForName == nil)
    {
        contForName = @"because it don't work";
    }
    if ([segue.identifier isEqualToString:@"goToLaeders"])
    {
        TableViewController *tabController = (TableViewController*)segue.destinationViewController;
        [tabController putData: self.strWithScore toDictionary: contForName];
    }
}

@end
