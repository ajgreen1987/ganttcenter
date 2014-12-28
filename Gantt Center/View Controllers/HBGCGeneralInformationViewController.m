//
//  HBGCGeneralInformationViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/28/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCGeneralInformationViewController.h"

@interface HBGCGeneralInformationViewController ()

@end

@implementation HBGCGeneralInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) handleMapsTouchUpInside:(id)sender
{
    NSString *addressString = @"http://maps.apple.com/?q=551+South+Tryon+St,+Charlotte,+NC";
    [HBGCApplicationManager launchURL:[NSURL URLWithString:addressString]
                   orShowErrorMessage:@"Maps are unavailable"];
}

- (IBAction) handleDismissTouchUpInside:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
