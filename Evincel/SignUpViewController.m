//
//  SignUpViewController.m
//  Evincel
//
//  Created by Rose CW on 9/16/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "SignUpViewController.h"
#import "UserFormView.h"
#import "User.h"
#import "ApplicationStore.h"

@interface SignUpViewController ()
@property (strong)User* user;
@property (strong)UserFormView* formView;
@end

@implementation SignUpViewController

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
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    UserFormView* form = [UserFormView new];
    self.formView = form;
    self.view = self.formView;
    
    UIView* header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 100)];
    header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableHeader.png"]];
    [header addSubview:[self backButton]];
    [self.view addSubview:header];
    [self.formView.submitButton addTarget:self action:@selector(saveUser) forControlEvents:UIControlEventTouchDown];
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
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)saveUser{
    NSEntityDescription* user = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[ApplicationStore context]];
    self.user = [[User alloc]initWithEntity:user insertIntoManagedObjectContext:[ApplicationStore context]];
    
    [self.user setValue:self.formView.username.text forKey:@"username"];
    [self.user setValue:self.formView.email.text forKey:@"email"];
    [self.user setValue:self.formView.password.text forKey:@"password"];
    [self.user setValue:self.formView.password_confirmation.text forKey:@"password_confirmation"];

    [self.user setValue:@1 forKey:@"active"];
    [ApplicationStore saveUser:self.user];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)showAlert{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Check your creds and try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
    [RKClient sharedClient].username = nil;
    [RKClient sharedClient].password = nil;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.formView.username resignFirstResponder];
    [self.formView.password resignFirstResponder];
    [self.formView.email resignFirstResponder];
}
@end
