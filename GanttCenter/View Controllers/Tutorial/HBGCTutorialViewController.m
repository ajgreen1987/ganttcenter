//
//  HBGCTutorialViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/8/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCTutorialViewController.h"

@interface HBGCTutorialViewController ()

- (IBAction) handleDismissalTouchUpInside:(id)sender;
- (IBAction) handleGetPermissionsTouchUpInside:(id)sender;

@end

@implementation HBGCTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[[HBGCApplicationManager appManager] beaconManager] setDelegate:nil];
}

- (IBAction) handleGetPermissionsTouchUpInside:(id)sender
{
    [[[HBGCApplicationManager appManager] beaconManager] setupBeaconManager];
    [[[HBGCApplicationManager appManager] beaconManager] setDelegate:self];
}

#pragma mark - Beacon Delegate
- (void) allBeaconsDiscovered
{
    [self dismiss];
}

- (IBAction) handleDismissalTouchUpInside:(id)sender
{
    [self dismiss];
}

- (void) dismiss
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
