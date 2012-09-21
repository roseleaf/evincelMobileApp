//
//  WebsiteViewController.m
//  Evincel
//
//  Created by Rose CW on 9/10/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "WebsiteViewController.h"
#import "TopicalHeader.h"
#import "Review.h"
#import "ReviewCell.h"
#import "ApplicationStore.h"
#import "AddReviewViewController.h"
#import "LoginViewController.h"
#import <RestKit/RestKit.h>

@interface WebsiteViewController ()
@property (strong)NSArray* reviews;
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

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"preview11.jpeg"]];    

    self.reviews = [self selectReviews];
    if (self.reviews.count == 0) {
        [self refreshReviews];
    };
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"preview11.jpeg"]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
}


-(void)refreshReviews{
    [ApplicationStore fetchReviews:^{
        self.reviews = [self selectReviews];
        [self.tableView reloadData];
    }];
}

-(NSArray*)selectReviews{
    NSManagedObjectContext* thisContext = [ApplicationStore context];
    
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Review" inManagedObjectContext:thisContext];
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"website_id==%@", [self.website valueForKey:@"website_id"]]];
    NSError* error = nil;
    NSArray* array = [[ApplicationStore context] executeFetchRequest:request error:&error];
    return array;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 290;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 200)];;
    header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableHeader.png"]];
    [header addSubview:[self backButton]];
    self.signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.signInButton addTarget:self action:@selector(showLogin) forControlEvents:UIControlEventTouchDown];
    [self.signInButton setTitle:@"Sign In to Add" forState:UIControlStateNormal];
    self.signInButton.frame = CGRectMake(188.0, 10.0, 125.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [self.signInButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addButton = [self setupAddButton];
    [header addSubview:self.addButton];
    [header addSubview:self.signInButton];
    
    if ([RKClient sharedClient].username) {
        self.signInButton.hidden = YES;
    } else {
        self.signInButton.hidden = NO;
    }
    UILabel* headerLabel =
    [[UILabel alloc]
     initWithFrame:CGRectMake(10, 60, 300, 40)];
    headerLabel.textAlignment = UITextAlignmentCenter;
    headerLabel.textColor = [UIColor colorWithRed:187 green:169 blue:171 alpha:1.0];
    headerLabel.shadowColor = [UIColor brownColor];
    headerLabel.shadowOffset = CGSizeMake(0, 1);
    headerLabel.font = [UIFont boldSystemFontOfSize:22];
    headerLabel.backgroundColor = [UIColor clearColor];
    NSError* error = NULL;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"http.*?//" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString* shortURL = [regex stringByReplacingMatchesInString:self.website.redirect_url options:0 range:NSMakeRange(0, [self.website.redirect_url length]) withTemplate:@""];
    headerLabel.text = [NSString stringWithFormat:@"Reviews for %@", shortURL.capitalizedString];
    [header addSubview:headerLabel];
    return header;
}

//UITableView Delegate Methods:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int count = [self.reviews count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ReviewCell alloc]init];
    }
    
    UIImage* rowBackground = [UIImage imageNamed:@"background.png"];    
    
    
    Review* currentReview = [self.reviews objectAtIndex:indexPath.row];

//    cell.rating.text = currentReview
    cell.heading.text = [NSString stringWithFormat:@"%d out of 5", currentReview.rating ];
    cell.info.text = currentReview.posted_by;
    cell.body.text = currentReview.comment;
    cell.info.backgroundColor = [UIColor clearColor];
    cell.body.backgroundColor = [UIColor clearColor];
    
    
    cell.heading.font = [UIFont systemFontOfSize:10];    
    cell.faviconView.image = self.website.image;
    
    UIImageView* cellImageView = [[UIImageView alloc]initWithImage:rowBackground];
//    UIImageView* pressedImageView = [[UIImageView alloc]initWithImage:pressedRowBackground];
    cell.selectedBackgroundView =cellImageView;
    cell.backgroundView = cellImageView;
    cell.userInteractionEnabled = NO;

    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self.view setNeedsDisplay];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(UIButton*)backButton{
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5.0, 10.0, 50.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return backButton;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIButton*)setupAddButton{
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton addTarget:self action:@selector(addReview) forControlEvents:UIControlEventTouchDown];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    self.addButton.frame = CGRectMake(270.0, 10.0, 40.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [self.addButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return self.addButton;
}



-(void)showLogin{
    LoginViewController* login = [LoginViewController new];
    login.wesiteListView = self;
    login.completionBlock = ^{self.signInButton.hidden = YES;
        self.addButton.hidden = NO;
    };
    
    [self.navigationController pushViewController:login animated:YES];
}
-(void)addReview{
    AddReviewViewController* arv = [AddReviewViewController new];
    arv.websiteListView = self;
    arv.website_id = self.website.website_id;
    arv.website_title = self.website.page_title;
    [self.navigationController pushViewController:arv animated:YES];
}
@end
