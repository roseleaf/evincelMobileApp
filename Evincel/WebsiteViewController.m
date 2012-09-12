//
//  WebsiteViewController.m
//  Evincel
//
//  Created by Rose CW on 9/10/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "WebsiteViewController.h"
#import "TopicalHeader.h"
#import "ReviewStore.h"
#import "Review.h"
#import "CategoryCell.h"

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
    [[ReviewStore sharedStore]reviewsByWebsiteFetcherWithID:@(self.website.website_id) withBlock:^{
        [self.tableView reloadData];
    }];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.rowHeight = 100;
//    UIScrollView *scrollView = [[UIScrollView alloc]   initWithFrame:self.view.frame];
//    scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
//    scrollView.contentSize = CGSizeMake(320, 800);
//    UIView* header = [TopicalHeader createHeader];
//    [header addSubview:[self backButton]];
//    [scrollView addSubview:header];
//    UILabel* websiteName = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 100)];
//    websiteName.text = self.website.page_title;
//    [scrollView addSubview:websiteName];
//    [self.view addSubview:scrollView];

    

}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 200)];;
    header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableHeader.png"]];
    [header addSubview:[self backButton]];
    UILabel* headerLabel =
    [[UILabel alloc]
     initWithFrame:CGRectMake(10, 20, 300, 40)];
    headerLabel.textAlignment = UITextAlignmentCenter;
    headerLabel.textColor = [UIColor colorWithRed:187 green:169 blue:171 alpha:1.0];
    headerLabel.shadowColor = [UIColor brownColor];
    headerLabel.shadowOffset = CGSizeMake(0, 1);
    headerLabel.font = [UIFont boldSystemFontOfSize:22];
    headerLabel.backgroundColor = [UIColor clearColor];
    
    headerLabel.text = [NSString stringWithFormat:@"Reviews for %@", self.website.page_title];
    [header addSubview:headerLabel];
    return header;
}

//UITableView Delegate Methods:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int siteID = self.website.website_id;
    NSArray* array = [[[ReviewStore sharedStore]allReviews] objectForKey:@(siteID)];
    
    int count = [array count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CategoryCell alloc]init];
    }
    
    UIImage* rowBackground = [UIImage imageNamed:@"middleRow.png"];
    UIImage* pressedRowBackground = [UIImage imageNamed:@"pressedRow.png"];
    
    
    id siteID = @(self.website.website_id);
    NSArray* website = [[[ReviewStore sharedStore]allReviews]objectForKey:siteID];
    
    
    Review* currentReview = [website objectAtIndex:indexPath.row];
    
//    if (currentReview.page_title!=NULL) {
//        cell.primaryLabel.text = currentSite.page_title;
//    } else {
//        cell.primaryLabel.text = currentSite.url;
//    }
//    
    cell.primaryLabel.text = currentReview.browser;
    cell.subtextLabel.font = [UIFont systemFontOfSize:10];
    cell.subtextLabel.text = currentReview.comment;
    
    cell.faviconView.image = self.website.image;
    
    UIImageView* cellImageView = [[UIImageView alloc]initWithImage:rowBackground];
    UIImageView* pressedImageView = [[UIImageView alloc]initWithImage:pressedRowBackground];
    cell.backgroundView = cellImageView;
    cell.selectedBackgroundView =pressedImageView;
    
    
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
