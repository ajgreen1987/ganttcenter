//
//  HBGCSocialNetworksObject.m
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCSocialNetworksObject.h"

@implementation HBGCSocialNetworksObject

- (id) initWithDictionary:(NSDictionary*)aDictionary
{
    self = [super init];
    
    if (self)
    {
        [self setNetworkTitle:[aDictionary objectForKey:TITLE_KEY]];
        [self setThumbnail:[NSURL URLWithString:[aDictionary objectForKey:THUMBNAIL_KEY]]];
        [self setNetworkURL:[NSURL URLWithString:[aDictionary objectForKey:URL_KEY]]];
    }
    
    return self;
}

- (Network) typeOfNetwork
{
    if ([self.networkTitle isEqualToString:@"Facebook"])
    {
        return Facebook;
    }
    else if ([self.networkTitle isEqualToString:@"Twitter"])
    {
        return Twitter;
    }
    else if ([self.networkTitle isEqualToString:@"Email"])
    {
        return Email;
    }
    else
    {
        return Youtube;
    }
}

@end
