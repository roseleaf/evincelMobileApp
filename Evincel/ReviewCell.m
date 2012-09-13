//
//  ReviewCell.m
//  Evincel
//
//  Created by Rose CW on 9/12/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "ReviewCell.h"

@implementation ReviewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.heading = [[UILabel alloc]init];
        self.heading.textAlignment = UITextAlignmentLeft;
        self.heading.font = [UIFont systemFontOfSize:34];
        self.rating = [[UILabel alloc]init];
        self.rating.textAlignment = UITextAlignmentLeft;
        self.rating.font = [UIFont systemFontOfSize:14];
        self.body = [[UITextView alloc]init];
        self.body.textAlignment = UITextAlignmentLeft;
        self.body.font = [UIFont systemFontOfSize:12];
        self.info = [[UILabel alloc]init];
        self.info.textAlignment = UITextAlignmentLeft;
        self.info.font = [UIFont systemFontOfSize:14];
        
        self.faviconView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.heading];
        [self.contentView addSubview:self.rating];
        [self.contentView addSubview:self.body];
        [self.contentView addSubview:self.info];
        [self.contentView addSubview:self.faviconView];
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    frame= CGRectMake(boundsX+10 ,10, 80, 80);
//    self.topicImageView.frame = frame;
    frame= CGRectMake(35, 30, 20, 20);
    self.faviconView.frame = frame;
    
    frame= CGRectMake(boundsX+70, 10, 200, 35);
    self.heading.frame = frame;
    self.heading.backgroundColor = [UIColor clearColor];
    self.heading.textColor = [UIColor brownColor];
    frame= CGRectMake(boundsX+70, 50, 200, 20);
    self.rating.frame = frame;
    self.rating.backgroundColor = [UIColor clearColor];
    self.rating.textColor = [UIColor blackColor];
    frame= CGRectMake(boundsX+70 ,70, 100, 15);
    self.info.frame = frame;
    self.info.textColor = [UIColor blackColor];
    frame= CGRectMake(boundsX+70 ,90, 160, 25);
    self.body.frame = frame;
    frame = self.body.frame;
    frame.size.height = self.body.contentSize.height;
    self.body.frame = frame;
    
    [self.body sizeToFit];
    self.body.userInteractionEnabled = NO;
    self.body.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
