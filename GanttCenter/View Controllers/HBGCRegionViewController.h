//
//  HBGCRegionViewController.h
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCBaseViewController.h"
#import "JFMinimalNotification.h"

#define HBGCRegion_NIB @"HBGCRegionViewController"
#define HBGCRegion_NIB_SMALL @"HBGCRegionViewController_Small"

@class HBGCZoneObject;

@interface HBGCRegionViewController : HBGCBaseViewController <UIScrollViewDelegate, HBGCBeaconManagerDelegate, JFMinimalNotificationDelegate>

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andZone:(HBGCZoneObject*)aZone;

@end
