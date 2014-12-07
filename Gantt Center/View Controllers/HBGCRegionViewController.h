//
//  HBGCRegionViewController.h
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HBGCRegion_NIB @"HBGCRegionViewController"

@class HBGCZoneObject;

@interface HBGCRegionViewController : UIViewController <UIScrollViewDelegate>

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andZone:(HBGCZoneObject*)aZone;

@end
