//
//  HBGCBeaconManager.h
//  Gantt Center
//
//  Created by AJ Green on 12/8/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESTBeaconManager.h"

#define REGION_BEACON_DISTANCE      17.0f   // In meters
#define CONTENT_BEACON_DISTANCE     3.0f    // Meters

typedef enum : int
{
    ESTScanTypeBluetooth,
    ESTScanTypeBeacon
    
} ESTScanType;

@protocol HBGCBeaconManagerDelegate <NSObject>

@optional
- (void) beaconManager:(ESTBeaconManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (void) allBeaconsDiscovered;

@end

@interface HBGCBeaconManager : NSObject <ESTBeaconManagerDelegate>

- (id) initWithScanType:(ESTScanType)aScanType;
- (void) setupBeaconManager;
- (void) startRangingBeacons;
- (void) stopRangingBeacons;

@property (nonatomic, assign) BOOL isPrimed;
@property (nonatomic, weak) id<HBGCBeaconManagerDelegate> delegate;
@property (nonatomic, strong) NSArray *beaconsArray;

@end
