//
//  WebsiteStore.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "WebsiteStore.h"
//static WebsiteStore *defaultStore = nil;

@interface WebsiteStore ()
@end
@implementation WebsiteStore

//+ (WebsiteStore *)defaultStore
//{
//    if (!defaultStore) {
//        // Create the singleton
//        defaultStore = [[super alloc] init];
//        defaultStore.websites = [[NSMutableArray alloc] init];
//
//    }
//    return defaultStore;
//}


- (id)init
{
//    if (defaultStore) {
//        return defaultStore;
//    }
    
    self = [super init];
    if (self) {
        
        self.websites = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray*)websiteList{
    return self.websites;
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




-(void) websiteByCategoryFetcherWithID:(id)catId {
    NSString* model = @"/websites/category/";

    id params = catId;
    NSString* getResourcePath = [model stringByAppendingFormat:@"%@%@", params, @".json"];
    
    [[RKClient sharedClient] get:getResourcePath delegate:self];

}


- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    if (request.method == RKRequestMethodGET) {
        NSArray* parsedResponse = [response parsedBody:nil];
        
        for (NSDictionary* website in parsedResponse){
            [self.websites addObject:website];
            NSLog(@"!!!!!!!!!!!!");
        }
        NSLog(@"%@", self.websites);
        
    }
}



@end
