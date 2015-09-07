//
//  ViewController.h
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *square;
@property (strong, nonatomic) IBOutlet UILabel *touchesBeganX;
@property (strong, nonatomic) IBOutlet UILabel *touchesBeganY;
@property (strong, nonatomic) IBOutlet UILabel *touchesMovedX;
@property (strong, nonatomic) IBOutlet UILabel *touchesMovedY;
@property (strong, nonatomic) IBOutlet UILabel *touchesEndedX;
@property (strong, nonatomic) IBOutlet UILabel *touchesEndedY;
@property (strong, nonatomic) IBOutlet UILabel *contactCount;
@property (strong, nonatomic) IBOutlet UILabel *touchesCount;

@end

