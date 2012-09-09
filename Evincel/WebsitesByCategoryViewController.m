//
//  WebsitesByCategoryViewController.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "WebsitesByCategoryViewController.h"
#import "CategoryCell.h"
#import <RestKit/RestKit.h>


@interface WebsitesByCategoryViewController () <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, RKRequestDelegate, NSXMLParserDelegate> {
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
        self.tableView = [[UITableView alloc]init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        // Custom initialization
    }
    return self;
}


//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//        [self websiteByCategoryFetcher];
//    }
//    return self;
//}


-(void)viewWillAppear:(BOOL)animated{
    [self websiteByCategoryFetcher];
    
    [self.tableView reloadData];
}


-(void)loadView{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.rowHeight = 100;
    websitesArray = [NSMutableArray new];

//    [self websiteByCategoryFetcher];
//    [self.tableView reloadData];


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
     initWithFrame:CGRectMake(100, 20, 300, 40)];
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
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.backButton = backButton;
    [view addSubview:self.backButton];
    
    
    
    return view;
}




//UITableView Delegate Methods:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count = [websitesArray count];
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


    cell.primaryLabel.text = [[websitesArray objectAtIndex:indexPath.row] valueForKey:@"page_title"];
    
    cell.subtextLabel.text = [[websitesArray objectAtIndex:indexPath.row]valueForKey:@"url"];
    //fin in cell with data..
    
    
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


-(void)dismissToCategories{
    [self dismissModalViewControllerAnimated:YES];
}


//RestKit Client Grabs the List of Categories:
-(void) websiteByCategoryFetcher {
    RKClient *client = [RKClient clientWithBaseURLString:@"http://evincel.com/"];
    
    client.requestQueue.requestTimeout = 10;
    client.cachePolicy = RKRequestCachePolicyNone;
    client.authenticationType = RKRequestAuthenticationTypeNone;
    
    
    NSString* model = @"/websites.json?category_id=";

    id params = [self.category valueForKey:@"id"];
    NSString* getResourcePath = [model stringByAppendingFormat:@"%@", params];
 
    [client get:getResourcePath delegate:self];


}


- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    if (request.method == RKRequestMethodGET) {
        NSArray* parsedResponse = [response parsedBody:nil];
        NSLog(@"%@", parsedResponse);
        
        
        for (NSDictionary* website in parsedResponse){
            [websitesArray addObject:website];
        }
        
        [self.tableView reloadData];
    }
}



//Defaults:
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
