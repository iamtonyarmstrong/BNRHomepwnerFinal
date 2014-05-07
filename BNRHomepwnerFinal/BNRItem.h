//
//  BNRItem.h
//  BNRItems
//
//  Created by Anthony Armstrong on 4/30/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *sNumber;
@property (nonatomic) int value;
@property (nonatomic, strong) NSDate *dateCreated;

//designated init method
- (instancetype)initWithAnItemName:(NSString *)name
                      aSerialNumber:(NSString *)sNum
                         andAValue:(int)val;


- (instancetype)initWithAName:(NSString *)name;
- (NSString *)description;
- (void)dealloc;
+ (instancetype)randomItem;

@end
