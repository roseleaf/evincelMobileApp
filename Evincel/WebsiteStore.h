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

//NSMutableArray* WEBSITES;

@interface WebsiteStore : NSObject <RKRequestDelegate>
{
    NSMutableDictionary* allWebsites;
}


+ (WebsiteStore *)sharedStore;
@property (strong) NSMutableArray* results;
@property (strong) NSMutableArray* websites;
-(void) websitesByCategoryFetcherWithID:(id)catId withBlock:(void(^)(void))block;
-(void) websitesBySearchTerm:(NSString*)query withBlock:(void(^)(void))block;
-(NSMutableDictionary*)allWebsites;
-(NSMutableArray*)results;

//+(void)setupMapping;
//+(void)loadAllWithBlock:(void(^)(NSArray *websites))block;
@end
