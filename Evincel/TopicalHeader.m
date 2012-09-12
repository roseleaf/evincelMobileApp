//
//  TopicalHeader.m
//  Evincel
//
//  Created by Rose CW on 9/11/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "TopicalHeader.h"

@implementation TopicalHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

+(TopicalHeader*)createHeader {
    TopicalHeader* header = [[TopicalHeader alloc]initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 100)];
    header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableHeader.png"]];
        
    
    header.headerLabel =
    [[UILabel alloc]
     initWithFrame:CGRectMake(10, 20, 300, 40)];
    header.headerLabel.textAlignment = UITextAlignmentCenter;
    header.headerLabel.textColor = [UIColor colorWithRed:187 green:169 blue:171 alpha:1.0];
    header.headerLabel.shadowColor = [UIColor brownColor];
    header.headerLabel.shadowOffset = CGSizeMake(0, 1);
    header.headerLabel.font = [UIFont boldSystemFontOfSize:22];
    header.headerLabel.backgroundColor = [UIColor clearColor];
    // Create header view and add label as a sub        [header addSubview:self.headerLabel];

    return header;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
