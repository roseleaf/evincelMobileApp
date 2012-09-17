//
//  User.m
//  Evincel
//
//  Created by Rose CW on 9/16/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "User.h"

@implementation User
@dynamic user_id;
@dynamic username;
@dynamic email;
@dynamic active;
@dynamic password;
@dynamic password_confirmation;


-(NSString*)password_confirmation{
    return self.password;
}
-(void)setPassword_confirmation:(NSString*)password{
    self.password = password;
}

@end