//
//  HBGCApplicationManager.m
//  Gantt Center
//
//  Created by AJ Green on 11/22/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCApplicationManager.h"

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

#pragma mark - Network Delegate

/**
 JSON response received
 */
- (void) didParseResponse:(NSDictionary *)aResponse
{
    self.currentJSON = aResponse;
    self.currentEvents = [aResponse objectForKey:UPCOMING_EVENTS_KEY];
    self.currentZones = [aResponse objectForKey:ZONES_KEY];
    
    // All instances of TestClass will be notified
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PARSED_JSON
                                                        object:self];
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
    CGFloat contentOffset = aScrollView.contentOffset.x;
    
    int nextPage = (int)(contentOffset/aScrollView.frame.size.width) + 1 ;
    
    if( nextPage!= aMaxPageSize)
    {
        [aScrollView scrollRectToVisible:CGRectMake(nextPage*aScrollView.frame.size.width, 0, aScrollView.frame.size.width, aScrollView.frame.size.height) animated:YES];
    }
    else
    {
        [aScrollView scrollRectToVisible:CGRectMake(0, 0, aScrollView.frame.size.width, aScrollView.frame.size.height) animated:YES];
    }

}

@end
