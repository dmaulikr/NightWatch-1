//
//  NWAppDelegate.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/22/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWAppDelegate.h"
#import "NWMainMenuController.h"

@implementation NWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    NWMainMenuController *rvc = [[[NWMainMenuController alloc]init]autorelease];
    UINavigationController *nav = [[[UINavigationController alloc]initWithRootViewController:rvc]autorelease];
    nav.navigationBarHidden = YES;
    
    self.window.rootViewController = nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
