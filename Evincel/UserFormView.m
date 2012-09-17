//
//  UserFormView.m
//  Evincel
//
//  Created by Rose CW on 9/16/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "UserFormView.h"

@implementation UserFormView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 1.5);
        self.scrollEnabled = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        
        UILabel* label = [[UILabel alloc] init];
		label.frame = CGRectMake(10, 110, 300, 40);
		label.textAlignment = UITextAlignmentCenter;
        label.text = @"Create Your Account";
        label.backgroundColor = [UIColor clearColor];
		[self addSubview:label];
        
        UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 155, 180, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"Username:";
        self.username = [[UITextField alloc]initWithFrame:CGRectMake(80, 190, 180, 30)];
        self.username.delegate = self;
        self.username.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input.png"]];
        
        
        
        UILabel* emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 225, 180, 30)];
        emailLabel.text = @"Email:";
        emailLabel.backgroundColor = [UIColor clearColor];
        self.email = [[UITextField alloc]initWithFrame:CGRectMake(80, 260, 180, 30)];
        self.email.delegate = self;
        self.email.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input.png"]];
        
        
        
        UILabel* passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 295, 180, 30)];
        passwordLabel.text = @"Password:";
        passwordLabel.backgroundColor = [UIColor clearColor];
        self.password = [[UITextField alloc]initWithFrame:CGRectMake(80, 330, 180, 30)];
        self.password.delegate = self;
        self.password.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input.png"]];
        self.password.secureTextEntry = YES;

        
        UILabel* passwordConLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 365, 180, 30)];
        passwordConLabel.text = @"Password:";
        passwordConLabel.backgroundColor = [UIColor clearColor];
        self.password_confirmation = [[UITextField alloc]initWithFrame:CGRectMake(80, 400, 180, 30)];
        self.password_confirmation.delegate = self;
        self.password_confirmation.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input.png"]];
        self.password_confirmation.secureTextEntry = YES;
        
        
        self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.submitButton.frame = CGRectMake(80, 440, 100, 50);
        [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
        [self.submitButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:nameLabel];
        [self addSubview:emailLabel];
        [self addSubview:passwordLabel];
        [self addSubview:self.username];
        [self addSubview:self.email];
        [self addSubview:self.submitButton];
        [self addSubview:self.password];
        [self addSubview:self.password_confirmation];
        
        self.header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 100)];
        self.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableHeader.png"]];        
        
        UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        backButton.frame = CGRectMake(10.0, 10.0, 50.0, 40.0);
        
        [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.header addSubview:backButton];
        [self addSubview:self.header];
    }
    return self;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.username resignFirstResponder];
    [self.email resignFirstResponder];
    [self.password resignFirstResponder];
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
