//
//  WebsiteStore.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "WebsiteStore.h"
static WebsiteStore *defaultStore = nil;

@implementation WebsiteStore

+ (WebsiteStore *)defaultStore
{
    if (!defaultStore) {
        // Create the singleton
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}


- (id)init
{
    if (defaultStore) {
        return defaultStore;
    }
    
    self = [super init];
    if (self) {
        websites = [[NSMutableArray alloc] init];
    }
    return self;
}




- (NSArray *)websites
{
    return websites;
}


@end
