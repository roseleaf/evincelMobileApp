//
//  SearchViewController.m
//  Evincel
//
//  Created by Rose CW on 9/7/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "SearchViewController.h"
#import "WebsiteViewController.h"
#import "WebsiteStore.h"
#import "TopicalHeader.h"
#import "CategoryCell.h"
#import <RestKit/RestKit.h>

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UISearchBarDelegate>

@property (strong)NSString* searchTerm;
@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
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

    headerLabel.text = @"Search Evincel";
    [header addSubview:headerLabel];
    
    UISearchBar* searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(60, 100, 190, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search All Sites";
    searchBar.backgroundImage = [UIImage imageNamed:@"buttonLong.png"];

    [header addSubview:searchBar];

    return header;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchTerm = searchBar.text;
    [[WebsiteStore sharedStore]websitesBySearchTerm:self.searchTerm withBlock:^{
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray* websites = [WebsiteStore sharedStore].results;
    if ([websites count]>0) {
        return [websites count];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CategoryCell alloc]init];
    }
    
    UIImage* rowBackground = [UIImage imageNamed:@"middleRow.png"];
    UIImage* pressedRowBackground = [UIImage imageNamed:@"pressedRow.png"];
    
    //extract data and populate cells
    if ([[WebsiteStore sharedStore].results count]>0){
    Website* currentSite = [[WebsiteStore sharedStore].results objectAtIndex:indexPath.row];
        if (currentSite.page_title!=NULL) {
            cell.primaryLabel.text = currentSite.page_title;
        } else {
            cell.primaryLabel.text = currentSite.url;
        }
        cell.subtextLabel.text = currentSite.url;
        cell.faviconView.image = currentSite.image;
        
        
    } else {
        cell.primaryLabel.text = @"No results!";
        cell.subtextLabel.font = [UIFont systemFontOfSize:10];
        cell.subtextLabel.text = @"Try a different term or submit a website";
    }
    

    
    UIImageView* cellImageView = [[UIImageView alloc]initWithImage:rowBackground];
    UIImageView* pressedImageView = [[UIImageView alloc]initWithImage:pressedRowBackground];
    cell.backgroundView = cellImageView;
    cell.selectedBackgroundView =pressedImageView;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self.view setNeedsDisplay];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        Website* currentSite = [[WebsiteStore sharedStore].results objectAtIndex:indexPath.row];
    
    WebsiteViewController* websiteView = [WebsiteViewController new];
    websiteView.website = currentSite;
    
    [self.navigationController pushViewController:websiteView animated:YES];
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
