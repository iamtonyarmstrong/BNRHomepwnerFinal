//
//  BNRImageStore.h
//  BNRHomepwnerFinal
//
//  Created by Anthony Armstrong on 5/10/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//
//  We will use a singleton pattern for the instantiation
//
//
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage: (UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey: (NSString *)key;
- (void)deleteImageForKey: (NSString *)key;

@end
