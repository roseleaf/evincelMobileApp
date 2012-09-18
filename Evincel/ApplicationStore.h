//
//  ApplicationStore.h
//  Evincel
//
//  Created by Rose CW on 9/14/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Review.h"
#import "User.h"

@interface ApplicationStore : NSObject
+(void)setUpApplicationStore;
+(void)fetchCategories:(void(^)(void))completionBlock;
+(void)fetchWebsites:(void(^)(void))completionBlock;
+(void)fetchReviews:(void(^)(void))completionBlock;
+(NSManagedObjectContext*)context;
+(void)saveReview:(Review*)review with:(void(^)(void))completionBlock;
+(void)saveUser:(User*)user;
@end
