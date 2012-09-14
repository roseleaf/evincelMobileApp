//
//  CategorStore.m
//  Evincel
//
//  Created by Rose CW on 9/13/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "CategoryStore.h"
#import "Category.h"

static RKObjectManager* categoryObjectManager;

@implementation CategoryStore
//+(CategoryStore*)sharedStore{
//    
//}
//-(NSMutableArray*)categories{
//    
//}
+(void)setUpCategoryStore{
    RKClient* categoryClient = [RKClient clientWithBaseURLString:@"http://evincel.com/"];
    categoryClient.username = @"rose";
    categoryClient.password = @"foobar";
    categoryObjectManager = [[RKObjectManager alloc] init];
    categoryObjectManager.client = categoryClient;
    
    [RKManagedObjectStore deleteStoreAtPath:@"categoryStore.sqlite3"];
    [RKManagedObjectStore deleteStoreAtPath:@"categoriesStore.sqlite3"];
    categoryObjectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"categoriesStore.sqlite3"];
    
    [self setupcategoryMapping];
}
+(void)setupcategoryMapping {
    RKManagedObjectMapping* categoryMapping = [RKManagedObjectMapping mappingForClass:[Category class] inManagedObjectStore:categoryObjectManager.objectStore];
    categoryMapping.objectClass = [Category class];
    [categoryMapping mapKeyPath:@"id" toAttribute:@"category_id"];
    [categoryMapping mapAttributes:@"name", nil];
    [categoryMapping mapAttributes:@"image", nil];
    categoryMapping.primaryKeyAttribute = @"category_id";
    
    [categoryObjectManager.mappingProvider addObjectMapping:categoryMapping];
    
    RKObjectMapping* serializationMapping = categoryMapping.inverseMapping;
    serializationMapping.rootKeyPath = @"category";
    [categoryObjectManager.mappingProvider setSerializationMapping:serializationMapping forClass:[Category class]];
    
    [categoryObjectManager.router routeClass:[Category class] toResourcePath:@"/categories.json"];
}




+(void)fetchCategories:(void(^)(void))completionBlock{
    [categoryObjectManager loadObjectsAtResourcePath:@"/categories.json" usingBlock:^(RKObjectLoader *loader) {
        loader.objectMapping = [categoryObjectManager.mappingProvider objectMappingForClass:[Category class]];
        
        loader.onDidLoadObjects = ^(NSArray* objects) {
            //if (completionBlock)
                completionBlock();
        };
        loader.onDidFailLoadWithError = ^(NSError* err) {
            NSLog(@"%@", err);
        };
    }];
}


@end
