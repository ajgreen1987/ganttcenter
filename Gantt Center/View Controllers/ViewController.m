//
//  ViewController.m
//  Gantt Center
//
//  Created by AJ Green on 11/22/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "ViewController.h"
#import "HBGCApplicationManager.h"
#import "HBGCUpcomingEventsObject.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *upcomingEventsScrollView;
@property (nonatomic, strong) NSMutableArray *upcomingEvents;
@property (nonatomic, strong) NSMutableArray *eventImages;

@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(buildOutUpcomingEventsViewController)
                                                 name:NOTIFICATION_PARSED_JSON
                                               object:nil];
    
    self.upcomingEvents = [[NSMutableArray alloc] initWithObjects:nil];
    self.eventImages = [[NSMutableArray alloc] initWithObjects:nil];
    
    //[[self view] addSubview:[[HBGCApplicationManager appManager] currentActivityIndicator]];
    [[[HBGCApplicationManager appManager] currentActivityIndicator] startAnimating];
    [[[HBGCApplicationManager appManager] currentActivityIndicator] setCenter:self.view.center];
    
    NSURL *url = [NSURL URLWithString:@"https://api.myjson.com/bins/2khqn"];
    
    [[[HBGCApplicationManager appManager] networkManager] retrieveJSONFromURL:url];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page Control Setup
- (void) buildOutUpcomingEventsViewController
{
    NSDictionary *events = [[[HBGCApplicationManager appManager] currentJSON] objectForKey:UPCOMING_EVENTS_KEY];
    
    for (NSDictionary *dictionary in events)
    {
        NSString *thumbnailURL = [dictionary objectForKey:UPCOMING_EVENTS_THUMBNAIL_KEY];
        NSString *websiteURL = [dictionary objectForKey:UPCOMING_EVENTS_WEBSITE_KEY];
        
        HBGCUpcomingEventsObject *newEvent = [[HBGCUpcomingEventsObject alloc] initWithImage:thumbnailURL
                                                                                  andWebsite:[NSURL URLWithString:websiteURL]];
        
        [self.upcomingEvents addObject:newEvent];
        [self.eventImages addObject:thumbnailURL];
    }
    
    [self setupScrollView];
}

- (void) setupScrollView
{
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    
    self.upcomingEventsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 100.0f)];
    [self.upcomingEventsScrollView setPagingEnabled:YES];
    [self.upcomingEventsScrollView setScrollEnabled:YES];
    
    [self.view addSubview:self.upcomingEventsScrollView];
    
    self.upcomingEventsScrollView.contentSize = CGSizeMake(self.upcomingEventsScrollView.frame.size.width * colors.count, self.upcomingEventsScrollView.frame.size.height);
    
    for (int i = 0; i < colors.count; i++)
    {
        CGRect frame;
        frame.origin.x = self.upcomingEventsScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.upcomingEventsScrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [colors objectAtIndex:i];
        [self.upcomingEventsScrollView addSubview:subview];
    }
}



@end
