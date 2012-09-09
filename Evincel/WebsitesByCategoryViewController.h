//
//  WebsitesByCategoryViewController.h
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Website.h"
#import <RestKit/RestKit.h>

@interface WebsitesByCategoryViewController : UITableViewController <RKRequestDelegate>

@property (strong) NSDictionary* category;
-(void)websiteByCategoryFetcher;
-(id)initWithCategory:(NSDictionary*)category;
- (void)request:(RKRequest*)request requestDidLoadResponse:(RKResponse*)response;
@end
