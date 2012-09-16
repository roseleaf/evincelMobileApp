//
//  AddReviewViewController.h
//  Evincel
//
//  Created by Rose CW on 9/14/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"
#import "Website.h"

@interface AddReviewViewController : UIViewController
@property (strong) Review* review;
@property (strong) NSNumber* website_id;
@property (nonatomic, retain) IBOutlet UITextField* commentLabel;
@property (strong) NSString* website_title;
//@property (strong) UI
@end
