//
//  ReviewCell.h
//  Evincel
//
//  Created by Rose CW on 9/12/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell
@property(nonatomic, retain)UILabel* rating;
@property(nonatomic, retain)UILabel* heading;
@property(nonatomic, retain)UILabel* info;
@property(nonatomic, retain)UITextView* body;
@property(nonatomic, retain)UIImageView* bgImageView;
@property(nonatomic, retain)UIImageView* faviconView;
@end
