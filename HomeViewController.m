//
//  HomeViewController.m
//  Evincel
//
//  Created by Rose CW on 9/7/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "HomeViewController.h"
#import "CategoriesTableViewController.h"
#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HomeViewController ()
@property UIImageView* header;
@property UIButton* searchButton;
@property UIButton* browseButton;
@property UIButton* signInButton;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        self.view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame] ];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        self.header = [UIImageView new];
        self.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header.png"]];
        self.header.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2.5);
        [self.view addSubview:self.header];
        [self addSearchButton];
        [self addBrowseButton];
        [self addSignInButton];
    }
    return self;
}

-(void)loadView{
    UIButton* searchButton = [[UIButton alloc]initWithFrame:CGRectMake(20, self.view.bounds.size.height/2, 200, 50)];
    searchButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"buttonLong.png"]];
    
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)dropDownClick {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Enter Your Search Term:" message:@"Enter Your Search Term" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
                                [textField setBackgroundColor:[UIColor whiteColor]];
                                [myAlertView addSubview:textField];
                                [myAlertView show];
}


-(void)addSearchButton{
    UIButton* searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton addTarget:self action:@selector(goToSearch) forControlEvents:UIControlEventTouchDown];
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(56.0, 200.0, 200.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonLong.png"];
    [searchButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.searchButton = searchButton;
    [self.view addSubview:self.searchButton];
}

-(void)addBrowseButton{
    UIButton* browseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [browseButton addTarget:self action:@selector(goToCategories) forControlEvents:UIControlEventTouchDown];
    [browseButton setTitle:@"Browse" forState:UIControlStateNormal];
    browseButton.frame = CGRectMake(56.0, 250.0, 200.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonLong.png"];
    [browseButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [browseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.browseButton = browseButton;
    [self.view addSubview:self.browseButton];
}
-(void)addSignInButton{
    UIButton* signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signInButton addTarget:self action:@selector(goToSignIn) forControlEvents:UIControlEventTouchDown];
    [signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
    signInButton.frame = CGRectMake(56.0, 300.0, 200.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonLong.png"];
    [signInButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signInButton = signInButton;
    [self.view addSubview:self.signInButton];
}


-(void)goToCategories{
    CategoriesTableViewController* categoriesTable = [CategoriesTableViewController new];
    [self.navigationController pushViewController:categoriesTable animated:YES];
}
-(void)goToSearch{
    SearchViewController* searchTable = [SearchViewController new];
    [self.navigationController pushViewController:searchTable animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
