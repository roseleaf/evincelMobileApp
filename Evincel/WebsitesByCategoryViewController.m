//
//  WebsitesByCategoryViewController.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "WebsitesByCategoryViewController.h"
#import "WebsiteViewController.h"
#import "CategoryCell.h"
#import "TopicalHeader.h"
#import "WebsiteStore.h"
#import <RestKit/RestKit.h>


@interface WebsitesByCategoryViewController () <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, UINavigationControllerDelegate, RKRequestDelegate, NSXMLParserDelegate> {
    NSMutableArray* websitesArray;
}

@property UIButton* backButton;
@property UIImageView* header;
@end



@implementation WebsitesByCategoryViewController


-(id)initWithCategory:(NSDictionary*)category{
    self = [super init];
    if (self) {
        self.category = category;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[WebsiteStore sharedStore]websitesByCategoryFetcherWithID:[self.category objectForKey:@"id"] withBlock:^{
        [self.tableView reloadData];
    }];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.rowHeight = 100;
    
    [[WebsiteStore sharedStore]websitesByCategory:[self.category objectForKey:@"id"] withBlock:^(NSArray* websites){
        [self.tableView reloadData];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    self.header = [UIImageView new];
    self.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableHeader.png"]];
    self.header.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    [self.view addSubview:self.header];
    UILabel *headerLabel =
    [[UILabel alloc]
     initWithFrame:CGRectMake(10, 20, 300, 40)];
    headerLabel.textAlignment = UITextAlignmentCenter;
    headerLabel.text = [self.category valueForKey:@"name"];
    headerLabel.textColor = [UIColor colorWithRed:187 green:169 blue:171 alpha:1.0];
    headerLabel.shadowColor = [UIColor brownColor];
    headerLabel.shadowOffset = CGSizeMake(0, 1);
    headerLabel.font = [UIFont boldSystemFontOfSize:22];
    headerLabel.backgroundColor = [UIColor clearColor];
    
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];
    [view addSubview:self.header];
    [view addSubview:headerLabel];
    
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(dismissToCategories) forControlEvents:UIControlEventTouchDown];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(105.0, 60.0, 100.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backButton = backButton;
    [view addSubview:self.backButton];
    
    
    
    return view;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}



//UITableView Delegate Methods:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id catId = [self.category valueForKey:@"id"];
    NSArray* array = [[[WebsiteStore sharedStore]allWebsites] objectForKey:catId];
    
    int count = [array count];
    return count;
    NSLog(@"!!!! %d", count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CategoryCell alloc]init];
    }
    
    UIImage* rowBackground = [UIImage imageNamed:@"middleRow.png"];
    UIImage* pressedRowBackground = [UIImage imageNamed:@"pressedRow.png"];

    
    id catID = [self.category valueForKey:@"id"];
    NSArray* category = [[[WebsiteStore sharedStore]allWebsites]objectForKey:catID];
                         
                         
    Website* currentSite = [category objectAtIndex:indexPath.row];
    
    if (currentSite.page_title!=NULL) {
        cell.primaryLabel.text = currentSite.page_title;
    } else {
        cell.primaryLabel.text = currentSite.url;
    }
    
        
    cell.subtextLabel.text = currentSite.url;
    
    cell.faviconView.image = currentSite.image;
    
    UIImageView* cellImageView = [[UIImageView alloc]initWithImage:rowBackground];
    UIImageView* pressedImageView = [[UIImageView alloc]initWithImage:pressedRowBackground];
    cell.backgroundView = cellImageView;
    cell.selectedBackgroundView =pressedImageView;
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self.view setNeedsDisplay];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id catID = [self.category valueForKey:@"id"];
    NSArray* category = [[[WebsiteStore sharedStore]allWebsites]objectForKey:catID];
    Website* currentSite = [category objectAtIndex:indexPath.row];

    WebsiteViewController* websiteView = [WebsiteViewController new];
    websiteView.website = currentSite;

    [self.navigationController pushViewController:websiteView animated:YES];
}

-(void)dismissToCategories{
    [self dismissModalViewControllerAnimated:YES];
}

//Defaults:
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
