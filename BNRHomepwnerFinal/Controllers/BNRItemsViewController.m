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

@property (nonatomic,strong) IBOutlet UIView *headerView;

@end


@implementation BNRItemsViewController

- (instancetype)init
{
    //call the default init of the superclass, if a developer calls this init
    if(self = [super initWithStyle:UITableViewStylePlain]){
        for(int i = 0; i < 5; i++){
            [[BNRItemStore sharedStore]createItem];
        }
        NSLog(@"%@", [[BNRItemStore sharedStore]allItems]);
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (UIView *)headerView
{
    if (!_headerView) {
        //load NIB file
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
    }
    return _headerView;
}


-(void)viewDidLoad
{
    [super viewDidLoad];

    //get some room at the top of the cells...
    [self.tableView setContentInset:UIEdgeInsetsMake(50,0,0,0)];

    //Tell app to use the UITableViewCell class. If I subclassed the UITableViewCell, and I
    //wanted to use it, I'd set that class here...
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];

    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];

}

#pragma mark - Create rows and the individual cells of the tables
- (NSInteger)numberOfSections
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //create an instance of the UITableViewCell with default appearance
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];

    //Set text on the cell with description from BNRItem
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];

    cell.textLabel.text = [item description];

    return cell;
}

#pragma mark - Methods to handle editing of table
- (IBAction)addNewItem:(id)sender
{

}

- (IBAction)toggleEditingMode:(id)sender
{

}


@end
