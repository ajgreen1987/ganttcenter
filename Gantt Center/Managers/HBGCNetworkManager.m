//
//  HBGCNetworkManager.m
//  Gantt Center
//
//  Created by AJ Green on 11/22/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCNetworkManager.h"

#define THE_GOOGS @"http://www.google.com/"
#define HEAD @"HEAD"

@interface HBGCNetworkManager ()

-(BOOL) isNetworkReachable;
- (NSDictionary*) noNetworkJSON;

@end

@implementation HBGCNetworkManager

- (id) initWithDelegate:(id)aDelegate
{
    if (!self)
    {
        self = [super init];
    }
    
    [self setDelegate:aDelegate];
    
    return self;
}

/**
 This is used to determine whether or not there is a network connection available at the time of the service call.
 @brief Tells whether or not the network is reachable.
 @returns BOOL Whether or not the network connection is available.
 */
-(BOOL) isNetworkReachable
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *) &zeroAddress);
    
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags)) {
        if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
            // if target host is not reachable
            CFRelease(reachabilityRef);
            return NO;
        }
        
        if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
            // if target host is reachable and no connection is required
            //  then we'll assume (for now) that your on Wi-Fi
            CFRelease(reachabilityRef);
            return YES; // This is a wifi connection.
        }
        
        
        if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0)
             ||(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)) {
            // ... and the connection is on-demand (or on-traffic) if the
            //     calling application is using the CFSocketStream or higher APIs
            
            if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
                // ... and no [user] intervention is needed
                CFRelease(reachabilityRef);
                return YES; // This is a wifi connection.
            }
        }
        
        if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
            // ... but WWAN connections are OK if the calling application
            //     is using the CFNetwork (CFSocketStream?) APIs.
            CFRelease(reachabilityRef);
            return YES; // This is a cellular connection.
        }
    }
    
    CFRelease(reachabilityRef);
    return NO;
}

/**
 */
- (void) retrieveJSONFromURL:(NSURL*)aURL
{
    NSURLRequest *jsonRequest = [NSURLRequest requestWithURL:aURL];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    if([self isNetworkReachable])
    {
        [NSURLConnection sendAsynchronousRequest:jsonRequest
                                           queue:queue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   
                                   NSError *jsonError;
                                   NSDictionary *receivedJSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                      options:NSJSONReadingAllowFragments
                                                                                                        error:&jsonError];
                                   
                                   if (self.delegate)
                                   {
                                       [self.delegate didParseResponse:receivedJSONObject];
                                   }
                               }];
    }
    else
    {
        if (self.delegate)
        {
            [self.delegate didParseResponse:[self noNetworkJSON]];
        }
    }
    

}

/**
 */
- (NSDictionary*) noNetworkJSON
{
    return nil;
}

@end
