//
//  BNRDetailViewController.m
//  BNRHomepwnerFinal
//
//  Created by Anthony Armstrong on 5/8/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BNRDetailViewController

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    //ok, take the item that this view gets and populate the fields on the view
    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.sNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.value];

    //And we need an NSDateFormatter to turn the date into a simple string
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }

    //Use filtered date object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    //Clear first responder
    [self.view endEditing:YES];

    BNRItem *item =self.item;
    item.itemName = self.nameField.text;
    item.sNumber = self.serialNumberField.text;
    item.value = [self.valueField.text intValue];
    
}


@end