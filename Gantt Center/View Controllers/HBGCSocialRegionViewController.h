//
//  HBGCSocialRegionViewController.h
//  Gantt Center
//
//  Created by AJ Green on 12/7/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HBGCSOCIALREGION_NIB @"HBGCSocialRegionViewController"

@class HBGCZoneObject;

@interface HBGCSocialRegionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andZone:(HBGCZoneObject*)aZone;

@end
