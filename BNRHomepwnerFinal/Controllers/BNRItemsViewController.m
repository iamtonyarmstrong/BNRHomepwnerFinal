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
    //Add new item to the tableview and the BNRItemStore
    //NSInteger lastRow = [self.tableView numberOfRowsInSection:0];

    BNRItem *newItem = [[BNRItemStore sharedStore]createItem];

    //Figure out where the item goes in the array
    NSInteger lastRow = [[[BNRItemStore sharedStore]allItems] indexOfObject:newItem];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];

    //Inser this new row into the table.
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)toggleEditingMode:(id)sender
{
    //if you are currently in editing mode, here's what you're going to do
    if(self.isEditing){
        //Change the state of the button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];

        //turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        //Change the state of the button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];

        //Enter editing mode
        [self setEditing:YES animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if tableview is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore]allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore]removeItem:item];

        //Also remove that item from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore]moveItemAtIndex:sourceIndexPath.row
                                       toIndex:destinationIndexPath.row];
}
 
-(NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"No More Items.";
}

@end
