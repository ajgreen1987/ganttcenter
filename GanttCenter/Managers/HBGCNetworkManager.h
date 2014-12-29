//
//  HBGCNetworkManager.h
//  Gantt Center
//
//  Created by AJ Green on 11/22/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>

@protocol HBGCNetworkDelegate <NSObject>

- (void) didParseResponse:(NSDictionary*)aResponse;

@end

/**
 This class will handle:
 
 1) Network connectivity changes
 2) Handling pulling the JSON files
 3) Handling parsing the JSON files
 */
@interface HBGCNetworkManager : NSObject

@property (nonatomic, weak) id<HBGCNetworkDelegate> delegate;

- (id) initWithDelegate:(id)aDelegate;

- (void) retrieveJSONFromURL:(NSURL*)aURL;

@end
