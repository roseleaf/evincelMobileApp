//
//  ReviewStore.m
//  Evincel
//
//  Created by Rose CW on 9/11/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "ReviewStore.h"
#import "Review.h"

@implementation ReviewStore
+(ReviewStore*)sharedStore {
    static ReviewStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    return sharedStore;
}
+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedStore];
}

-(id)init{
    self = [super init];
    if (self) {
        allReviews = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(NSMutableDictionary*)allReviews{
    return allReviews;
}

-(void) reviewsByWebsiteFetcherWithID:(id)siteId withBlock:(void (^)(void))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        id params = siteId;
        NSString* getResourcePath = [@"/reviews/website/" stringByAppendingFormat:@"%@.json", params];
        [[RKClient sharedClient]get:getResourcePath usingBlock:^(RKRequest* request) {
            request.onDidLoadResponse = ^(RKResponse* response){
            [self parseRKResponse:response];
            dispatch_async(dispatch_get_main_queue(), block);
            };
        }];
        
    });
}


-(void)parseRKResponse:(RKResponse*)response{
    NSMutableDictionary* reviewsBySite = [NSMutableDictionary new];
    id parsedResponse = [response parsedBody:nil];
    
    for (id item in parsedResponse){
        Review* currentReview = [Review new];
        currentReview.browser = [item objectForKey:@"browser"];
        currentReview.comment = [item objectForKey:@"comment"];
        currentReview.created_at = [item objectForKey:@"created_at"];
        currentReview.platform = [item objectForKey:@"platform"];
        currentReview.website_id = [[item objectForKey:@"website_id"]intValue];
    
        if (![reviewsBySite objectForKey:@(currentReview.website_id)]) {
            [reviewsBySite setObject:[NSMutableArray new] forKey:@(currentReview.website_id)];
        }
        
        [[reviewsBySite objectForKey:@(currentReview.website_id)]addObject:currentReview];
    }
    for (NSNumber *key in reviewsBySite.allKeys) {
        [self.allReviews setObject:[reviewsBySite objectForKey:key] forKey:key];
    }
    
}







@end
