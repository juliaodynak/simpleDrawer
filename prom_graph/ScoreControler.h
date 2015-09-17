//
//  ScoreControler.h
//  prom_graph
//
//  Created by adminaccount on 9/17/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "ViewController.h"

@interface ScoreControler : ViewController
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (strong, nonatomic) NSString* strWithScore;

- (void) putScoreToDisplay:(NSString*) scor;

@end
