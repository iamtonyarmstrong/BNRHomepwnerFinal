//
//  BNRDetailViewController.h
//  BNRHomepwnerFinal
//
//  Created by Anthony Armstrong on 5/8/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//
//
//  We're implementing camera functionality. In order to do that, we need two delegates
//  here: Notice what's implemented..
//
//

#import <UIKit/UIKit.h>
@class BNRItem;

@interface BNRDetailViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)BNRItem *item;

@end
