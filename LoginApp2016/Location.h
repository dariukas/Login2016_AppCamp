//
//  Location.h
//  LoginApp2016
//
//  Created by Kristina Šlekytė on 04/05/16.
//  Copyright © 2016 Darius Miliauskas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject <CLLocationManagerDelegate>
{
CLLocationManager *locationManager;
}

@end
