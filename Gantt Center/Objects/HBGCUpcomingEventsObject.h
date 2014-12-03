//
//  HBGCUpcomingEventsObject.h
//  Gantt Center
//
//  Created by AJ Green on 11/30/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HBGCUpcomingEventsObject : NSObject

- (id) initWithImage:(NSString*)anImage andWebsite:(NSURL*)aURL;

@property (nonatomic, strong) NSString *thumbnailImage;
@property (nonatomic, strong) NSURL *website;

@end
