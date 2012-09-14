//
//  CategoryStore.h
//  Evincel
//
//  Created by Rose CW on 9/13/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
@interface CategoryStore : NSObject <RKRequestDelegate>
{
    NSMutableArray* allCategories;
}

+(CategoryStore*)sharedStore;
-(NSMutableArray*)categories;
+(void)setUpCategoryStore;
+(void)fetchCategories:(void(^)(void))completionBlock;

@end
