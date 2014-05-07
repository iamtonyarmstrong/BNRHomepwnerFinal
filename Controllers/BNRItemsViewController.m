//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Anthony Armstrong on 5/4/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"

@interface BNRItemsViewController ()

@property (nonatomic) NSMutableArray *itemsBelowFiftyDollars;
@property (nonatomic) NSMutableArray *itemsAboveFiftyDollars;
@property (nonatomic) NSMutableArray *dataArray;

@end


@implementation BNRItemsViewController

- (instancetype)init
{
    //call the default init of the superclass, if a developer calls this init
    if(self = [super initWithStyle:UITableViewStylePlain]){
        for(int i = 0; i < 5; i++){
            [[BNRItemStore sharedStore]createItem];
        }
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


-(void)viewDidLoad
{
    [super viewDidLoad];

    //Tell app to use the UITableViewCell class. If I subclassed the UITableViewCell, and I
    //wanted to use it, I'd set that class here...
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];

    //[self.tableView registerClass:[BNRTableViewCell class]
    //       forCellReuseIdentifier:@"BNRTableViewCell"];

    //Now, create a data structure to use in order to populate the sections
    //Initialize the dataArray
    _dataArray = [[NSMutableArray alloc] init];

    _itemsBelowFiftyDollars = [[NSMutableArray alloc]initWithCapacity:5];
    _itemsAboveFiftyDollars = [[NSMutableArray alloc]initWithCapacity:5];

    NSArray *allItems = [[BNRItemStore sharedStore]allItems];
    for (BNRItem *item in allItems) {
        if (item.value < 500) {
            [self.itemsBelowFiftyDollars addObject:item];
        } else {
            [self.itemsAboveFiftyDollars addObject:item];
        }
    }

    NSDictionary *firstItemsArrayDict = [NSDictionary dictionaryWithObject:self.itemsBelowFiftyDollars forKey:@"data"];
    [self.dataArray addObject:firstItemsArrayDict];
    NSLog(@"first data array: %@", self.dataArray);

    NSDictionary *secondItemsArrayDict = [NSDictionary dictionaryWithObject:self.itemsAboveFiftyDollars forKey:@"data"];
    [self.dataArray addObject:secondItemsArrayDict];
    NSLog(@"first data array: %@", self.dataArray);    

}

#pragma mark - Sections of the TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"Number of Sections");
    if(section == 0)
        return @"Items under $500";
    else
        return @"Items over $500";
}


#pragma mark - Create rows and the individual cells of the tables
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [self.dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];

    return [array count];
}

/*
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    //return the count of items in the data store.
    return [[BNRItemStore sharedStore]allItems].count;
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //create an instance of UITableViewCell
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
    //                                              reuseIdentifier:@"BNRTableViewCell"];


    //Get a new or recycled cell using default class for cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];


    NSDictionary *dictionary = [self.dataArray objectAtIndex:indexPath.section];
    NSMutableArray *indexArray = [dictionary objectForKey:@"data"];
    BNRItem *item = (BNRItem *)[indexArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [item description];


    //Set text on cell with description from BNRItem
    //NSArray *items = [[BNRItemStore sharedStore]allItems];
    //BNRItem *item = items[indexPath.row];

    //cell.textLabel.text = [item description];

    return cell;
}

@end
