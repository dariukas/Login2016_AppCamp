//
//  ViewController.h
//  LoginApp2016
//
//  Created by Darius Miliauskas on 04/05/16.
//  Copyright © 2016 Darius Miliauskas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *evImageView;

@property (nonatomic, retain) NSString *eventsPath;
@property (nonatomic, retain) NSArray *content;
@property (nonatomic, retain) NSTimer *timer;

@end

