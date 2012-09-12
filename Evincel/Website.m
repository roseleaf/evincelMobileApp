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


-(UIImage*) hppleParseWithLink:(NSURL *)url {
    NSData  *data      = [NSData dataWithContentsOfURL:url];
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
