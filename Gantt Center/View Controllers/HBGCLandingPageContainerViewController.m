//
//  HBGCLandingPageContainerViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/2/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCLandingPageContainerViewController.h"
#import "HBGCBeaconZonesViewController.h"
#import "HBGCTutorialStartViewController.h"

@interface HBGCLandingPageContainerViewController ()

@end

@implementation HBGCLandingPageContainerViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.childViewControllers.count > 0)
    {
        [self removeOldChildViewController];
    }
    
    // Need a No Network Check
    if ([ESTBeaconManager authorizationStatus] == (kCLAuthorizationStatusNotDetermined|kCLAuthorizationStatusDenied))
    {
        // Show Tutorial Controller
        HBGCTutorialStartViewController *tutorialController = [[HBGCTutorialStartViewController alloc] initWithNibName:HBGCTUTORIALSTART_NIB
                                                                                                                bundle:nil];
        
        [self addChildViewController:tutorialController];
        [[self view] addSubview:tutorialController.view];
        [tutorialController didMoveToParentViewController:self];
    }
    else
    {
        // Or Present the Zone images that have been parsed out
        HBGCBeaconZonesViewController *beaconController = [[HBGCBeaconZonesViewController alloc] initWithNibName:HBGCBeaconZones_NIB
                                                                                                          bundle:nil];
        
        [self addChildViewController:beaconController];
        [self.view addSubview:beaconController.view];
        [beaconController didMoveToParentViewController:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) removeOldChildViewController
{
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

@end
