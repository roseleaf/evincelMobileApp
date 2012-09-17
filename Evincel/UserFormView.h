//
//  UserFormView.h
//  Evincel
//
//  Created by Rose CW on 9/16/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserFormView : UIScrollView <UITextFieldDelegate>
@property (strong)UITextField* username;
@property (strong)UITextField* email;
@property (strong)UITextField* password;
@property (strong)UITextField* password_confirmation;
@property (strong) UIButton* submitButton;
@property (strong) UIView* header;
@end
