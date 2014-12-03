//
//  HBGCLandingPageContainerViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/2/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCLandingPageContainerViewController.h"
#import "HBGCBeaconZonesViewController.h"

@interface HBGCLandingPageContainerViewController ()

@end

@implementation HBGCLandingPageContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // This would need to check the permissions of Location and Bluetooth and present the Tutorial page
    // Or check the network and present the network outage
    // Or Present the Zone images that have been parsed out
    
    HBGCBeaconZonesViewController *beaconController = [[HBGCBeaconZonesViewController alloc] initWithNibName:HBGCBeaconZones_NIB
                                                                                                      bundle:nil];
    
    [self addChildViewController:beaconController];
    [self.view addSubview:beaconController.view];
    [beaconController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
