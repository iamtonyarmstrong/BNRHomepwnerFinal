//
//  BNRContainer.h
//  BNRItems
//
//  Created by Anthony Armstrong on 4/30/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRItem.h"

@interface BNRContainer : BNRItem

@property (nonatomic, strong) NSMutableArray *subItems; //container of items, including another BNRContainer
@property (nonatomic) int sum;
@property (nonatomic) int valueOfItemsInCollection;

- (NSMutableArray *)subItems;
- (void) addItemToSubItems:(id)item;
- (id) itemInCollection:(int)index;
- (int) sumOfItemsInCollection;
//- (NSString *)description;

@end
