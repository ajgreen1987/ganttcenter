//
//  HBGCZoneObject.m
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCZoneObject.h"
#import "HBGCBeaconObject.h"
#import "HBGCContentObject.h"

@implementation HBGCZoneObject

- (id) initWithDictionary:(NSDictionary*)aZoneDictionary
{
    self = [super init];
    
    if (self)
    {
        // Setup properties
        [self setBeacon:[[HBGCBeaconObject alloc] initWithDictionary:[aZoneDictionary objectForKey:BEACON_KEY]]];
        [self setThumbnailURL:[NSURL URLWithString:[aZoneDictionary objectForKey:THUMBNAIL_KEY]]];
        [self setThumbnail:[UIImage imageWithData:[NSData dataWithContentsOfURL:self.thumbnailURL]]];
        [self setZoneTitle:[aZoneDictionary objectForKey:TITLE_KEY]];
        [self setZoneDescription:[aZoneDictionary objectForKey:DESCRIPTION_KEY]];
        [self parseOutHeaders:[aZoneDictionary objectForKey:HEADERS_KEY]];
        [self parseOutContent:[aZoneDictionary objectForKey:CONTENT_KEY]];
    }
    
    return self;
}

- (void) parseOutHeaders:(NSArray*)anArrayOfURLs
{
    if (anArrayOfURLs != nil)
    {
        
        NSMutableArray *thumbnails = [[NSMutableArray alloc] initWithObjects:nil];
        
        for (NSDictionary *website in anArrayOfURLs)
        {
            NSString *urlString = [website objectForKey:WEBSITE_KEY];
            NSURL *url = [NSURL URLWithString:urlString];
            UIImage *headerImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            [thumbnails addObject:headerImage];
        }
        
        // Parse through json and pull out Website keys
        // Add NSURL headers to Header Images array
        self.headerImages = [[NSArray alloc] initWithArray:thumbnails];
    }
}

- (void) parseOutContent:(NSArray*)anArrayOfContentDictionaries
{
    if (anArrayOfContentDictionaries!=nil)
    {
        
        NSMutableArray *contentArray = [[NSMutableArray alloc] initWithObjects:nil];
        
        for (NSDictionary *cont in anArrayOfContentDictionaries)
        {
            HBGCContentObject *newContent = [[HBGCContentObject alloc] initWithDictionary:cont];
            
            [contentArray addObject:newContent];
        }
        
        // Parse and create Content objects
        // Add them to the Content array
        self.content = [[NSArray alloc] initWithArray:contentArray];
    }
}

@end
