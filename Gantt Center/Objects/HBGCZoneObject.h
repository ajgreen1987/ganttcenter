//
//  HBGCZoneObject.h
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HBGCBeaconObject;

@interface HBGCZoneObject : NSObject

- (id) initWithDictionary:(NSDictionary*)aZoneDictionary;

@property (nonatomic, strong) HBGCBeaconObject *beacon;
@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSString *zoneDescription;
@property (nonatomic, strong) NSArray *headerImages;
@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSString *zoneTitle;

@end
