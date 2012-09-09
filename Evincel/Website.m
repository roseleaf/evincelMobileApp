//
//  Website.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "Website.h"
#import <RestKit/RestKit.h>
#import "TFHpple.h"

@implementation Website

- (id)init
{
    self = [super init];
    if (self) {
        WEBSITES = [[NSMutableArray alloc] init];
    }
    return self;
}



+(NSMutableArray*)websites{
    return WEBSITES;
}


-(void) websiteByCategoryFetcher {

    NSString* model = @"/websites.json";
    [[RKClient sharedClient] get:model delegate:self];
    
}



- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    if (request.method == RKRequestMethodGET) {
        NSArray* parsedResponse = [response parsedBody:nil];
        NSLog(@"%@", parsedResponse);
        
        
        for (NSDictionary* websiteObject in parsedResponse){
            Website* site = [Website new];
            site.page_title = [websiteObject valueForKey:@"page_title"];
            site.url = [websiteObject valueForKey:@"url"];
            site.category_id = [websiteObject valueForKey:@"category_id"];
            site.image = [self hppleParseWithLink:self.url];
            [WEBSITES addObject:site];
        }
    }
}




-(UIImage*) hppleParseWithLink:(NSString*)url {
    NSData  *data      = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    TFHpple *doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements  = [doc searchWithXPathQuery:@"//link[@rel='icon']"]; //grab favicon
    
    if(![elements count]>=1){
        elements  = [doc searchWithXPathQuery:@"//link[@rel='shortcut icon']"]; //grab favicon
    }
    if([elements count]>=1){
        
        TFHppleElement *element = [elements objectAtIndex:0];
        NSString *srcString = [element objectForKey:@"href"]; //grab favicon src
        
        
        NSURL *url = [NSURL URLWithString:srcString];
        NSData *srcData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:srcData];
        
        NSLog(@"Element <src> parsed: %@",srcString);
        NSLog(@"%@", image);
        return image;
    }
    
    return nil;
}

@end
