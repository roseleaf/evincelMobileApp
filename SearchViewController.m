//
//  SearchViewController.m
//  Evincel
//
//  Created by Rose CW on 9/7/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//
#import "SearchViewController.h"
#import "WebsiteViewController.h"
#import "TopicalHeader.h"
#import "CategoryCell.h"
#import "ApplicationStore.h"
#import "Website.h"
#import <RestKit/RestKit.h>


@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UISearchBarDelegate>
@property (strong)NSArray* websitesArray;
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
    self.websitesArray = [NSArray new];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"preview11.jpeg"]];
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"preview11.jpeg"]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
}

-(void)refreshWebsites{
    NSLog(@"Refreshing Websites");
    [ApplicationStore fetchWebsites:^{
        self.websitesArray = [self selectWebsites];
        [self.tableView reloadData];
    }];
}

-(NSArray*)selectWebsites{
    NSManagedObjectContext* thisContext = [ApplicationStore context];
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Website" inManagedObjectContext:thisContext];
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
//    [request setPredicate:[NSPredicate predicateWithFormat: @"page_title LIKE %@ OR url LIKE %@ OR page_title CONTAINS %@", self.searchTerm, self.searchTerm, self.searchTerm]];
    [request setPredicate:[NSPredicate predicateWithFormat: @"page_title LIKE[cd] %@ || page_title CONTAINS[cd] %@ || url LIKE[cd] %@", self.searchTerm, self.searchTerm, self.searchTerm]];
    
    NSError* error = nil;
    NSArray* array = [[ApplicationStore context] executeFetchRequest:request error:&error];
    return array;
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
    UILabel* termLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 22)];
    termLabel.textAlignment = UITextAlignmentCenter;
    termLabel.textColor = [UIColor colorWithRed:187 green:169 blue:171 alpha:1.0];
    termLabel.font = [UIFont systemFontOfSize:10];
    termLabel.backgroundColor = [UIColor clearColor];
    termLabel.lineBreakMode = UILineBreakModeWordWrap;
    termLabel.numberOfLines = 0;
    if (self.searchTerm) {
        termLabel.text = [NSString stringWithFormat: @"\"%@\" results",self.searchTerm ];
    }
    
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
    [header addSubview:termLabel];
    
    UISearchBar* searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(60, 60, 190, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search All Sites";
    searchBar.backgroundImage = [UIImage imageNamed:@"shadowbar.png"];

    [header addSubview:searchBar];

    return header;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchTerm = searchBar.text;
    [self refreshWebsites];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.websitesArray count]>0) {
        return [self.websitesArray count];
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
    if ([self.websitesArray count]>0){
    Website* currentSite = [self.websitesArray objectAtIndex:indexPath.row];
        if (currentSite.page_title!=NULL) {
            cell.primaryLabel.text = currentSite.page_title;
        } else {
            cell.primaryLabel.text = currentSite.url;
        }
        cell.subtextLabel.text = currentSite.url;
        cell.faviconView.image = currentSite.image;
        cell.faviconView.image = [self getFaviconForSite:currentSite];

        
        
    } else {
        cell.primaryLabel.text = @"No results!";
        cell.subtextLabel.font = [UIFont systemFontOfSize:10];
        cell.subtextLabel.text = @"Try a different term";
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
        Website* currentSite = [self.websitesArray objectAtIndex:indexPath.row];
    
    WebsiteViewController* websiteView = [WebsiteViewController new];
    websiteView.website = currentSite;
    
    [self.navigationController pushViewController:websiteView animated:YES];
}

-(UIImage*)getFaviconForSite:(Website*)website{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http.*?//" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString* baseDomain = [regex stringByReplacingMatchesInString:website.url options:0 range:NSMakeRange(0, [website.url length]) withTemplate:@""];
    NSURL* faviconPath = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/s2/favicons?domain=%@", baseDomain]];
    NSData* data = [NSData dataWithContentsOfURL:faviconPath];
    return [UIImage imageWithData:data];
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
