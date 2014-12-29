//
//  HBGCSocialZoneObject.m
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCSocialZoneObject.h"
#import "HBGCSocialNetworksObject.h"

@implementation HBGCSocialZoneObject

- (id) initWithDictionary:(NSDictionary *)aZoneDictionary
{
    self = [super initWithDictionary:aZoneDictionary];
    
    if (self)
    {
        NSDictionary *social = [aZoneDictionary objectForKey:SOCIAL_KEY];
        [self setMessageToPost:[social objectForKey:POST_KEY]];
        [self parseNetworks:[social objectForKey:NETWORKS_KEY]];
    }
    
    return self;
}

- (void) parseNetworks:(NSArray*)networks
{
    self.socialNetworks = [[NSMutableArray alloc] initWithObjects:nil];
    
    for (NSDictionary *network in networks)
    {
        HBGCSocialNetworksObject *newNetwork = [[HBGCSocialNetworksObject alloc] initWithDictionary:network];
        
        [self.socialNetworks addObject:newNetwork];
    }
}

@end
