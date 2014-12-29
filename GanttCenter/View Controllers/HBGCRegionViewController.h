//
//  HBGCRegionViewController.h
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCBaseViewController.h"

#define HBGCRegion_NIB @"HBGCRegionViewController"

@class HBGCZoneObject;

@interface HBGCRegionViewController : HBGCBaseViewController <UIScrollViewDelegate, HBGCBeaconManagerDelegate>

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andZone:(HBGCZoneObject*)aZone;

@end
