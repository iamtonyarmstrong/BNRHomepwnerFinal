//
//  BNRItem.m
//  BNRItems
//
//  Created by Anthony Armstrong on 4/30/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem


//designated initializer
- (instancetype)initWithAnItemName:(NSString *)name
                     aSerialNumber:(NSString *)itemNum
                         andAValue:(int)val
{

    if(self = [super init]){
        _itemName = name;
        _sNumber = itemNum;
        _value = val;
        _dateCreated = [[NSDate alloc]init];

    }
    return self;
}


- (instancetype)initWithAName:(NSString *)name
{
    return [self initWithAnItemName:name
                      aSerialNumber:@""
                          andAValue:0];
}

//Overriding init in NSObject to properly initialize the instance.
- (instancetype) init
{
    return [self initWithAName:@"Item"];
}

//overriding NSObject's -description method
- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc]initWithFormat:@"<item:%@ - item Number:%@ value:%d - date created: %@>", self.itemName, self.sNumber, self.value, self.dateCreated ];
    return descriptionString;
}


+ (instancetype)randomItem
{
    NSArray *randAdjectiveList = @[@"Rusty",@"Shiny",@"Hard",@"Smooth",@"Icy"];
    NSArray *randNounList = @[@"Spoon",@"Shoe",@"Fork",@"Rock"];

    NSInteger adjectiveIndex = arc4random() % [randAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randNounList count];

    NSString *randomName = [NSString stringWithFormat:@"%@ %@", [randAdjectiveList objectAtIndex:adjectiveIndex], [randNounList objectAtIndex:nounIndex]];
    int randomValue = arc4random() % 1000;

    NSString *randomSerialNumber = [NSString stringWithFormat: @"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];

    BNRItem *newItem = [[self alloc]initWithAnItemName:randomName
                                         aSerialNumber:randomSerialNumber
                                             andAValue:randomValue];

    return newItem;
}

- (void)dealloc
{
    NSLog(@"deallocating...Destroyed %@", self);
}

@end
