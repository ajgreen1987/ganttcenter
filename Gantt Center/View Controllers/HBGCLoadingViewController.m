//
//  HBGCLoadingViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/27/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCLoadingViewController.h"

#define ANIMATION_PREFIX @"Gantt_loading_green_fast-"
#define ANIMATION_SUFFIX @" (dragged)"
#define ANIMATION_DURATION 0.9f
#define ANIMATION_REPEAT 100

@interface HBGCLoadingViewController ()

@end

@implementation HBGCLoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self animateImage];
    
    
    NSURL *url = [NSURL URLWithString:@"http://hbgcvewdio.s3.amazonaws.com/gantt.json"];
    
    [[[HBGCApplicationManager appManager] networkManager] retrieveJSONFromURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moveToLandingPage)
                                                 name:NOTIFICATION_PARSED_JSON
                                               object:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) animateImage
{
    NSMutableArray *images = [[NSMutableArray alloc] initWithObjects:nil];
    
    for (int i=1; i<35; i++)
    {
        NSString *animationImage = [NSString stringWithFormat:@"%@%i%@",ANIMATION_PREFIX,i,ANIMATION_SUFFIX];
        
        [images addObject:[UIImage imageNamed:animationImage]];
    }
    
    [self.loadingImage setAnimationImages:images];
    [self.loadingImage setAnimationDuration:ANIMATION_DURATION];
    [self.loadingImage setAnimationRepeatCount:ANIMATION_REPEAT];
    
    [self.loadingImage startAnimating];
}

- (void) moveToLandingPage
{
    [self performSegueWithIdentifier:@"Landing" sender:self];
}

@end
