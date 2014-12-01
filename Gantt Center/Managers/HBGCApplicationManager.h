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

@interface HBGCApplicationManager : NSObject <HBGCNetworkDelegate>

+ (instancetype) appManager;
- (MONActivityIndicatorView*) currentActivityIndicator;

@property (nonatomic, strong) HBGCNetworkManager *networkManager;
@property (nonatomic, strong) NSDictionary *currentJSON;

@end
