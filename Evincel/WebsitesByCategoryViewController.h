//
//  WebsitesByCategoryViewController.h
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebsitesByCategoryViewController : UITableViewController
@property (strong) NSDictionary* category;
-(void)websiteByCategoryFetcher;
-(id)initWithCategory:(NSDictionary*)category;
@end
