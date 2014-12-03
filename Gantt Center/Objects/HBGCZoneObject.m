//
//  HBGCZoneObject.m
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCZoneObject.h"
#import "HBGCBeaconObject.h"

@implementation HBGCZoneObject

- (id) initWithDictionary:(NSDictionary*)aZoneDictionary
{
    self = [super init];
    
    if (self)
    {
        // Setup properties
        /*
         @property (nonatomic, strong) HBGCBeaconObject *beacon;
         @property (nonatomic, strong) NSURL *thumbnail;
         @property (nonatomic, strong) NSString *description;
         @property (nonatomic, strong) NSArray *headerImages;
         @property (nonatomic, strong) NSArray *content;
         */
        [self setBeacon:[[HBGCBeaconObject alloc] initWithDictionary:[aZoneDictionary objectForKey:BEACON_KEY]]];
        [self setThumbnail:[NSURL URLWithString:[aZoneDictionary objectForKey:THUMBNAIL_KEY]]];
        [self setZoneDescription:[aZoneDictionary objectForKey:DESCRIPTION_KEY]];
        [self setHeaderImages:[aZoneDictionary objectForKey:HEADERS_KEY]];
    }
    
    return self;
}

- (void) parseOutHeaders:(NSArray*)anArrayOfURLs
{
    // Parse through json and pull out Website keys
    // Add NSURL headers to Header Images array
}

- (void) parseOutContent:(NSArray*)anArrayOfContentDictionaries
{
    // Parse and create Content objects
    // Add them to the Content array
}

@end
