//
//  AddWebsiteViewController.h
//  Evincel
//
//  Created by Rose CW on 10/2/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Website.h"
#import "WebsiteViewController.h"

@interface AddWebsiteViewController : UIViewController
@property Website* website;
@property (nonatomic) IBOutlet UITextField* urlField;
@property (weak) WebsiteViewController* websiteView;
@end
