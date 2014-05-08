//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Anthony Armstrong on 5/4/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic,readonly,copy) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex: (NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;

@end
