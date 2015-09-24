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
@property NSMutableArray *keyArray;
@property NSMutableArray *valueArray;
@property NSArray *contForKeys;
@property NSArray *contValueArray;
@property (nonatomic, strong) NSString* scoreResult;
@property (nonatomic, strong) NSString* nameKey;
@property (nonatomic, strong) NSMutableDictionary* dictionaryForRate;
@property NSDictionary* dictForUse;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dictForUse = [[NSUserDefaults standardUserDefaults] objectForKey:@"leader"];
    self.dictionaryForRate = [self.dictForUse mutableCopy];
    self.keyArray = [[NSMutableArray alloc]init];
    self.valueArray = [[NSMutableArray alloc]init];
    self.contForKeys = [self.dictionaryForRate allKeys];
    
    self.contValueArray = [[self.dictionaryForRate allValues] sortedArrayUsingComparator:^(id obj1, id obj2) {
        if ([obj1 doubleValue] > [obj2 doubleValue])
            return (NSComparisonResult)NSOrderedAscending;
        if ([obj1 doubleValue] < [obj2 doubleValue])
            return (NSComparisonResult)NSOrderedDescending;
        return (NSComparisonResult)NSOrderedSame;
    }];
    self.valueArray = [self.contValueArray mutableCopy];
    int i =0;
    while (self.keyArray.count != self.contForKeys.count)
    {
        for (NSString * key in self.contForKeys)
        {
            if ([self.contValueArray[i] isEqualToString:[self.dictionaryForRate valueForKey:key]])
            {
                self.keyArray[i] = key;
                i++;
                break;
            }
        }
    }
    

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
    cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold"  size:19.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Courier"  size:19.0];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:111.0f/255.0f green:168.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    
    [cell.textLabel setText:[self.keyArray objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setText:[self.valueArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger index = indexPath.row;
        NSString *objectToDelete = [self.valueArray objectAtIndex:index];
        
        for (NSString * key in self.keyArray)
        {
            if ([objectToDelete isEqualToString:[self.dictionaryForRate valueForKey:key]])
            {
                [self.dictionaryForRate removeObjectForKey:key];
                [[NSUserDefaults standardUserDefaults] setObject:self.dictionaryForRate forKey:@"leader"];
                break;
            }
        }
                
        [self.keyArray removeObjectAtIndex:index];
        [self.valueArray removeObjectAtIndex:index];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
