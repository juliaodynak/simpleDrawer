//
//  ScoreControler.h
//  prom_graph
//
//  Created by adminaccount on 9/17/15.
//

#import "ViewController.h"

@interface ScoreControler : ViewController
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (strong, nonatomic) NSString* strWithScore;
@property (nonatomic, strong) NSString* currentUser;

- (void) putScoreToDisplay:(NSString*)scorstr :(NSString*) name;

@end
