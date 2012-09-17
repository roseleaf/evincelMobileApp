//
//  User.h
//  Evincel
//
//  Created by Rose CW on 9/16/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface User : NSManagedObject
@property (strong) NSNumber* user_id;
@property (strong) NSString* username;
@property (strong)NSString* email;
@property (strong) NSNumber* active;
@property (strong) NSString* password;
@property (strong) NSString* password_confirmation;
@end
