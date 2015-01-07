//
//  HBGCTutorialStartViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/8/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCTutorialStartViewController.h"
#import "HBGCTutorialViewController.h"

@interface HBGCTutorialStartViewController ()

- (IBAction) handleDismissalTouchUpInside:(id)sender;
- (IBAction) handleTutorialStartTouchUpInside:(id)sender;

@end

@implementation HBGCTutorialStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tutorial Start
- (IBAction) handleDismissalTouchUpInside:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction) handleTutorialStartTouchUpInside:(id)sender
{
    HBGCTutorialViewController *tutorial = [[HBGCTutorialViewController alloc] initWithNibName:HBGCTutorial_NIB
                                                                                        bundle:nil];
    
    [[self navigationController] pushViewController:tutorial
                                           animated:YES];
}

@end
