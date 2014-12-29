//
//  HBGCHeaderObject.m
//  Gantt Center
//
//  Created by AJ Green on 12/6/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCHeaderObject.h"

@implementation HBGCHeaderObject

- (id) initWithThumbnailImage:(NSString *)anImage
{
    self = [super init];
    
    [self setThumbnailURL:anImage];
    [self setThumbnail:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.thumbnailURL]]]];
    
    return self;
}

@end
