//
//  ApplicationStore.m
//  Evincel
//
//  Created by Rose CW on 9/14/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "ApplicationStore.h"
#import <RestKit/RestKit.h>
#import "Category.h"
#import "Website.h"
#import "Review.h"

static RKObjectManager* evincelObjectManager;

@implementation ApplicationStore
+(void)setUpApplicationStore{
    RKClient* baseClient = [RKClient clientWithBaseURLString:@"http://evincel.com/"];
    baseClient.username = @"rose";
    baseClient.password = @"foobar";
    evincelObjectManager = [[RKObjectManager alloc] init];
    evincelObjectManager.client = baseClient;
    
    evincelObjectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"applicationStore.sqlite3"];
    
    [self setupcategoryMapping];
    [self setupWebsiteMapping];
    [self setupReviewMapping];
}

+(NSManagedObjectContext*)context{
    return  evincelObjectManager.objectStore.primaryManagedObjectContext;
}


//Category Methods:
+(void)setupcategoryMapping {
    RKManagedObjectMapping* categoryMapping = [RKManagedObjectMapping mappingForClass:[Category class] inManagedObjectStore:evincelObjectManager.objectStore];
    categoryMapping.objectClass = [Category class];
    [categoryMapping mapKeyPath:@"id" toAttribute:@"category_id"];
    [categoryMapping mapAttributes:@"name", nil];
    [categoryMapping mapAttributes:@"image", nil];
    categoryMapping.primaryKeyAttribute = @"category_id";
    
    [evincelObjectManager.mappingProvider addObjectMapping:categoryMapping];
    
    RKObjectMapping* serializationMapping = categoryMapping.inverseMapping;
    serializationMapping.rootKeyPath = @"category";
    
    [evincelObjectManager.mappingProvider setSerializationMapping:serializationMapping forClass:[Category class]];
    
    [evincelObjectManager.router routeClass:[Category class] toResourcePath:@"/categories.json"];
}




+(void)fetchCategories:(void(^)(void))completionBlock{
    [evincelObjectManager loadObjectsAtResourcePath:@"/categories.json" usingBlock:^(RKObjectLoader *loader) {
        loader.objectMapping = [evincelObjectManager.mappingProvider objectMappingForClass:[Category class]];
        
        loader.onDidLoadObjects = ^(NSArray* objects) {
            //if (completionBlock)
            completionBlock();
        };
        loader.onDidFailLoadWithError = ^(NSError* err) {
            NSLog(@"%@", err);
        };
    }];
}


//Website Methods:
+(void)setupWebsiteMapping{
    RKManagedObjectMapping* websiteMapping = [RKManagedObjectMapping mappingForClass:[Website class] inManagedObjectStore:evincelObjectManager.objectStore]; //inManagedObjectStore:websiteManager.objectStore];
    websiteMapping.objectClass = [Website class];
    [websiteMapping mapKeyPath:@"id" toAttribute:@"website_id"];
    [websiteMapping mapAttributes:@"page_title", nil];
    [websiteMapping mapAttributes:@"url", nil];
    [websiteMapping mapAttributes:@"category_id", nil];
    websiteMapping.primaryKeyAttribute = @"website_id";
    
    [evincelObjectManager.mappingProvider addObjectMapping:websiteMapping];
    RKObjectMapping* serializationMapping = websiteMapping.inverseMapping;
    serializationMapping.rootKeyPath = @"website";
    
    [evincelObjectManager.mappingProvider setSerializationMapping:serializationMapping forClass:[Website class]];
    
    [evincelObjectManager.router routeClass:[Website class] toResourcePath:@"/websites.json"];
}

+(void)fetchWebsites:(void(^)(void))completionBlock{
    [evincelObjectManager loadObjectsAtResourcePath:@"/websites.json" usingBlock:^(RKObjectLoader *loader) {
        loader.objectMapping = [evincelObjectManager.mappingProvider objectMappingForClass:[Website class]];
        
        loader.onDidLoadObjects = ^(NSArray* objects) {
            //if (completionBlock)
            completionBlock();
        };
        loader.onDidFailLoadWithError = ^(NSError* err) {
            NSLog(@"%@", err);
        };
    }];
}


+(void)saveWebsite:(Website*)website{
    [evincelObjectManager postObject:website delegate:nil];
}





//Review Methods:
+(void)setupReviewMapping {
    RKManagedObjectMapping* reviewMapping = [RKManagedObjectMapping mappingForClass:[Review class] inManagedObjectStore:evincelObjectManager.objectStore]; 
    reviewMapping.objectClass = [Review class];
    [reviewMapping mapKeyPath:@"id" toAttribute:@"review_id"];
    [reviewMapping mapAttributes:@"comment", nil];
    [reviewMapping mapAttributes:@"created_at", nil];
    [reviewMapping mapAttributes:@"platform", nil];
    [reviewMapping mapAttributes:@"website_id", nil];
    [reviewMapping mapAttributes:@"posted_by", nil];
    [reviewMapping mapAttributes:@"rating", nil];
    [reviewMapping mapAttributes:@"browser", nil];

    
    reviewMapping.primaryKeyAttribute = @"review_id";
    
    [evincelObjectManager.mappingProvider addObjectMapping:reviewMapping];
    RKObjectMapping* serializationMapping = reviewMapping.inverseMapping;
    serializationMapping.rootKeyPath = @"review";
    
    [evincelObjectManager.mappingProvider setSerializationMapping:serializationMapping forClass:[Review class]];
    
    [evincelObjectManager.router routeClass:[Review class] toResourcePath:@"/reviews.json"];
}


+(void)fetchReviews:(void(^)(void))completionBlock{
    [evincelObjectManager loadObjectsAtResourcePath:@"/reviews.json" usingBlock:^(RKObjectLoader *loader) {
        loader.objectMapping = [evincelObjectManager.mappingProvider objectMappingForClass:[Review class]];
        
        loader.onDidLoadObjects = ^(NSArray* objects) {
            //if (completionBlock)
            completionBlock();
        };
        loader.onDidFailLoadWithError = ^(NSError* err) {
            NSLog(@"%@", err);
        };
    }];
}
+(void)saveReview:(Review*)review {
    [evincelObjectManager postObject:review delegate:nil];
}



//-(void)reviewsByWebsite: (id)siteId WithBlock:(void(^)(NSArray*))block {
//    id params = siteId;
//    NSString* resourcePath = [@"/reviews/website/" stringByAppendingFormat:@"%@.json", params];
//    
//    
//    [reviewObjectManager loadObjectsAtResourcePath:resourcePath usingBlock:^(RKObjectLoader *loader) {
//        loader.objectMapping = [reviewObjectManager.mappingProvider objectMappingForClass:[Review class]];
//        loader.onDidLoadObjects = ^(NSArray* objects){
//            reviewArray = nil;
//            reviewArray = [NSArray arrayWithArray:objects];
//            block(objects);
//        };
//    }];
//}



@end
