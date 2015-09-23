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

@property (nonatomic, strong) NSMutableDictionary* currentDict;
@property (nonatomic, assign) BOOL saveResultProp;
@end

@implementation ScoreControler
@synthesize display;
@synthesize strWithScore;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    display.text = self.strWithScore;
    self.saveResultProp = false;
    //self.strWithScore =@"";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) putScoreToDisplay:(NSString *)scor :(NSString*) name
{
    display.text = scor;
    self.strWithScore = scor;
    self.currentUser = name;
}



- (IBAction)onStartTap:(id)sender
{
    [self performSegueWithIdentifier:@"goToStartSegue" sender:self];
}

- (IBAction)saveResult:(id)sender
{
    if (self.saveResultProp)
    {
        NSDictionary *result = [[NSUserDefaults standardUserDefaults] objectForKey:@"leader"];
        if (result == nil)
        {
            result = [[NSDictionary alloc] init];
        }
        
        NSMutableDictionary *mDict = [result mutableCopy];
        //[mDict removeObjectForKey:@"0.93"];
        
        if (!self.currentUser || self.currentUser.length == 0)
        {
            self.currentUser = @"<noname>";
        }
        for (int i =0 ; i < mDict.count; i++)
        {
            if ([mDict.allKeys[i] isEqualToString:self.currentUser])
            {
                if ([mDict.allValues[i] floatValue] < [self.strWithScore floatValue])
                {
                    [mDict setObject:self.strWithScore forKey:self.currentUser];
                }
            }
            else
            {
                [mDict setObject:self.strWithScore forKey:self.currentUser];
            }
        }
        if (mDict.count == 0)
        {
            [mDict setObject:self.strWithScore forKey:self.currentUser];
        }
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:mDict forKey:@"leader"];
    }
    
}

- (IBAction)howSave:(UISwitch *)sender
{
    if (!self.saveResultProp)
    {
        self.saveResultProp = true;
    }
    else
    {
        self.saveResultProp = false;
    }
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSString* contForName = self.nameOfUser;
//    //NSMutableDictionary* contdict = []
//    if (contForName == nil)
//    {
//        contForName = @"because it don't work";
//    }
//    if ([segue.identifier isEqualToString:@"goToLaeders"])
//    {
//        TableViewController *tabController = (TableViewController*)segue.destinationViewController;
//        [tabController putData: self.strWithScore toDictionary: contForName];
//    }
//}

@end
