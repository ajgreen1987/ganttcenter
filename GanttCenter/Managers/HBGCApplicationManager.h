//
//  HBGCApplicationManager.h
//  Gantt Center
//
//  Created by AJ Green on 11/22/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBGCNetworkManager.h"
#import "HBGCBeaconManager.h"
#import "MONActivityIndicatorView.h"

#define GANTT_KEY @"gantt_preference"
#define AUTO_BEACON_CONTENT @"enabled_preference"

#define NOTIFICATION_PARSED_JSON @"JSON"

#define UPCOMING_EVENTS_KEY @"Events"
#define ZONES_KEY @"Zones"
#define THUMBNAIL_KEY @"Thumbnail"
#define WEBSITE_KEY @"Website"
#define BEACON_KEY @"Beacon"
#define DESCRIPTION_KEY @"Description"
#define HEADERS_KEY @"Headers"
#define CONTENT_KEY @"Content"
#define UUID_KEY @"UUID"
#define MAJOR_KEY @"Major"
#define MINOR_KEY @"Minor"
#define TITLE_KEY @"Title"
#define URL_KEY @"URL"
#define SOCIAL_KEY @"Social"
#define POST_KEY @"Post"
#define NETWORKS_KEY @"Networks"

#define SCROLL_VIEW_ANIMATION_DURATION 8.0f
#define FADE_ANIMATION_DURATION 8.0f
#define FADE_IMAGE_DURATION 0.8f


@interface HBGCApplicationManager : NSObject <HBGCNetworkDelegate>

+ (instancetype) appManager;
+ (void) autoScrollScrollView:(UIScrollView*)aScrollView andMaxPageSize:(NSInteger)aMaxPageSize;
+ (void) autoScrollScrollView:(UIScrollView*)aScrollView andMaxPageSize:(NSInteger)aMaxPageSize withFading:(BOOL)shouldFade;
+ (void) launchURL:(NSURL*)anURL orShowErrorMessage:(NSString*)aMessage;

- (MONActivityIndicatorView*) currentActivityIndicator;

@property (nonatomic, strong) HBGCNetworkManager *networkManager;
@property (nonatomic, strong) HBGCBeaconManager *beaconManager;
@property (nonatomic, strong) NSDictionary *currentJSON;
@property (nonatomic, strong) NSArray *currentEvents;
@property (nonatomic, strong) NSArray *currentZones;
@property (nonatomic, strong) NSMutableArray *zones;
@property (nonatomic, strong) NSMutableArray *events;

@end
