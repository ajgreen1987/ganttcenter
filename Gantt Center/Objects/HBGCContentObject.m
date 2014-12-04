//
//  HBGCContentObject.m
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCContentObject.h"
#import "HBGCBeaconObject.h"

@implementation HBGCContentObject

- (id) initWithDictionary:(id)aContentDictionary
{
    self = [super init];
    
    if (self)
    {
        [self setBeacon:[[HBGCBeaconObject alloc] initWithDictionary:[aContentDictionary objectForKey:BEACON_KEY]]];
        [self setThumbnail:[NSURL URLWithString:[aContentDictionary objectForKey:THUMBNAIL_KEY]]];
        [self setTitleText:[aContentDictionary objectForKey:TITLE_KEY]];
        [self setContentURL:[NSURL URLWithString:[aContentDictionary objectForKey:URL_KEY]]];
        
    }
    
    return self;
}

@end
