//
//  HBGCBeaconManager.h
//  Gantt Center
//
//  Created by AJ Green on 12/8/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESTBeaconManager.h"

#define AUTO_BEACON_DISTANCE  0.03 // In meters

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

@property (nonatomic, weak) id<HBGCBeaconManagerDelegate> delegate;
@property (nonatomic, strong) NSArray *beaconsArray;

@end
