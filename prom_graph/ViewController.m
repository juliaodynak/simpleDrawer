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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    MyCanvas *ob = [[MyCanvas alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:ob];
}

@end
