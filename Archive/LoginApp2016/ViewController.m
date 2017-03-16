//
//  ViewController.m
//  LoginApp2016
//
//  Created by Darius Miliauskas on 04/05/16.
//  Copyright © 2016 Darius Miliauskas. All rights reserved.
//

#import "ViewController.h"
#import "Location.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize eventsPath;
@synthesize content;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Starting!");
    self.shakeCount = 0;
    self.percentage = 0;
    self.ready = false;
    self.mode = false;//selection mode by default
    
    eventsPath = [NSString stringWithFormat:@"%@/Events", [[NSBundle mainBundle] resourcePath]];
    content = [self listFileAtPath:eventsPath];
    // self.evImageView.image = [UIImage imageNamed:@"myImageName"];
    self.evImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", eventsPath, content[0]]];
    //error jeigu tusti
    
    //Location *location = [[Location alloc] init];
//    [motionManager startDeviceMotionUpdates];
    [self motion];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(BOOL)shouldAutorotate
//{
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    if (orientation != UIInterfaceOrientationUnknown) [self resetTabBar];
//    NSLog(@"Orientation changed!");
//    return YES;
//}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    // Return a bitmask of supported orientations. If you need more,
//    // use bitwise or (see the commented return).
//    return UIInterfaceOrientationMaskPortrait;
//    // return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
//}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait ;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Do view manipulation here.
    [self removeBorderFrom:self.evImageView];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self becomeFirstResponder];
    self.evImageView.frame = self.view.frame;
    
    [motionManager startDeviceMotionUpdates];
    
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [motionManager stopDeviceMotionUpdates];
    [super viewWillDisappear:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        if (self.mode) {
            //infection mode
            self.shakeCount += 1;
            [self resetWaiting:self.waitingTimer];
            
            //[self playDiceAnimation];
            
            if (self.ready) {
                [self playInfectionAnimation];
                self.percentageLabel = [[UILabel alloc] init];
                [self.percentageLabel setFrame:CGRectMake(20,20,400,400)];
                self.percentageLabel.backgroundColor=[UIColor clearColor];
                self.percentageLabel.textColor=[UIColor greenColor];
                [self.percentageLabel setFont:[UIFont systemFontOfSize:72]];
                self.percentageLabel.textAlignment = NSTextAlignmentCenter;
                self.percentageLabel.userInteractionEnabled=YES;
                self.percentageLabel.text= [NSString stringWithFormat:@"%d m", self.percentage];
                self.percentageLabel.center = self.view.center;
                [self.view addSubview:self.percentageLabel];
                self.percentageTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCount:) userInfo:nil repeats: YES];
                self.ready = false;
            }
            
            
        } else {
            //selection mode
            [self resetSelection:self.selectionTimer];
            //[self perform];
            
            [self playDiceAnimation];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [UIView transitionWithView:self.view
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    [self.animationView removeFromSuperview];
                                   // [self.view addSubview:animationView];
                                }
                                completion:NULL];
                
                
                  self.evImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", eventsPath, [content objectAtIndex: [self getRandomBetween:1 and:(int)content.count]]]];
            });
            
        }
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self];
        NSLog(@"I'm shaking!");
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{ return YES;
}

-(void) playDiceAnimation {
    
    self.animationView = [[UIImageView alloc] initWithFrame:self.view.frame];
    NSString *diceAnimationPath = [NSString stringWithFormat:@"%@/DiceAnimation/s", [[NSBundle mainBundle] resourcePath]];
    self.animationView.image = [UIImage animatedImageNamed:diceAnimationPath duration:1.5f];
    
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        //[self.evImageView removeFromSuperview];
                        [self.view addSubview:self.animationView];
                    }
                    completion:NULL];
}

-(void) playInfectionAnimation {
    
    self.animationView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    NSString *diceAnimationPath = [NSString stringWithFormat:@"%@/InfectionAnimation/s", [[NSBundle mainBundle] resourcePath]];
//    self.animationView.image = [UIImage animatedImageNamed:diceAnimationPath duration:5.0f];
    self.animationView.backgroundColor = [[UIColor colorWithRed:0.89 green:0.42 blue:0.42 alpha:1.0] colorWithAlphaComponent:0.6];
    
    [self circleAnimation];
    
    
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        //[self.evImageView removeFromSuperview];
                        [self.view addSubview:self.animationView];
                    }
                    completion:NULL];
}

- (void)perform {
    CGPoint point0 = self.evImageView.layer.position;
    CGPoint point1 = { point0.x + 50, point0.y };
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anim.fromValue    = @(point0.x);
    anim.toValue  = @(point1.x);
    anim.duration   = 1.5f;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // First we update the model layer's property.
    self.evImageView.layer.position = point1;
    
    // Now we attach the animation.
    [self.evImageView.layer  addAnimation:anim forKey:@"position.x"];
}


-(NSArray *)listFileAtPath:(NSString *)path
{
    //-----> LIST ALL FILES <-----//
    NSLog(@"LISTING ALL FILES FOUND");
    
    int count;
    
    //[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png", [[NSBundle mainBundle] resourcePath], imgName]];
    //NSString *path = [NSString stringWithFormat:@"%@/Events", [[NSBundle mainBundle] resourcePath]];
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
    }
    return directoryContent;
}


-(int) getRandomBetween: (int) min and: (int) max
{
    return rand() % (max - min) + min;
}

-(void)onTick:(NSTimer *)timer {
    [self addBorderTo: self.evImageView];
    self.ready = true;
}

