//
//  HBGCSocialRegionViewController.h
//  Gantt Center
//
//  Created by AJ Green on 12/7/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCBaseViewController.h"

#define HBGCSOCIALREGION_NIB @"HBGCSocialRegionViewController"

@class HBGCZoneObject;

@interface HBGCSocialRegionViewController : HBGCBaseViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andZone:(HBGCZoneObject*)aZone;

- (IBAction) handleEmailTouchUpInside:(id)sender;
- (IBAction) handleFacebookTouchUpInside:(id)sender;
- (IBAction) handleTwitterTouchUpInside:(id)sender;
- (IBAction) handleYouTubeTouchUpInside:(id)sender;
- (IBAction) handleDismissTouchUpInside:(id)sender;

@end
