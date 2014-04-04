//
//  SSAppDelegate.h
//  Clock
//
//  Created by Scott on 28/09/2013.
//  Copyright (c) 2013 ScottSherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
#import "Countly.h"
#import "Appsee/Appsee.h"
#import "Amplitude.h"
#import "Analytics/Analytics.h"
#import "TSTapstream.h"

@interface SSAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
