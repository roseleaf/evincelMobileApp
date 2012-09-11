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
@property int category_id;
@property (strong) NSMutableArray* reviews;
-(UIImage*) hppleParseWithLink:(NSURL*)url;
+(NSMutableArray*)websites;
-(void)performBlockWithImages:(void (^)(UIImage*)) block;

@end
