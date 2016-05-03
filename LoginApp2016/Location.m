//
//  Location.m
//  LoginApp2016
//
//  Created by Kristina Šlekytė on 04/05/16.
//  Copyright © 2016 Darius Miliauskas. All rights reserved.
//

#import "Location.h"

@implementation Location

-(instancetype) init {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    
    //NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    //self = locationManager;
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

@end
