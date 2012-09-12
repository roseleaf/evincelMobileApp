//
//  WebsiteViewController.m
//  Evincel
//
//  Created by Rose CW on 9/10/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "WebsiteViewController.h"
#import "TopicalHeader.h"


@interface WebsiteViewController ()

@end

@implementation WebsiteViewController

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
    
    UIScrollView *scrollView = [[UIScrollView alloc]   initWithFrame:self.view.frame];
    scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    scrollView.contentSize = CGSizeMake(320, 800);
    UIView* header = [TopicalHeader createHeader];
    [header addSubview:[self backButton]];
    [scrollView addSubview:header];
    UILabel* websiteName = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 100)];
    websiteName.text = self.website.page_title;
    [scrollView addSubview:websiteName];
    
    [self.view addSubview:scrollView];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(UIButton*)backButton{
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(105.0, 60.0, 100.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return backButton;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
