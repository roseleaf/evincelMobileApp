//
//  TopicalHeader.h
//  Evincel
//
//  Created by Rose CW on 9/11/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicalHeader : UIView
@property (strong) UIImageView* header;
@property (strong) UILabel* headerLabel;
+(UIView*)createHeader;
@end
