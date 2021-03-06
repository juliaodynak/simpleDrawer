//
//  ViewController.m
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//

#import "ViewController.h"
#import "MyCanvas.h"
#import "TableViewController.h"
#import "FigureController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation ViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"5652.png"]]];
    self.startButton.enabled = NO;
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToGame"])
    {
        FigureController *figController = (FigureController*)segue.destinationViewController;
        [figController putName:self.userName.text];
    }
}


#pragma mark - UITextFieldDelegate <NSObject>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.startButton.enabled = [str length] >3;
    
    NSCharacterSet *set = [NSCharacterSet decimalDigitCharacterSet];
    NSString *s = [string stringByTrimmingCharactersInSet:set];
    
    return [s isEqualToString:string];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self performSegueWithIdentifier:@"goToGame" sender:self];
    return YES;
}

@end
