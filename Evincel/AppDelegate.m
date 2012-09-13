//
//  AppDelegate.m
//  Evincel
//
//  Created by Rose CW on 9/7/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "WebsitesByCategoryViewController.h"
#import "WebsiteViewController.h"
#import "CategoriesTableViewController.h"
#import <RestKit/RestKit.h>
#import "WebsiteStore.h"
#import "ReviewStore.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    RKLogInitialize();
    RKLogConfigureFromEnvironment();
    
    [RKClient clientWithBaseURLString:@"http://evincel.com/"];
    [RKClient sharedClient].requestQueue.requestTimeout = 10;
    [RKClient sharedClient].cachePolicy = RKRequestCachePolicyNone;
    [RKClient sharedClient].authenticationType = RKRequestAuthenticationTypeNone;
    
    

    
    
    [WebsiteStore setupWebsiteStore];
    [ReviewStore setupReviewStore];
    UINavigationController* navControl = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = navControl;
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
