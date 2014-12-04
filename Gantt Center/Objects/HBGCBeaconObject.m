//
//  HBGCBeaconObject.m
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCBeaconObject.h"

@implementation HBGCBeaconObject

- (id) initWithDictionary:(NSDictionary*)aBeaconDictionary
{
    self = [super init];
    
    if (self)
    {
        [self setUuid:[aBeaconDictionary objectForKey:UUID_KEY]];
        [self setMajorID:[aBeaconDictionary objectForKey:MAJOR_KEY]];
        [self setMinorID:[aBeaconDictionary objectForKey:MINOR_KEY]];
    }
    
    return self;
}

@end
