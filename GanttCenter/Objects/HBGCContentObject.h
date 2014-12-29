//
//  HBGCContentObject.h
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HBGCBeaconObject;

@interface HBGCContentObject : NSObject

- (id) initWithDictionary:(id)aContentDictionary;

@property (nonatomic, strong) HBGCBeaconObject *beacon;
@property (nonatomic, strong) NSURL *thumbnail;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSURL *contentURL;

@end
