//
//  TableViewController.m
//  prom_graph
//
//  Created by adminaccount on 9/18/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property NSArray *tableData;
@property NSArray *keyArray;
@property NSArray *valueArray;
@property (nonatomic, strong) NSString* scoreResult;
@property (nonatomic, strong) NSString* nameKey;
@property (nonatomic, strong) NSDictionary* dictionaryForRate;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dictionaryForRate = [[NSUserDefaults standardUserDefaults] objectForKey:@"leader"];
    self.keyArray = [self.dictionaryForRate allKeys];
    self.valueArray = [self.dictionaryForRate allValues];

}
- (void) putData:(NSString*)value toDictionary: (NSString*) key
{
    self.scoreResult = value;
    self.nameKey = key;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.keyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.textLabel.textColor = [UIColor colorWithRed:4.0f/255.0f green:180.0f/255.0f blue:243.0f/255.0f alpha:1.0f];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:180.0f/255.0f blue:143.0f/255.0f alpha:0.75f];
    cell.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:240.0f/255.0f blue:143.0f/255.0f alpha:0.2f];
    
    [cell.textLabel setText:[self.keyArray objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setText:[self.valueArray objectAtIndex:indexPath.row]];
    
    return cell;
}


@end
