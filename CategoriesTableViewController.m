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
#import "Category.h"
#import <RestKit/RestKit.h>

#import "ApplicationStore.h"

@interface CategoriesTableViewController () <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, RKRequestDelegate, NSXMLParserDelegate> {
    NSArray* categoriesArray;
}
@property NSArray* categoriesArray;
@property UIImageView* header;
@property UIButton* backButton;
@property UIButton* addButton;
@property UIButton* signInButton;
@end



@implementation CategoriesTableViewController

//Initialization Methods:
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

        //[self categoryFetcher];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"preview11.jpeg"]];
    self.navigationController.navigationBarHidden = YES;
    self.categoriesArray = [Category allObjects];

    if (self.categoriesArray.count == 0) {
        [self refreshCategories];
    };
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
    //categoriesArray = [NSMutableArray new];

    // Preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

-(void)refreshCategories {
    NSLog(@"Refreshing!");
    [ApplicationStore fetchCategories:^{
        self.categoriesArray = [Category allObjects];
        [self.tableView reloadData];
    }];
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
     initWithFrame:CGRectMake(10, 60, 300, 40)];
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
    backButton.frame = CGRectMake(5.0, 10.0, 50.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.backButton = backButton;
    [view addSubview:self.backButton];
    
    UIButton* addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton addTarget:self action:@selector(dismissToHome) forControlEvents:UIControlEventTouchDown];
    [addButton setTitle:@"Add Website" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(188.0, 10.0, 125.0, 40.0);
    [addButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.addButton = addButton;
    [view addSubview:self.addButton];
    
    
    UIButton* signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signInButton addTarget:self action:@selector(dismissToHome) forControlEvents:UIControlEventTouchDown];
    [signInButton setTitle:@"Sign in to Add" forState:UIControlStateNormal];
    signInButton.frame = CGRectMake(188.0, 10.0, 125.0, 40.0);
    [signInButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signInButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.signInButton = signInButton;
    [view addSubview:self.signInButton];
    
    if ([RKClient sharedClient].username) {
        self.signInButton.hidden = YES;
    } else {
        self.signInButton.hidden = NO;
    }
    
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
    int count = [self.categoriesArray count];
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
    Category* currentCategory = [self.categoriesArray objectAtIndex:indexPath.row];    
    cell.primaryLabel.text = currentCategory.name;
    cell.subtextLabel.text = @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

        if (!currentCategory.cachedImage) {
            NSString* baseString = @"http://evincel.com";
            NSString* imageUrl = currentCategory.image;
            NSString* srcString = [baseString stringByAppendingString:imageUrl];
            
            NSURL *url = [NSURL URLWithString:srcString];
            NSData *srcData = [NSData dataWithContentsOfURL:url];
            currentCategory.cachedImage = [[UIImage alloc] initWithData:srcData];
        }
        

        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.topicImageView.image = currentCategory.cachedImage;
            [cell setNeedsLayout];
        });
    });
    
    
    [UIImage imageNamed:@"circles.png"];

    UIImageView* cellImageView = [[UIImageView alloc]initWithImage:rowBackground];
    UIImageView* pressedImageView = [[UIImageView alloc]initWithImage:pressedRowBackground];
    cell.backgroundView = cellImageView;
    cell.selectedBackgroundView =pressedImageView;

    
    cell.accessoryType = UITableViewCellAccessoryNone;
        [self.view setNeedsDisplay];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* category = [self.categoriesArray objectAtIndex:indexPath.row];

    WebsitesByCategoryViewController* wvc = [[WebsitesByCategoryViewController alloc]initWithCategory:category];
//    wvc.category = category;
    UINavigationController* navControl = [[UINavigationController alloc]initWithRootViewController:wvc];
    wvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self presentModalViewController:navControl animated:YES];

}




@end
