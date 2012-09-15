//
//  Website.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "Website.h"
#import <RestKit/RestKit.h>

@implementation Website
@dynamic page_title;
@dynamic url;
@dynamic image;
@dynamic category_id;
@dynamic website_id;

- (id)init
{
    self = [super init];
    if (self) {
        WEBSITES = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
