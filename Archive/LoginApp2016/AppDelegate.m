//
//  AppDelegate.m
//  LoginApp2016
//
//  Created by Darius Miliauskas on 04/05/16.
//  Copyright © 2016 Darius Miliauskas. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreMotion/CMMotionManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//static const NSTimeInterval accelerometerMin = 0.01;
//- (void)startUpdatesWithSliderValue:(int)sliderValue {
//    
//    // Determine the update interval
//    NSTimeInterval delta = 0.005;
//    NSTimeInterval updateInterval = accelerometerMin + delta * sliderValue;
//    
//    // Create a CMMotionManager
//    CMMotionManager *mManager = [(APLAppDelegate *)[[UIApplication sharedApplication] delegate] sharedManager];
//    APLAccelerometerGraphViewController * __weak weakSelf = self;
//    
//    // Check whether the accelerometer is available
//    if ([mManager isAccelerometerAvailable] == YES) {
//        // Assign the update interval to the motion manager
//        [mManager setAccelerometerUpdateInterval:updateInterval];
//        [mManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
//            [weakSelf.graphView addX:accelerometerData.acceleration.x y:accelerometerData.acceleration.y z:accelerometerData.acceleration.z];
//            [weakSelf setLabelValueX:accelerometerData.acceleration.x y:accelerometerData.acceleration.y z:accelerometerData.acceleration.z];
//        }];
//    }
//    
//    self.updateIntervalLabel.text = [NSString stringWithFormat:@"%f", updateInterval];
//}
//
//
//- (void)stopUpdates {
//    CMMotionManager *mManager = [(APLAppDelegate *)[[UIApplication sharedApplication] delegate] sharedManager];
//    if ([mManager isAccelerometerActive] == YES) {
//        [mManager stopAccelerometerUpdates];
//    }
//}

@end
