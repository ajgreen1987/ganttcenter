//
//  HBGCApplicationManager.m
//  Gantt Center
//
//  Created by AJ Green on 11/22/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCApplicationManager.h"
#import "HBGCSocialZoneObject.h"
#import "HBGCUpcomingEventsObject.h"

@interface HBGCApplicationManager ()

@property (nonatomic, strong) MONActivityIndicatorView *activityIndicator;

@end

@implementation HBGCApplicationManager

static HBGCApplicationManager *sharedAppManager;

#pragma mark Singleton Methods
+ (instancetype) appManager
{
    @synchronized(self) {
        if (sharedAppManager == nil)
        {
            sharedAppManager = [[self alloc] init];
        }
    }
    
    return sharedAppManager;
}

- (HBGCNetworkManager*) networkManager
{
    if (_networkManager == nil)
    {
        _networkManager = [[HBGCNetworkManager alloc] initWithDelegate:self];
    }
    
    return _networkManager;
}

- (HBGCBeaconManager*) beaconManager
{
    if(_beaconManager == nil)
    {
        _beaconManager = [[HBGCBeaconManager alloc] initWithScanType:ESTScanTypeBeacon];
    }
    
    return _beaconManager;
}

#pragma mark - Network Delegate

/**
 JSON response received
 */
- (void) didParseResponse:(NSDictionary *)aResponse
{
    self.currentJSON = aResponse;
    self.currentEvents = [aResponse objectForKey:UPCOMING_EVENTS_KEY];
    self.currentZones = [aResponse objectForKey:ZONES_KEY];
    
    [self buildOutUpcomingEventsViewController];
    [self parseOutZones];
    
    // All instances of TestClass will be notified
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PARSED_JSON
                                                        object:self];
}

#pragma mark - Scroll View Setup
- (void) buildOutUpcomingEventsViewController
{
    NSArray *events = self.currentEvents;
    
    if ([events count] > 0)
    {
        self.events = [[NSMutableArray alloc] initWithObjects:nil];
        
        for (NSDictionary *dictionary in events)
        {
            NSString *thumbnailURL = [dictionary objectForKey:THUMBNAIL_KEY];
            NSString *websiteURL = [dictionary objectForKey:WEBSITE_KEY];
            
            HBGCUpcomingEventsObject *newEvent = [[HBGCUpcomingEventsObject alloc] initWithImage:thumbnailURL
                                                                                      andWebsite:[NSURL URLWithString:websiteURL]];
            
            [self.events addObject:newEvent];
        }
    }
}

- (void) parseOutZones
{
    NSArray *zones = self.currentZones;
    
    if ([zones count] > 0)
    {
        self.zones = [[NSMutableArray alloc] initWithObjects:nil];
        
        NSMutableArray *intermediateThumbnail = [[NSMutableArray alloc] initWithObjects:nil];
        
        for (NSDictionary *dictionary in zones)
        {
            if ([[dictionary allKeys] containsObject:SOCIAL_KEY])
            {
                HBGCSocialZoneObject *socialZone = [[HBGCSocialZoneObject alloc] initWithDictionary:dictionary];
                
                [intermediateThumbnail addObject:socialZone];
            }
            else
            {
                HBGCZoneObject *zone = [[HBGCZoneObject alloc] initWithDictionary:dictionary];
                
                [intermediateThumbnail addObject:zone];
            }
        }
        
        int counter = 1;
        
        for (int i=0; i<intermediateThumbnail.count; i++)
        {
            if (i%2==0)
            {
                NSMutableArray *toAddTo = [[NSMutableArray alloc] initWithObjects:nil];
                
                [toAddTo addObject:[intermediateThumbnail objectAtIndex:i]];
                
                [self.zones addObject:toAddTo];
            }
            else
            {
                NSInteger lastIndex = i-counter;
                [[self.zones objectAtIndex:lastIndex] addObject:[intermediateThumbnail objectAtIndex:i]];
                counter++;
            }
        }
    }
}


/**
 */
- (MONActivityIndicatorView*) currentActivityIndicator
{
    if (sharedAppManager.activityIndicator == nil)
    {
        sharedAppManager.activityIndicator = [[MONActivityIndicatorView alloc] init];
    }
    
    return sharedAppManager.activityIndicator;
}

#pragma mark - UI Management
+ (void) autoScrollScrollView:(UIScrollView*)aScrollView andMaxPageSize:(NSInteger)aMaxPageSize
{
    [HBGCApplicationManager autoScrollScrollView:aScrollView andMaxPageSize:aMaxPageSize withFading:NO];
}

+ (void) autoScrollScrollView:(UIScrollView*)aScrollView andMaxPageSize:(NSInteger)aMaxPageSize withFading:(BOOL)shouldFade
{
    CGFloat contentOffset = aScrollView.contentOffset.x;
    
    int nextPage = (int)(contentOffset/aScrollView.frame.size.width) + 1 ;
    
    if( nextPage!= aMaxPageSize)
    {
        CGRect frame = CGRectMake(nextPage*aScrollView.frame.size.width, 0, aScrollView.frame.size.width, aScrollView.frame.size.height);
        
            [aScrollView scrollRectToVisible:frame
                                    animated:YES];
    }
    else
    {
        CGRect frame = CGRectMake(0, 0, aScrollView.frame.size.width, aScrollView.frame.size.height);
        
            [aScrollView scrollRectToVisible:frame
                                    animated:YES];

    }
    
}

+ (void) launchURL:(NSURL*)anURL orShowErrorMessage:(NSString*)aMessage
{
    UIApplication *ourApplication = [UIApplication sharedApplication];
    
    if ([ourApplication canOpenURL:anURL])
    {
        [[UIApplication sharedApplication] openURL:anURL];
    }
    else
    {
        UIAlertView *urlError = [[UIAlertView alloc] initWithTitle:@"We're Sorry"
                                                           message:aMessage
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        
        [urlError show];
    }

}

@end
