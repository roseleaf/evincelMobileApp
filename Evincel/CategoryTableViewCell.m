//
//  EvincelTableViewCell.m
//  Evincel
//
//  Created by Rose CW on 9/8/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "CategoryTableViewCell.h"
@implementation CategoryTableViewCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = UITextAlignmentLeft;
        primaryLabel.font = [UIFont systemFontOfSize:14];
        subtextLabel = [[UILabel alloc]init];
        subtextLabel.textAlignment = UITextAlignmentLeft;
        subtextLabel.font = [UIFont systemFontOfSize:8];
        countLabel = [[UILabel alloc]init];
        countLabel.textAlignment = UITextAlignmentLeft;
        countLabel.font = [UIFont systemFontOfSize:8];
        bgImageView = [[UIImageView alloc]init];
        topicImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:subtextLabel];
        [self.contentView addSubview:countLabel];
        [self.contentView addSubview:bgImageView];
        [self.contentView addSubview:topicImageView];
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX+10 ,0, 50, 50);
    topicImageView.frame = frame;
    
    frame= CGRectMake(boundsX+70 ,5, 200, 25);
    primaryLabel.frame = frame;
    
    frame= CGRectMake(boundsX+70 ,30, 100, 15);
    subtextLabel.frame = frame;
    
    frame= CGRectMake(boundsX+270 ,30, 100, 15);
    countLabel.frame = frame;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
