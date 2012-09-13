//
//  LoginViewController.m
//  Evincel
//
//  Created by Rose CW on 9/12/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "LoginViewController.h"
#import "Review.h"
#import <RestKit/RestKit.h>

@interface LoginViewController () <RKRequestDelegate>

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//- (void)createObject {
//    Review* joeBlow = [Review new];
//    joeBlow.name = @"Joe Blow";
//    joeBlow.company = @"Two Toasters";
//    
//    // POST to /contacts
//    [ [RKClient sharedClient] postObject:joeBlow delegate:self];
//}

//    NSDictionary* params = [NSDictionary dictionaryWithObject:@"RestKit" forKey:@"Sender"];
//[ [RKClient sharedClient] post:@"/other.json" params:params delegate:self];
//if ([request isPOST]) {

// Handling POST /other.json
//if ([response isJSON]) {
//    NSLog(@"Got a JSON response back from our POST!");
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
