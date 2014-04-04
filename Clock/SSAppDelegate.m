//
//  SSAppDelegate.m
//  Clock
//
//  Created by Scott on 28/09/2013.
//  Copyright (c) 2013 ScottSherwood. All rights reserved.
//

#import "SSAppDelegate.h"

@implementation SSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Google Analytics
    // 1
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // 2
    [[GAI sharedInstance].logger setLogLevel:kGAILogLevelVerbose];
    
    // 3
    [GAI sharedInstance].dispatchInterval = 20;
    
    // 4
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-11480823-14"];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Google Analytics" message:@"With your permission usage information will be collected to improve the application." delegate:self cancelButtonTitle:@"Opt Out" otherButtonTitles:@"Opt In", nil];
    [av show];
    
    //Flurry
    [Flurry startSession:@"H5XNW2DPTTW76PT7CFHG"];
    [Flurry setCrashReportingEnabled:YES];
    
    //Countly
    [[Countly sharedInstance] start:@"8c3fd86da1ac2be9629ab36e2dc146f6f40859ae" withHost:@"http://www.seotallica.com"];
    
    //Appsee
    [Appsee start:@"8c1307abfe3b4250a3a5ac78044d06fc"];
    
    //Amplitude
    [Amplitude initializeApiKey:@"edc512b0a6921308206a7d44236b4837"];
    
    //Segment.io
    [Analytics debug:YES];
    [Analytics initializeWithSecret:@"h5j1mpwxbt"];
    
    //Tapstream
    TSConfig *config = [TSConfig configWithDefaults];
    [TSTapstream createWithAccountName:@"t2omedia" developerSecret:@"M1lksuRGQyyPzMrPIOMBQg" config:config];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [[GAI sharedInstance] setOptOut:YES];
            break;
        case 1:
            [[GAI sharedInstance] setOptOut:NO];
            break;
            
        default:
            break;
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
