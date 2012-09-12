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
    }
    return self;
}


-(NSMutableDictionary*)allWebsites{
    return allWebsites;
}

-(void) websitesByCategoryFetcherWithID:(id)catId withBlock:(void(^)(void))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                
        NSString* model = @"/websites/category/";
        id params = catId;
        NSString* getResourcePath = [model stringByAppendingFormat:@"%@%@", params, @".json"];
        [[RKClient sharedClient]get:getResourcePath usingBlock:^(RKRequest* request){
            request.onDidLoadResponse = ^(RKResponse* response){
                [self parseRKResponse:response];
                dispatch_async(dispatch_get_main_queue(), block);
            };
        }];
    });
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
