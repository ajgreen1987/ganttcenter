//
//  AJGFadingSegue.m
//  Gantt Center
//
//  Created by AJ Green on 12/27/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "AJGFadingSegue.h"

@implementation AJGFadingSegue

- (void) perform
{
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];
}

@end
