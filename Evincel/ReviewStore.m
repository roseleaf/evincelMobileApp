//
//  ReviewStore.m
//  Evincel
//
//  Created by Rose CW on 9/11/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "ReviewStore.h"
#import "Review.h"



static RKObjectManager* reviewObjectManager;

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
        reviewArray = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSMutableArray*)allReviews{
    return reviewArray;
}





+(void)setupReviewStore {
    RKClient* reviewClient = [RKClient clientWithBaseURLString:@"http://evincel.com"];
    reviewObjectManager = [[RKObjectManager alloc] init];
    reviewObjectManager.client = reviewClient;
    
    [self setupReviewMapping];
}

+(void)setupReviewMapping {
    RKObjectMapping* reviewMapping = [RKObjectMapping mappingForClass:[Review class]];
    [reviewMapping mapKeyPath:@"browser" toAttribute:@"browser"];
    [reviewMapping mapKeyPath:@"comment" toAttribute:@"comment"];
    [reviewMapping mapKeyPath:@"created_at" toAttribute:@"created_at"];
    [reviewMapping mapKeyPath:@"platform" toAttribute:@"platform"];
    [reviewMapping mapKeyPath:@"website_id" toAttribute:@"website_id"];
    [reviewObjectManager.mappingProvider addObjectMapping:reviewMapping];
    [reviewObjectManager.mappingProvider setSerializationMapping:reviewMapping forClass:[Review class]];
    
    [reviewObjectManager.router routeClass:[Review class] toResourcePath:@"/reviews.json"];
}


-(void)reviewsByWebsite: (id)siteId WithBlock:(void(^)(NSArray*))block {
    id params = siteId;
    NSString* resourcePath = [@"/reviews/website/" stringByAppendingFormat:@"%@.json", params];

    
    [reviewObjectManager loadObjectsAtResourcePath:resourcePath usingBlock:^(RKObjectLoader *loader) {
        loader.objectMapping = [reviewObjectManager.mappingProvider objectMappingForClass:[Review class]];
        loader.onDidLoadObjects = ^(NSArray* objects){
            reviewArray = nil;
            reviewArray = [NSArray arrayWithArray:objects];
            block(objects);
        };
    }];
}

+(void)saveReview:(Review*)review {
    [reviewObjectManager postObject:review delegate:nil];
}


@end
