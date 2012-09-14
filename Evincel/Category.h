//
//  Category.h
//  Evincel
//
//  Created by Rose CW on 9/14/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Category : NSManagedObject
@property (strong) NSString* name;
@property (strong) NSString* image;
@property int category_id;
@end
