//
//  CategoriesTableViewController.m
//  Evincel
//
//  Created by Rose CW on 9/7/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "CategoryTableViewCell.h"
#import <RestKit/RestKit.h>

@interface CategoriesTableViewController () <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, RKRequestDelegate, NSXMLParserDelegate> {
    NSMutableArray* categoriesArray;
}
@property UIImageView* header;
@property UIButton* backButton;
@end

@implementation CategoriesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self categoryFetcher];
        [self addBackButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.rowHeight = 100;
    categoriesArray = [NSMutableArray new];
    

    // Preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    self.header = [UIImageView new];
    self.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewSmaller.png"]];
    self.header.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/4.5);
    [self.view addSubview:self.header];
    
    
    UIView *containerView =
    [[UIView alloc]
      initWithFrame:CGRectMake(20, 300, 300, 60)]
     ;
    UILabel *headerLabel =
    [[UILabel alloc]
      initWithFrame:CGRectMake(100, 20, 300, 40)];
    headerLabel.text = NSLocalizedString(@"Categories", @"");
    headerLabel.textColor = [UIColor colorWithRed:187 green:169 blue:171 alpha:1.0];
    headerLabel.shadowColor = [UIColor brownColor];
    headerLabel.shadowOffset = CGSizeMake(0, 1);
    headerLabel.font = [UIFont boldSystemFontOfSize:22];
    headerLabel.backgroundColor = [UIColor clearColor];
    [containerView addSubview:headerLabel];
    self.tableView.tableHeaderView = containerView;
}


-(void)addBackButton{
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(dismissToHome) forControlEvents:UIControlEventTouchDown];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(105.0, 60.0, 100.0, 40.0);
    UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.backButton = backButton;
    [self.view addSubview:self.backButton];
}


-(void)dismissToHome{
    [self dismissModalViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [categoriesArray count];
    return count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    

    UIImage* rowBackground = [UIImage imageNamed:@"middleRow.png"];
    UIImage* pressedRowBackground = [UIImage imageNamed:@"pressedRow.png"];

    UIImageView* cellImageView = [[UIImageView alloc]initWithImage:rowBackground];
    UIImageView* pressedImageView = [[UIImageView alloc]initWithImage:pressedRowBackground];
    cell.backgroundView = cellImageView;
    cell.selectedBackgroundView =pressedImageView;
//    ((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = [categoriesArray objectAtIndex:indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
//    cell.backgroundColor = [UIColor redColor];
    
    NSLog(@"%@", categoriesArray);
    [self.view setNeedsDisplay];
    // Configure the cell...
    
    return cell;
}





-(void) categoryFetcher {
    //use restkit to grab the list of categories
    RKClient *client = [RKClient clientWithBaseURLString:@"http://evincel.com/"];
    
    client.requestQueue.requestTimeout = 10;
    client.cachePolicy = RKRequestCachePolicyNone;
    client.authenticationType = RKRequestAuthenticationTypeNone;
    
    [client get:@"/categories.json" delegate:self];
    [self.view setNeedsDisplay];
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{

    if (request.method == RKRequestMethodGET) {
        NSArray* parsedResponse = [response parsedBody:nil];
        //NSLog(@"%@", parsedResponse);

        
        for (NSDictionary* category in parsedResponse){
            NSString* categoryName = [category valueForKey:@"name"];
            [categoriesArray addObject:categoryName];

        }

        
        
        //example of how we parsed rss:
//        NSArray* rssChannelItemLevel = [[[rss valueForKey:@"rss"] valueForKey:@"channel"] valueForKey:@"item"];
//        for (NSDictionary* itemDictionary in rssChannelItemLevel){
//            RssItem* item = [RssItem new];
//            item.title = [itemDictionary valueForKey:@"title"];
//            item.link = [itemDictionary valueForKey:@"link"];
//            [rssItemArray addObject:item];
            
//        }
        [self.tableView reloadData];
    }
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
