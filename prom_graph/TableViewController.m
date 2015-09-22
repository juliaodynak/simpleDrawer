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
@property (nonatomic, strong) NSMutableDictionary* dictionaryForRate;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dictionaryForRate = [[NSUserDefaults standardUserDefaults] objectForKey:@"leader"];
    self.keyArray = [self.dictionaryForRate allKeys];
    self.valueArray = [self.dictionaryForRate allValues];

}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString* gs =;
//    
//    
//    
//}


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
    cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold"  size:19.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Courier"  size:19.0];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:111.0f/255.0f green:168.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    
    [cell.textLabel setText:[self.keyArray objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setText:[self.valueArray objectAtIndex:indexPath.row]];
    
    return cell;
}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //remove the deleted object from your data source.
//        //If your data source is an NSMutableArray, do this
//        //NSString* hghsd = self.nameKey[indexPath.row];
//        [self.dictionaryForRate removeObjectForKey:[self.valueArray objectAtIndex:indexPath.row ]];
//        [tableView reloadData]; // tell table to refresh now
//    }
//}

@end
