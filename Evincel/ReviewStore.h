//
//  ReviewStore.h
//  Evincel
//
//  Created by Rose CW on 9/11/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface ReviewStore : NSObject <RKRequestDelegate> {
    NSMutableDictionary* allReviews;
}

+ (ReviewStore*) sharedStore;
@property (strong) NSMutableArray* reviews;

-(void)reviewsByWebsiteFetcherWithID:(id)siteId withBlock:(void(^)(void)) block;
-(NSMutableDictionary*)allReviews;
@end
