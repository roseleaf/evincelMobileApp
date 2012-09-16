//
//  Review.h
//  Evincel
//
//  Created by Rose CW on 9/11/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Review : NSManagedObject
@property (strong) NSString* browser;
@property (strong) NSString* comment;
@property (strong) NSString* created_at;
@property (strong) NSString* platform;
@property (strong) NSString* posted_by;
@property int rating;
@property (strong)NSNumber* website_id;
@property int review_id;
@end
