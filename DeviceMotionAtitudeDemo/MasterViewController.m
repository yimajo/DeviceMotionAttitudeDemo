//
//  MasterViewController.m
//  DeviceMotionAtitudeDemo
//
//  Created by yimajo on 2013/10/10.
//  Copyright (c) 2013年 Curiosity Software Inc. All rights reserved.
//

#import "MasterViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <math.h>

@interface MasterViewController ()

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
@property (weak, nonatomic) IBOutlet UILabel *rollLabel;
@property (weak, nonatomic) IBOutlet UILabel *yawLabel;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self attiude];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (void)commonInit
{
    // Custom initialization
    _motionManager = [[CMMotionManager alloc] init];
}

#pragma mark - 

- (void)attiude
{
    if (self.motionManager.deviceMotionAvailable) {
        
        __weak MasterViewController *viewController = self;
        
        // 向きの更新通知を開始する
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                                withHandler:^(CMDeviceMotion *motion, NSError *error)
         {
             NSLog(@"%f ",motion.attitude.pitch * 180 / M_PI);
             
             viewController.pitchLabel.text
                = [NSString stringWithFormat:@"%f", motion.attitude.pitch * 180 / M_PI];

             viewController.rollLabel.text
                = [NSString stringWithFormat:@"%f", motion.attitude.roll * 180 / M_PI];

             viewController.yawLabel.text
                = [NSString stringWithFormat:@"%f", motion.attitude.yaw * 180 / M_PI];

         }];
    }
}


@end
