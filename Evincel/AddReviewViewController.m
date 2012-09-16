//
//  AddReviewViewController.m
//  Evincel
//
//  Created by Rose CW on 9/14/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "AddReviewViewController.h"
#import "ReviewFormView.h"
#import "ApplicationStore.h"
#import <RestKit/RestKit.h>

@interface AddReviewViewController () 
@property (strong)ReviewFormView* formView;
@end

@implementation AddReviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.formView = [ReviewFormView new];
    [self.formView.submitButton addTarget:self action:@selector(saveReview) forControlEvents:UIControlEventTouchDown];
    self.view = self.formView;
    
    [self.formView.backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
}

-(void)saveReview{
    NSEntityDescription* review = [NSEntityDescription entityForName:@"Review" inManagedObjectContext:[ApplicationStore context]];
    self.review = [[Review alloc]initWithEntity:review insertIntoManagedObjectContext:[ApplicationStore context]];

    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber* ratingNumber = [f numberFromString:self.formView.ratingString];
    [self.review setValue:ratingNumber forKey:@"rating"];
    [self.review setValue:@(self.website_id) forKey:@"website_id"];
    [self.review setValue:self.formView.commentField.text forKey:@"comment"];
    [self.review setValue:@"Evincel Mobile App" forKey:@"browser"];
    [self.review setValue:[RKClient sharedClient].username forKey:@"posted_by"];
    [self.review setValue:@"iOS" forKey:@"platform"];
    NSLog(@"The review:%@", self.review);
    [ApplicationStore saveReview:self.review];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.formView.commentField resignFirstResponder];
}


-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)toCategories{
    [self dismissModalViewControllerAnimated:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
