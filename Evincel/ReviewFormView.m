//
//  ReviewFormView.m
//  Evincel
//
//  Created by Rose CW on 9/15/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "ReviewFormView.h"

@interface ReviewFormView (){
    NSArray* ratingValues;
}
@end

@implementation ReviewFormView
UILabel* label;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 1.5);
        self.scrollEnabled = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];

        ratingValues = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
        label = [[UILabel alloc] init];
		label.frame = CGRectMake(10, 110, 300, 40);
		label.textAlignment = UITextAlignmentCenter;
        label.text = @"Create Your Review";
        label.backgroundColor = [UIColor clearColor];
		[self addSubview:label];
        
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:ratingValues];
        segmentedControl.frame = CGRectMake(40, 310, 220, 50);
        segmentedControl.tintColor = [UIColor whiteColor];
        segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        segmentedControl.selectedSegmentIndex = 1;
        [segmentedControl addTarget:self
                             action:@selector(pickOne:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:segmentedControl];



        UILabel* ratingLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 275, 180, 30)];
        ratingLabel.backgroundColor = [UIColor clearColor];
        ratingLabel.textColor = [UIColor blackColor];
        ratingLabel.text = @"Rating:";

        UILabel* commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 155, 180, 30)];
        commentLabel.text = @"Comments:";
        commentLabel.backgroundColor = [UIColor clearColor];
        self.commentField = [[UITextField alloc]initWithFrame:CGRectMake(80, 190, 180, 80)];
        self.commentField.delegate = self;
        self.commentField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input.png"]];
        
        
        self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.submitButton.frame = CGRectMake(80, 380, 100, 50);
        [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        UIImage* buttonImage = [UIImage imageNamed:@"buttonShort.png"];
        [self.submitButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:ratingLabel];
        [self addSubview:commentLabel];
        [self addSubview:self.commentField];
        [self addSubview:self.submitButton];
        
        self.header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 100)];
        self.header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableHeader.png"]];
        [self.header addSubview:[self backButton]];
        

        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
        self.backButton.frame = CGRectMake(10.0, 10.0, 50.0, 40.0);

        [self.backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.header addSubview:self.backButton];
        [self addSubview:self.header];

    }
    return self;
}

-(void)pickOne:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.ratingString = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.commentField resignFirstResponder];
    return NO;
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