-(void)expires:(NSTimer *)timer {
    NSLog(@"Detected %d", self.shakeCount);
    self.shakeCount = 0;
    self.percentage = 0;
    [self.percentageTimer invalidate];
    [self removeBorderFrom:self.evImageView];
    [self.percentageLabel removeFromSuperview];
    [self.animationView removeFromSuperview];
    [self.circle removeFromSuperview];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//     [UIView transitionWithView:self.view
//     duration:0.5
//     options:UIViewAnimationOptionTransitionCrossDissolve
//     animations:^{
//     [self.animationView removeFromSuperview];
//     // [self.view addSubview:animationView];
//     }
//     completion:NULL];
     self.evImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", eventsPath, [content objectAtIndex: [self getRandomBetween:1 and:(int)content.count]]]];
//     });
}

-(void)updateCount:(NSTimer *)timer {
    self.percentage +=20;
    self.percentageLabel.text= [NSString stringWithFormat:@"%d m", self.percentage];
}


-(void) addBorderTo: (UIImageView *) imageView
{
    self.mode = true; //start shaking mode
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 8.0;
    imageView.layer.borderWidth = 20.0f;
    imageView.layer.borderColor = [UIColor colorWithRed:0.89 green:0.42 blue:0.42 alpha:1.0].CGColor;
}

-(void) removeBorderFrom: (UIImageView *) imageView
{
    self.mode = false;//start selection mode
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 8.0;
    imageView.layer.borderWidth = 0.0f;;
    imageView.layer.borderColor = [UIColor colorWithRed:0.89 green:0.42 blue:0.42 alpha:1.0].CGColor;
}


-(void) resetSelection:(NSTimer *)timer{
    [self.selectionTimer invalidate];
    self.selectionTimer = [NSTimer scheduledTimerWithTimeInterval: 6.0
                                                  target: self
                                                selector:@selector(onTick:)
                                                userInfo: nil repeats:NO];
}

-(void) resetWaiting:(NSTimer *)timer{
    [self.waitingTimer invalidate];
    self.waitingTimer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                                         target: self
                                                       selector:@selector(expires:)
                                                       userInfo: nil repeats:NO];
}


-(void) circleAnimation {
// Create a view with a corner radius as the circle
self.circle = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
[self.circle.layer setCornerRadius:self.circle.frame.size.width / 2];
    self.circle.center = self.view.center;
[self.circle setBackgroundColor:[UIColor redColor]];
[self.view addSubview:self.circle];

[UIView animateWithDuration:10 animations:^{
    
    // Animate it to double the size
    const CGFloat scale = 2;
    [self.circle setTransform:CGAffineTransformMakeScale(scale, scale)];
}];
}

//- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
//    // Use a basic low-pass filter to keep only the gravity component of each axis.
//    accelX = (acceleration.x * kFilteringFactor) + (accelX * (1.0 - kFilteringFactor));
//    accelY = (acceleration.y * kFilteringFactor) + (accelY * (1.0 - kFilteringFactor));
//    accelZ = (acceleration.z * kFilteringFactor) + (accelZ * (1.0 - kFilteringFactor));
//    
//    float accelerationThreshold = 1.01; // or whatever is appropriate - play around with different values
//    
//    if (fabs(accelX) > accelerationThreshold || fabs(accelY) > accelerationThreshold || fabs(accelZ) > accelerationThreshold) {
//        [self.soundPlayer play];
//        accelX = accelY = accelZ = 0;
//        accelerometerActive = NO;
//        accelerometer.delegate = nil;
//        accelerometer = nil;
//    }
//}

//Pragma MotionManager
-(CMMotionManager *) motionManager
{
    if(!motionManager) motionManager = [[CMMotionManager alloc] init];
    return motionManager;
}

-(void) motion {
    NSLog(@"Motion");
//    // Set the update frequency
//    motionManager.deviceMotionUpdateInterval = 1.0/60.0;
//    // Setup the update queue
//    void (^handler)(CMDeviceMotion *, NSError *);
//    
//    handler = ^(CMDeviceMotion *devMotion, NSError *error)
//    {
//        CMAttitude *currentAttitude = devMotion.attitude;
//        double verticalAxis = currentAttitude.roll*180/M_PI;
//        double lateralAxis = currentAttitude.pitch*180/M_PI;
//        double longitudinalAxis = currentAttitude.yaw*180/M_PI;
//        NSLog(@"Motion: %f", verticalAxis);
//    };
//    [motionManager startDeviceMotionUpdatesToQueue: [NSOperationQueue currentQueue] withHandler: handler];
    
    
    
    void (^handler2)(CMAccelerometerData *, NSError *) = ^(CMAccelerometerData *data, NSError *error)
    {
        CMAcceleration acceleration = [data acceleration];

        NSLog(@"Motion: %f", acceleration.x);
        NSLog(@"Motion: %f", acceleration.y);
    };
;
    
    if (motionManager.accelerometerAvailable) {
        motionManager.accelerometerUpdateInterval = 0.01;
        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:handler2];
    }
    
   //http://nshipster.com/cmdevicemotion/
    //http://www.techrepublic.com/blog/software-engineer/motion-events-part-2-core-motion/
    //https://wwwbruegge.in.tum.de/lehrstuhl_1/home/98-teaching/tutorials/505-sgd-ws13-tutorial-core-motion
    
//    if motionManager.accelerometerAvailable {
//
//        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
//            [weak self] (data: CMAccelerometerData?, error: NSError?) in
//            if let acceleration = data?.acceleration {
//                let rotation = atan2(acceleration.x, acceleration.y) - M_PI
//                self?.imageView.transform = CGAffineTransformMakeRotation(CGFloat(rotation))
//            }
//        }
//    }

}



@end
