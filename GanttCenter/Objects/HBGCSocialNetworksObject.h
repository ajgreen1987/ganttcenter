//
//  HBGCSocialNetworksObject.h
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    Facebook,
    Twitter,
    Email,
    Youtube
}Network;

@interface HBGCSocialNetworksObject : NSObject

- (id) initWithDictionary:(NSDictionary*)aDictionary;

@property (nonatomic, assign) Network typeOfNetwork;
@property (nonatomic, strong) NSString *networkTitle;
@property (nonatomic, strong) NSURL *thumbnail;
@property (nonatomic, strong) NSURL *networkURL;

@end
