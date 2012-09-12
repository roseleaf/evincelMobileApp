//
//  Review.h
//  Evincel
//
//  Created by Rose CW on 9/11/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject
@property (strong) NSString* browser;
@property (strong) NSString* comment;
@property (strong) NSString* created_at;
@property (strong) NSString* platform;
@property int website_id;
@end
