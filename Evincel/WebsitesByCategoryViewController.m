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
#import "WebsiteStore.h"
#import "TFHpple.h"
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
        self.tableView = [[UITableView alloc]init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated{
 //   WebsiteStore* store = [WebsiteStore new];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        [store websiteByCategoryFetcherWithID:[self.category objectForKey:@"id"]];
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//            self.websitesArray = store.websites;
//            
//        });
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//            
//        });
//        
//    });

    
    websitesArray = [NSMutableArray new];
    [self websiteByCategoryFetcher];
}


-(void)loadView{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.rowHeight = 100;

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
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.backButton = backButton;
    [view addSubview:self.backButton];
    
    
    
    return view;
}




//UITableView Delegate Methods:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count = [websitesArray count];
    return count;
    NSLog(@"%d",count);
    NSLog(@"wwwwwwwwwwwww");
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CategoryCell alloc]init];
    }
    
    UIImage* rowBackground = [UIImage imageNamed:@"middleRow.png"];
    UIImage* pressedRowBackground = [UIImage imageNamed:@"pressedRow.png"];


    Website* currentSite = [websitesArray objectAtIndex:indexPath.row];
    
    if ([currentSite valueForKey:@"page_title"]!=NULL) {
        cell.primaryLabel.text = [currentSite valueForKey:@"page_title"];
    } else {
        cell.primaryLabel.text = [currentSite valueForKey:@"redirect_url"];
    }
    
        
    cell.subtextLabel.text = [currentSite valueForKey:@"redirect_url"];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
                   ^{
                       
                       cell.faviconView.image = [self hppleParseWithLink:[currentSite valueForKey:@"url"]];
                       
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [self.view setNeedsDisplay];}
                                      );
                   });
    
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
//    UINavigationController* nav = [[UINavigationController alloc]init];
    [self.navigationController pushViewController:websiteView animated:YES];
    
}

-(void)dismissToCategories{
    [self dismissModalViewControllerAnimated:YES];
}










//RestKit Client Grabs the List of Categories:
-(void) websiteByCategoryFetcher {
    NSString* model = @"/websites/category/";

    id params = [self.category objectForKey:@"id"];
    NSString* getResourcePath = [model stringByAppendingFormat:@"%@%@", params, @".json"];
    [[RKClient sharedClient] get:getResourcePath delegate:self];
}


- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    if (request.method == RKRequestMethodGET) {
        NSArray* parsedResponse = [response parsedBody:nil];
        
        for (NSDictionary* website in parsedResponse){
            [websitesArray addObject:website];
        }
        
        [self.tableView reloadData];
    }
}


//hpple grabs favicon
-(UIImage*) hppleParseWithLink:(NSURL *)url {
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    TFHpple *doc  = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *elements  = [doc searchWithXPathQuery:@"//link[@rel='icon']"]; //grab favicon
    
    if(![elements count]>=1){
        elements  = [doc searchWithXPathQuery:@"//link[@rel='shortcut icon']"]; //grab favicon
    }
    if([elements count]>=1){
        
        TFHppleElement *element = [elements objectAtIndex:0];
        NSString *srcString = [element objectForKey:@"href"]; //grab favicon src
        
        
        NSURL *url = [NSURL URLWithString:srcString];
        NSData *srcData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:srcData];
        
        NSLog(@"Element <src> parsed: %@",srcString);
        NSLog(@"%@", image);
        return image;
    }
    
    return nil;
}




//Defaults:
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
