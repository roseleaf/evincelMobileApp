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
    NSMutableArray* websiteArray;
    NSMutableDictionary* allWebsites;
}


+ (WebsiteStore *)sharedStore;
-(NSMutableArray*)websites;
+(void)setupWebsiteStore;
-(void)websitesByCategory: (id)catId withBlock: (void(^)(NSArray*))block;


@property (strong) NSMutableArray* results;
@property (strong) NSMutableArray* websites;
-(void) websitesByCategoryFetcherWithID:(id)catId withBlock:(void(^)(void))block;
-(void) websitesBySearchTerm:(NSString*)query withBlock:(void(^)(void))block;
-(NSMutableDictionary*)allWebsites;
-(NSMutableArray*)results;

@end
