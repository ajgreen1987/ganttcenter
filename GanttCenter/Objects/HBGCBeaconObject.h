//
//  HBGCBeaconObject.h
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBGCBeaconObject : NSObject

- (id) initWithDictionary:(NSDictionary*)aBeaconDictionary;

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *majorID;
@property (nonatomic, strong) NSString *minorID;

@end
