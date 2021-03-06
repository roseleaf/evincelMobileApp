//
//  LoginViewController.m
//  Evincel
//
//  Created by Rose CW on 9/12/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "LoginViewController.h"
#import "Review.h"
#import "HomeViewController.h"
#import "SignUpViewController.h"
#import <RestKit/RestKit.h>

@interface LoginViewController () <RKRequestDelegate, UITextFieldDelegate>

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    UIView* header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 100)];
    header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableHeader.png"]];
    [header addSubview:[self backButton]];
    [self.view addSubview:header];
    self.usernameField = [[UITextField alloc]initWithFrame:CGRectMake(50, 110, 200, 25)];
    self.usernameField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input.png"]];
    self.usernameField.placeholder = @"Username";
    [self.view addSubview:self.usernameField];
    self.passwordField = [[UITextField alloc]initWithFrame:CGRectMake(50, 160, 200, 25)];
    self.passwordField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input.png"]];
    self.passwordField.placeholder = @"Password";
    self.passwordField.secureTextEntry = YES;
    self.passwordField.delegate = self;

    [self.view addSubview:self.passwordField];
    UIButton* submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchDown];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(75.0, 190.0, 100.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [submitButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    [self.view addSubview:[self signUpButton]];
}
-(UIButton*)backButton{
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(10.0, 10.0, 50.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return backButton;
}
-(UIButton*)signUpButton{
    UIButton* signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchDown];
    [signUpButton setTitle:@"Sign Up!" forState:UIControlStateNormal];
    signUpButton.frame = CGRectMake(75.0, 250.0, 100.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [signUpButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return signUpButton;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)signUp{
    SignUpViewController* signUp = [SignUpViewController new];
    [self.navigationController pushViewController:signUp animated:YES];
}



-(void)signIn {
    [RKClient sharedClient].username = self.usernameField.text;
    [RKClient sharedClient].password= self.passwordField.text;
    NSString* base = [NSString stringWithFormat:@"http://evincel.com"];     [RKClient sharedClient].baseURL = [RKURL URLWithBaseURLString:base];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString* resourcePath = @"/reviews.json";
        [[RKClient sharedClient]get:resourcePath usingBlock:^(RKRequest* request){
            request.onDidLoadResponse = ^(RKResponse* response){
                if (response.statusCode == 401) {
                    //                    request.onDidFailLoadWithError= ^(NSError* error){
                    NSLog(@"error:%d", response.statusCode);
                    [self showAlert];
                } else {
                    [self parseRKResponse:response];
                    self.completionBlock();
                }
            };
            request.onDidFailLoadWithError = ^(NSError* error){
                [self showAlert];
            };
        }];
    });
    
    
}

-(void)parseRKResponse:(RKResponse*) response{
    id parsedResponse = [response parsedBody:nil];
    if (parsedResponse) {

        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showAlert];
    }
}

-(void)showAlert{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Check your creds and try again or sign up!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
    [RKClient sharedClient].username = nil;
    [RKClient sharedClient].password = nil;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.passwordField resignFirstResponder];
    [self signIn];
    return NO;
}


@end
