//
//  ViewController.h
//  LoginApp2016
//
//  Created by Darius Miliauskas on 04/05/16.
//  Copyright © 2016 Darius Miliauskas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController
{
    CMMotionManager *motionManager;
}

@property (strong, nonatomic) IBOutlet UIImageView *evImageView;
@property (strong, nonatomic) IBOutlet UIImageView *animationView;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet UIView *circle;

@property (nonatomic, retain) NSString *eventsPath;
@property (nonatomic, retain) NSArray *content;
@property (nonatomic, retain) NSTimer *selectionTimer;
@property (nonatomic, retain) NSTimer *waitingTimer;
@property (nonatomic, retain) NSTimer *percentageTimer;
@property (nonatomic) int shakeCount;
@property (nonatomic) bool mode;
@property (nonatomic) bool ready;
@property (nonatomic) int percentage;

@property (readonly) CMMotionManager *motionManager;

@end

