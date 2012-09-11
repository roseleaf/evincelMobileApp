//
//  WebsiteStore.h
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Website.h"
#import <RestKit/RestKit.h>

NSMutableArray* WEBSITES;

@interface WebsiteStore : NSObject <RKRequestDelegate>
{
    NSMutableArray *websites;
}

//+ (WebsiteStore *)defaultStore;
@property (strong) NSMutableArray *websites;
-(NSMutableArray*)websiteList;
-(void) websiteByCategoryFetcherWithID:(id)catId;
//+(void)setupMapping;
//+(void)loadAllWithBlock:(void(^)(NSArray *websites))block;
@end
