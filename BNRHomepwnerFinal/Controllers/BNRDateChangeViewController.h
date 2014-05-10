//
//  BNRDateChangeViewController.h
//  BNRHomepwnerFinal
//
//  Created by Anthony Armstrong on 5/10/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;
@class BNRDetailViewController;

@interface BNRDateChangeViewController : UIViewController

@property BNRItem *item;
@property (nonatomic, weak) BNRDetailViewController *dvc;


@end
