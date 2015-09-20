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
//    self.dictionaryForRate = [[NSUserDefaults standardUserDefaults]setObject:self.dictionaryForRate forKey:self.name];
    self.dictionaryForRate = [[NSDictionary alloc] initWithObjectsAndKeys:self.scoreResult,self.nameKey, nil];
//    self.dictionaryForRate = [[NSMutableDictionary alloc]init];
//    [self.dictionaryForRate setValue:self.scoreResult forKey: self.nameKey];
    [[NSUserDefaults standardUserDefaults]setObject:self.dictionaryForRate forKey:self.nameKey];
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    [cell.textLabel setText:[self.keyArray objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setText:[self.valueArray objectAtIndex:indexPath.row]];
    
    return cell;
}


@end
