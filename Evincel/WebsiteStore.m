//
//  WebsiteStore.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "WebsiteStore.h"
static WebsiteStore *defaultStore = nil;

@implementation WebsiteStore

+ (WebsiteStore *)defaultStore
{
    if (!defaultStore) {
        // Create the singleton
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}


- (id)init
{
    if (defaultStore) {
        return defaultStore;
    }
    
    self = [super init];
    if (self) {
        websites = [[NSMutableArray alloc] init];
    }
    return self;
}




- (NSMutableArray *)websites
{
    return websites;
}



+(void)setupMapping
{
    RKObjectMapping *websiteMapping = [RKObjectMapping mappingForClass:[Website class]];
    [websiteMapping mapKeyPath:@"page_title" toAttribute:@"page_title"];
    [websiteMapping mapKeyPath:@"url" toAttribute:@"url"];
    [websiteMapping mapKeyPath:@"category_id" toAttribute:@"category_id"];

    
    RKObjectMappingProvider *omp = [RKObjectManager sharedManager].mappingProvider;
    
    [omp setObjectMapping:websiteMapping forResourcePathPattern:@"/websites.json"];
    [omp setObjectMapping:websiteMapping forResourcePathPattern:@"/websites/category/:category_id\\.json"];
}

+(void)loadAllWithBlock:(void (^)(NSArray *websites))block
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/websites.json" usingBlock:^(RKObjectLoader *loader) {
        loader.onDidLoadObjects = block;
    }];
}





@end
