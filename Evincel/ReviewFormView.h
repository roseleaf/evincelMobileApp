//
//  ReviewFormView.h
//  Evincel
//
//  Created by Rose CW on 9/15/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"

@interface ReviewFormView : UIView <UITextFieldDelegate>
@property int website_id;
@property (strong) UIView* header;
@property (strong) UITextField* commentField;
@property (strong) NSString* ratingString;
@property (strong)UIButton* submitButton;
@property (strong)UIButton* backButton;

@property (nonatomic,retain) NSMutableArray *radioButtons;

@end
