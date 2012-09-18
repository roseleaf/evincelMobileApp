//
//  LoginViewController.h
//  Evincel
//
//  Created by Rose CW on 9/12/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebsiteViewController.h"

@interface LoginViewController : UIViewController
@property (strong) UITextField* usernameField;
@property (strong) UITextField* passwordField;
@property (weak) WebsiteViewController* wesiteListView;
@end
