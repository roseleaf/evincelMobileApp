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

@interface Website : NSManagedObject <RKRequestDelegate> {
}

@property (strong) NSString* page_title;
@property (strong) NSString* url;
@property (strong) UIImage* image;
@property int category_id;
@property int website_id;
@property (strong) NSMutableArray* reviews;
//-(void)performBlockWithImages:(void (^)(UIImage*)) block;

@end
