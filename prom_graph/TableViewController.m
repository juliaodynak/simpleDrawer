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
//    self.dictionaryForRate = [[NSUserDefaults standardUserDefaults]setObject:self.dictionaryForRate forKey:self.name];
   // self.dictionaryForRate = [[NSDictionary alloc] initWithObjectsAndKeys:@"13.05",@"Allice",@"2",@"AAA", nil];
    self.dictionaryForRate = [[NSMutableDictionary alloc]init];
    [self.dictionaryForRate setValue:self.scoreResult forKey: self.nameKey];
    [[NSUserDefaults standardUserDefaults]setObject:self.dictionaryForRate forKey:self.nameKey];
    self.keyArray = [self.dictionaryForRate allKeys];
    self.valueArray = [self.dictionaryForRate allValues];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.keyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    [cell.textLabel setText:[self.keyArray objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setText:[self.valueArray objectAtIndex:indexPath.row]];
    
    return cell;
}


@end
