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
    
    eventsPath = [NSString stringWithFormat:@"%@/Events", [[NSBundle mainBundle] resourcePath]];
    
    content = [self listFileAtPath:eventsPath];
   // self.evImageView.image = [UIImage imageNamed:@"myImageName"];
    self.evImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", eventsPath, content[0]]];
    //error jeigu tusti
    [self reset:self.timer];
    
    Location *location = [[Location alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self becomeFirstResponder];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [self reset:self.timer];
        [self perform];
        self.evImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", eventsPath, content[1]]];
        NSLog(@"I'm shaking!");
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{ return YES;
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
}


-(void) addBorderTo: (UIImageView *) imageView
{
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 8.0;
    imageView.layer.borderWidth = 5.0;
    imageView.layer.borderColor = [UIColor greenColor].CGColor;
}


-(void) reset:(NSTimer *)timer{
[self.timer invalidate];
self.timer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                  target: self
                                                selector:@selector(onTick:)
                                                userInfo: nil repeats:NO];
}

@end
