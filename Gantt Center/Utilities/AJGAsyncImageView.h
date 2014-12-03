//
//  AJGAsyncImageView.h
//  TwitterTestApp
//
//  Created by Andrew Green on 10/7/12.
//  Copyright (c) 2012 Andrew Green. All rights reserved.
//
//  The source is free to use by anyone, anywhere. Ever. Even
//  on a different platform. Except for Robert G. Warrick, he
//  can't use it. Ever.

#import <UIKit/UIKit.h>

@interface AJGAsyncImageView : UIImageView

- (void) setupActivityIndicatorAtCenter:(CGPoint)aCenterPoint;
- (void) beginLoadingImageFromURL:(NSString*)anURL;

@end
