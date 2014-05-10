//
//  BNRImageStore.m
//  BNRHomepwnerFinal
//
//  Created by Anthony Armstrong on 5/10/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

#pragma mark - Initializers (including raising exception)
//utilize singtleton pattern for instantiation
+ (instancetype)sharedStore
{
    static BNRImageStore *sharedStore;
    if (!sharedStore) sharedStore = [[self alloc] initPrivate ];

    return sharedStore;
}

- (instancetype) initPrivate
{
    if (self = [super init]) _dictionary = [[NSMutableDictionary alloc]init];

    return self;
}

//Raise an exception
- (instancetype) init
{
    [NSException raise:@"SingletonError"
                format:@"Instatiate using [BNRImageStore sharedStore]"];

    return nil;
}

#pragma mark - Image-related methods
- (void)setImage: (UIImage *)image
          forKey:(NSString *)key
{
    self.dictionary[key] = image;
    //same as [self.dictionary setObject:image forKey:key];
}

- (UIImage *)imageForKey: (NSString *)key
{

    return self.dictionary[key];
    //same as return [self.dictionary objectForKey:key];
}

- (void)deleteImageForKey: (NSString *)key
{
    if(!key) return;

    [self.dictionary removeObjectForKey:key];
}

@end
