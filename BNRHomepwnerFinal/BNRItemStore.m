//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Anthony Armstrong on 5/4/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+(instancetype)sharedStore
{
    static BNRItemStore *sharedStore;
    if (!sharedStore) sharedStore = [[BNRItemStore alloc] initPrivate];

    return sharedStore;
}

- (instancetype)init
{
    [NSException raise:@"Singleton"
                format:@"Use +[BNRItemStore sharedStore"];

    return nil;
}

- (instancetype) initPrivate
{
    if(self = [super init]){
        _privateItems = [NSMutableArray array];
    }
    return self;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemUUIDKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (NSArray *) allItems
{
    return [self.privateItems copy];
}

- (void)moveItemAtIndex: (NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }

    //Get a pointer to the item you're planning to move
    BNRItem *item = self.privateItems[fromIndex];

    //Remove item from array, then put that item into the new array position
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}


@end
