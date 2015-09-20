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


@end

@implementation ViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self putName];
    self.nameOfUser = self.userName.text;
    
}
- (IBAction)putDataName:(id)sender
{
    self.nameOfUser = self.userName.text;
}

-(void) putName
{
    self.nameOfUser = self.userName.text;
}


@end
