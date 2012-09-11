//
//  CategoryCell.h
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell
{
    UILabel* primaryLabel;
    UILabel* subtextLabel;
    UILabel* countLabel;
    UIImageView* faviconView;
    UIImageView* topicImageView;
}
@property(nonatomic,retain)UILabel* primaryLabel;
@property(nonatomic,retain)UILabel* subtextLabel;
@property(nonatomic,retain)UILabel* countLabel;
@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UIImageView *topicImageView;
@property(nonatomic,retain)UIImageView *faviconView;

@end
