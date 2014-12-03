//
//  HBGCApplicationManager.h
//  Gantt Center
//
//  Created by AJ Green on 11/22/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBGCNetworkManager.h"
#import "MONActivityIndicatorView.h"

#define NOTIFICATION_PARSED_JSON @"JSON"

#define UPCOMING_EVENTS_KEY @"Events"
#define ZONES_KEY @"Zones"
#define THUMBNAIL_KEY @"Thumbnail"
#define WEBSITE_KEY @"Website"
#define BEACON_KEY @"Beacon"
#define DESCRIPTION_KEY @"Description"
#define HEADERS_KEY @"Headers"
#define CONTENT_KEY @"Content"


@interface HBGCApplicationManager : NSObject <HBGCNetworkDelegate>

+ (instancetype) appManager;
- (MONActivityIndicatorView*) currentActivityIndicator;

@property (nonatomic, strong) HBGCNetworkManager *networkManager;
@property (nonatomic, strong) NSDictionary *currentJSON;
@property (nonatomic, strong) NSDictionary *currentEvents;
@property (nonatomic, strong) NSDictionary *currentZones;

@end
