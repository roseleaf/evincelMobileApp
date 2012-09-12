//
//  CategoriesTableViewController.m
//  Evincel
//
//  Created by Rose CW on 9/7/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "CategoryCell.h"
#import "TopicalHeader.h"
#import "WebsitesByCategoryViewController.h"
#import <RestKit/RestKit.h>

@interface CategoriesTableViewController () <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, RKRequestDelegate, NSXMLParserDelegate> {
    NSMutableArray* categoriesArray;
}
@property UIImageView* header;
@property UIButton* backButton;
@end



@implementation CategoriesTableViewController

//Initialization Methods:
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self categoryFetcher];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
 
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.rowHeight = 100;
    categoriesArray = [NSMutableArray new];
    // Preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
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
    headerLabel.text = NSLocalizedString(@"Categories", @"");
    headerLabel.textAlignment = UITextAlignmentCenter;
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
    [backButton addTarget:self action:@selector(dismissToHome) forControlEvents:UIControlEventTouchDown];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(105.0, 55.0, 100.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.backButton = backButton;
    [view addSubview:self.backButton];
    
    
    
    return view;
}



//rename goBack
-(void)dismissToHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source



//UITableView Delegate Methods:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [categoriesArray count];
    return count;

}
    //Create Each Custom Cell:
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CategoryCell alloc]init];
    }

    UIImage* rowBackground = [UIImage imageNamed:@"middleRow.png"];
    UIImage* pressedRowBackground = [UIImage imageNamed:@"pressedRow.png"];
    
    cell.primaryLabel.text = [[categoriesArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    cell.subtextLabel.text = @"";

    NSString* baseString = @"http://evincel.com";
    NSString* imageUrl = [[categoriesArray objectAtIndex:indexPath.row]valueForKey:@"image"];
    NSString* srcString = [baseString stringByAppendingString:imageUrl];
    
    NSURL *url = [NSURL URLWithString:srcString];
    NSData *srcData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:srcData];
    
    cell.topicImageView.image = image;
    [UIImage imageNamed:@"circles.png"];

    UIImageView* cellImageView = [[UIImageView alloc]initWithImage:rowBackground];
    UIImageView* pressedImageView = [[UIImageView alloc]initWithImage:pressedRowBackground];
    cell.backgroundView = cellImageView;
    cell.selectedBackgroundView =pressedImageView;

    
    cell.accessoryType = UITableViewCellAccessoryNone;
        [self.view setNeedsDisplay];
    
    return cell;
}





//RestKit Client Grabs the List of Categories:
-(void) categoryFetcher {
//    NSString* model = @"/websites.json?category_id=2";
//    [[RKClient sharedClient] get:model delegate:self];

    [[RKClient sharedClient] get:@"/categories.json" delegate:self];
}



- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    if (request.method == RKRequestMethodGET) {
        NSArray* parsedResponse = [response parsedBody:nil];

        
        for (NSDictionary* category in parsedResponse){
            [categoriesArray addObject:category];
        }

        [self.tableView reloadData];
    }
}





#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* category = [categoriesArray objectAtIndex:indexPath.row];

    WebsitesByCategoryViewController* wvc = [[WebsitesByCategoryViewController alloc]initWithCategory:category];
//    wvc.category = category;
    UINavigationController* navControl = [[UINavigationController alloc]initWithRootViewController:wvc];
    wvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self presentModalViewController:navControl animated:YES];
  
    

}









@end
