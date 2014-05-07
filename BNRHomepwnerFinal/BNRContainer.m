//
//  BNRContainer.m
//  BNRItems
//
//  Created by Anthony Armstrong on 4/30/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

@synthesize subItems = _subItems;

- (NSMutableArray *)subItems
{
    if(!_subItems) _subItems = [self setSubItems];
    return _subItems;
}

- (NSMutableArray *)setSubItems
{
    return [[NSMutableArray alloc]init];
}

- (void) addItemToSubItems:(id)item
{
    //NSLog(@"%@", [item description]);
    [self.subItems addObject:item];
}

- (id) itemInCollection:(int)index
{
    return [self.subItems objectAtIndex:index];
}

- (int) sumOfItemsInCollection
{

    for (id item in self.subItems) {
        if([item isMemberOfClass:[BNRItem class]]) {
            self.sum += [(BNRItem *)item value]; //casting the id to a BNRItem so I can use methods on it
        } else {
            BNRContainer *c = item;
            int internalSums = 0;
            for (int j = 0; j < [c.subItems count]; j++) {
                internalSums += ((BNRItem *)c.subItems[j]).value;
            }
            self.sum += internalSums;
        }
    }
    return self.sum;
}

/*
- (int) valueOfItemsInCollection
{
    int internalSum = 0;
    for(BNRItem *content in self.subItems){
        internalSum += content.value;
        NSLog(@"value internally: %d", internalSum);
    }

    return internalSum;
}
 */


- (NSString *)description
{
    NSString *descString = [[NSString alloc]initWithFormat:@"Internal values: %@", self.subItems];

    return descString;
}


@end
