//
//  WebsiteStore.h
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Website.h"

@interface WebsiteStore : NSObject
{
    NSMutableArray *websites;
}

+ (WebsiteStore *)defaultStore;
- (NSMutableArray *)websites;


+(void)setupMapping;
+(void)loadAllWithBlock:(void(^)(NSArray *websites))block;
@end
