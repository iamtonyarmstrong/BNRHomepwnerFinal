//
//  BNRDateChangeViewController.m
//  BNRHomepwnerFinal
//
//  Created by Anthony Armstrong on 5/10/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRDateChangeViewController.h"
#import "BNRItem.h"

@interface BNRDateChangeViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRDateChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Select Date";
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    BNRItem *item = self.item;
    NSDate *originalDate = item.dateCreated;

    //Set the datePickers mode to only record the date, not the hour and minute as well
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];


    self.datePicker.date = originalDate;
    self.datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    _item = self.item;
    _item.dateCreated = self.item.dateCreated;
    
}

- (IBAction)saveNewDateForItem:(id)sender
{
    NSDate *chosenDate = [self.datePicker date];

    //feed this selected date back to the previous controller
    _dvc.item.dateCreated = chosenDate;

    //pop THIS controller off the stack of controllers and go to the previous one.
    [self.navigationController popToViewController:_dvc
                                          animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
