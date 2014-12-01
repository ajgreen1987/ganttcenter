//
//  ViewController.m
//  Gantt Center
//
//  Created by AJ Green on 11/22/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[self view] setUserInteractionEnabled:NO];
    
    [[self view] addSubview:[[HBGCApplicationManager appManager] currentActivityIndicator]];
    [[[HBGCApplicationManager appManager] currentActivityIndicator] startAnimating];
    
    NSURL *url = [NSURL URLWithString:@"https://api.myjson.com/bins/582br"];
    
    [[[HBGCApplicationManager appManager] networkManager] retrieveJSONFromURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
