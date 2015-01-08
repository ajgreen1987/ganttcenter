//
//  HBGCGeneralInformationViewController.h
//  Gantt Center
//
//  Created by AJ Green on 12/28/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HBGCGeneralInfo_NIB @"HBGCGeneralInformationViewController"
#define HBGCGeneralInfo_NIB_SMALL @"HBGCGeneralInformationViewController_Small"

@interface HBGCGeneralInformationViewController : UIViewController

- (IBAction) handleMapsTouchUpInside:(id)sender;
- (IBAction) handleDismissTouchUpInside:(id)sender;

@end
