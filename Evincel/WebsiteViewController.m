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
#import "ReviewCell.h"

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

    

    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.rowHeight = 100;
  
    [[ReviewStore sharedStore]reviewsByWebsite: @(self.website.website_id) WithBlock:^(NSArray* reviews){
        
        [self.tableView reloadData];
    }];

}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
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
    NSArray* array = [[ReviewStore sharedStore]allReviews];
    
    int count = [array count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ReviewCell alloc]init];
    }
    
    UIImage* rowBackground = [UIImage imageNamed:@"background.png"];    
    
    NSArray* website = [[ReviewStore sharedStore]allReviews];
    
    
    Review* currentReview = [website objectAtIndex:indexPath.row];

//    cell.rating.text = currentReview
    cell.heading.text = currentReview.comment;
    cell.info.text = currentReview.browser;
    cell.body.text = currentReview.comment;
    
    
    cell.heading.font = [UIFont systemFontOfSize:10];    
    cell.faviconView.image = self.website.image;
    
    UIImageView* cellImageView = [[UIImageView alloc]initWithImage:rowBackground];
//    UIImageView* pressedImageView = [[UIImageView alloc]initWithImage:pressedRowBackground];
    cell.selectedBackgroundView =cellImageView;
    cell.backgroundView = cellImageView;
    
    
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
