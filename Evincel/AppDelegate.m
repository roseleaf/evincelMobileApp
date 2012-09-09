//
//  AppDelegate.m
//  Evincel
//
//  Created by Rose CW on 9/7/12.
//  Copyright (c) 2012 Rose Trujillo. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import <RestKit/RestKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [RKClient clientWithBaseURLString:@"http://evincel.com/"];
    [RKClient sharedClient].requestQueue.requestTimeout = 10;
    [RKClient sharedClient].cachePolicy = RKRequestCachePolicyNone;
    [RKClient sharedClient].authenticationType = RKRequestAuthenticationTypeNone;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [HomeViewController new];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
