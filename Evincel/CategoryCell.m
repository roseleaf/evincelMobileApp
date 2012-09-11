//
//  CategoryCell.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
        self.primaryLabel = [[UILabel alloc]init];
        self.primaryLabel.textAlignment = UITextAlignmentLeft;
        self.primaryLabel.font = [UIFont systemFontOfSize:24];
        self.subtextLabel = [[UILabel alloc]init];
        self.subtextLabel.textAlignment = UITextAlignmentLeft;
        self.subtextLabel.font = [UIFont systemFontOfSize:14];
//        self.countLabel = [[UILabel alloc]init];
//        self.countLabel.textAlignment = UITextAlignmentLeft;
        self.countLabel.font = [UIFont systemFontOfSize:8];
        self.topicImageView = [[UIImageView alloc]init];
        self.faviconView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.faviconView];
        [self.contentView addSubview:self.primaryLabel];
        [self.contentView addSubview:self.subtextLabel];
        [self.contentView addSubview:self.countLabel];
        [self.contentView addSubview:self.topicImageView];
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    frame= CGRectMake(boundsX+10 ,10, 80, 80);
    self.topicImageView.frame = frame;
    frame= CGRectMake(15, 25, 40, 40);
    self.faviconView.frame = frame;
    
    frame= CGRectMake(boundsX+100 ,10, 200, 35);
    self.primaryLabel.frame = frame;
    self.primaryLabel.backgroundColor = [UIColor clearColor];
    self.primaryLabel.textColor = [UIColor brownColor];
    frame= CGRectMake(boundsX+100, 50, 200, 20);
    self.subtextLabel.frame = frame;
    self.subtextLabel.backgroundColor = [UIColor clearColor];
    self.subtextLabel.textColor = [UIColor blackColor];
//    frame= CGRectMake(boundsX+70 ,30, 100, 15);
//    self.subtextLabel.frame = frame;
    
//    frame= CGRectMake(boundsX+270 ,30, 100, 15);
//    self.countLabel.frame = frame;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


