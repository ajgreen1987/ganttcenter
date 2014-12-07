//
//  HBGCHeaderObject.h
//  Gantt Center
//
//  Created by AJ Green on 12/6/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBGCHeaderObject : NSObject

- (id) initWithThumbnailImage:(NSString*)anImage;

@property (nonatomic, strong) NSString *thumbnailImage;

@end
