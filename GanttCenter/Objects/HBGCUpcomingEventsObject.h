//
//  HBGCUpcomingEventsObject.h
//  Gantt Center
//
//  Created by AJ Green on 11/30/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCHeaderObject.h"

@interface HBGCUpcomingEventsObject : HBGCHeaderObject

- (id) initWithImage:(NSString*)anImage andWebsite:(NSURL*)aURL;

@property (nonatomic, strong) NSURL *website;

@end
