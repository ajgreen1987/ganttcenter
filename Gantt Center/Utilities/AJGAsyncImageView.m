//
//  AJGAsyncImageView.m
//  TwitterTestApp
//
//  Created by Andrew Green on 10/7/12.
//  Copyright (c) 2012 Andrew Green. All rights reserved.
//
//  The source is free to use by anyone, anywhere. Ever. Even
//  on a different platform. Except for Robert G. Warrick, he
//  can't use it. Ever.

#import "AJGAsyncImageView.h"

#define ASYNC_IMAGE_QUEUE "com.ajg.imagequeue"

@interface AJGAsyncImageView ()

@property (nonatomic, strong) UIActivityIndicatorView *activitySpinner;
@property (nonatomic, strong) dispatch_queue_t profileImageQueue;

@end

@implementation AJGAsyncImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        self.profileImageQueue = dispatch_queue_create(ASYNC_IMAGE_QUEUE, NULL);
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Initialization code
        self.profileImageQueue = dispatch_queue_create(ASYNC_IMAGE_QUEUE, NULL);
    }
    
    return self;
}

- (void) setupActivityIndicatorAtCenter:(CGPoint)aCenterPoint
{
    if (_activitySpinner == nil)
        _activitySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    CGPoint actualCenter = [self convertPoint:self.center fromView:self.superview];
    
    [_activitySpinner setCenter:actualCenter];
    [_activitySpinner setHidesWhenStopped:YES];
    [_activitySpinner startAnimating];
    
    [self addSubview:_activitySpinner];
}

- (void) beginLoadingImageFromURL:(NSString*)anURL
{
    dispatch_async(_profileImageQueue, ^{
        [self setupActivityIndicatorAtCenter:self.center];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:anURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setImage:[UIImage imageWithData:imageData]];
            [_activitySpinner stopAnimating];
        });
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
