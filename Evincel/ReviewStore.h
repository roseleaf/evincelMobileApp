//
//  ReviewStore.h
//  Evincel
//
//  Created by Rose CW on 9/11/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>

@interface ReviewStore : NSObject <RKRequestDelegate> {
    NSMutableArray* reviewArray;
}
+ (ReviewStore*) sharedStore;
-(NSMutableArray*)allReviews;

+(void)setupReviewStore;
-(void)reviewsByWebsite: (id)siteId WithBlock: (void(^)(NSArray*))block;

@end
