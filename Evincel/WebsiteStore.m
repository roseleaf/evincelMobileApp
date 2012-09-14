//
//  WebsiteStore.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "WebsiteStore.h"

@interface WebsiteStore ()
@end

static RKObjectManager* websiteManager;

@implementation WebsiteStore
+ (WebsiteStore *)sharedStore{
    static WebsiteStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    return sharedStore;
}
+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedStore];
}


- (id)init
{
    self = [super init];
    if (self) {
        allWebsites = [[NSMutableDictionary alloc] init];
        websiteArray = [NSMutableArray new];
    }
    return self;
}

-(NSMutableArray*)websiteGroup{
    return websiteArray;
}

-(NSMutableDictionary*)allWebsites{
    return allWebsites;
}
-(NSMutableArray*)searchResults{
    return self.results;
}


+(void)setupWebsiteStore{
    websiteManager = [[RKObjectManager alloc]init];
    websiteManager.client = [RKClient sharedClient];
    websiteManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"websiteStore.sqlite3"];

    [self setupWebsiteMapping];
}

+(void)setupWebsiteMapping{
    RKObjectMapping* websiteMapping = [RKObjectMapping mappingForClass:[Website class]]; //inManagedObjectStore:websiteManager.objectStore];
    websiteMapping.objectClass = [Website class];

    [websiteMapping mapKeyPath:@"page_title" toAttribute:@"page_title"];
    [websiteMapping mapKeyPath:@"url" toAttribute:@"url"];
    [websiteMapping mapKeyPath:@"category_id" toAttribute:@"category_id"];
    [websiteMapping mapKeyPath:@"website_id" toAttribute:@"website_id"];
    //websiteMapping.primaryKeyAttribute = @"website_id";

    [websiteManager.mappingProvider addObjectMapping:websiteMapping];
    RKObjectMapping* serializationMapping = websiteMapping.inverseMapping;

    [websiteManager.mappingProvider setSerializationMapping:websiteMapping forClass:[Website class]];
    serializationMapping.rootKeyPath = @"website";

    [websiteManager.router routeClass:[Website class] toResourcePath:@"/websites.json"];
}

-(void)websitesByCategory:(id)catId withBlock:(void (^)(NSArray *))block{
    id params = catId;
    NSString* resourcePath = [@"/websites/category/" stringByAppendingFormat:@"%@.json", params];
    
    [websiteManager loadObjectsAtResourcePath:resourcePath usingBlock:^(RKObjectLoader* loader){
        loader.objectMapping = [websiteManager.mappingProvider objectMappingForClass:[Website class]];
        loader.onDidLoadObjects = ^(NSArray* objects) {
            websiteArray = nil;
            websiteArray = [NSArray arrayWithArray:objects];
            block(objects);
        };
    }];
}

+(void)saveWebsite:(Website*)website{
    [websiteManager postObject:website delegate:nil];
}


-(void) websitesByCategoryFetcherWithID:(id)catId withBlock:(void(^)(void))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                
        id params = catId;
        NSString* getResourcePath = [@"/websites/category/" stringByAppendingFormat:@"%@.json", params];
        [[RKClient sharedClient]get:getResourcePath usingBlock:^(RKRequest* request){
            request.onDidLoadResponse = ^(RKResponse* response){
                [self parseRKResponse:response];
                dispatch_async(dispatch_get_main_queue(), block);
            };
        }];
    });
}


-(void) websitesBySearchTerm:(NSString*)query withBlock:(void(^)(void))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSString* getResourcePath = [@"/websites.json?utf8=%E2%9C%93&search=" stringByAppendingFormat:@"%@", query];
        [[RKClient sharedClient]get:getResourcePath usingBlock:^(RKRequest* request){
            request.onDidLoadResponse = ^(RKResponse* response){
                [self parseSearchResults:response];
                dispatch_async(dispatch_get_main_queue(), block);
            };
        }];
    });
}

-(void)parseSearchResults:(RKResponse*)response{
    self.results = [NSMutableArray new];
    id parsedResponse = [response parsedBody:nil];
    for (id item in parsedResponse){
        
        Website* currentSite = [Website new];
        currentSite.page_title = [item objectForKey:@"page_title"];
        currentSite.url = [item objectForKey:@"redirect_url"];
        currentSite.image = [self getFaviconForSite:currentSite];
        currentSite.category_id = [[item objectForKey:@"category_id"]intValue];
        currentSite.website_id = [[item objectForKey:@"id"]intValue];
    [self.results addObject:currentSite];
    }
}




-(void)parseRKResponse:(RKResponse*) response{
    NSMutableDictionary* sitesByCategory = [NSMutableDictionary new];
    id parsedResponse = [response parsedBody:nil];
    
    for (id item in parsedResponse){
                
        Website* currentSite = [Website new];
        currentSite.page_title = [item objectForKey:@"page_title"];
        currentSite.url = [item objectForKey:@"redirect_url"];
        currentSite.image = [self getFaviconForSite:currentSite];
        currentSite.category_id = [[item objectForKey:@"category_id"]intValue];
                currentSite.website_id = [[item objectForKey:@"id"]intValue];
                
        if (![sitesByCategory objectForKey:@(currentSite.category_id)]) {
            [sitesByCategory setObject:[NSMutableArray new] forKey:@(currentSite.category_id)];
        }
        [[sitesByCategory objectForKey:@(currentSite.category_id)] addObject:currentSite];
    }
    
    
    for (NSNumber *key in sitesByCategory.allKeys) {
        [self.allWebsites setObject:[sitesByCategory objectForKey:key] forKey:key];
    }
}


-(UIImage*)getFaviconForSite:(Website*)website{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http.*?//" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString* baseDomain = [regex stringByReplacingMatchesInString:website.url options:0 range:NSMakeRange(0, [website.url length]) withTemplate:@""];
    NSURL* faviconPath = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/s2/favicons?domain=%@", baseDomain]];
    NSData* data = [NSData dataWithContentsOfURL:faviconPath];
    return [UIImage imageWithData:data];
}









@end
