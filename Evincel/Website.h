//
//  Website.h
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//
#import <RestKit/RestKit.h>
#import <Foundation/Foundation.h>

NSMutableArray* WEBSITES;

@interface Website : NSObject <RKRequestDelegate> {
}
-(void) websiteByCategoryFetcher;

@property (strong) NSString* page_title;
@property (strong) NSString* url;
@property (strong) UIImage* image;
@property (strong) NSString* category_id;
@property (strong) NSMutableArray* reviews;

+(NSMutableArray*)websites;
@end
