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
#import "AJGAsyncImageView.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *upcomingEventsScrollView;
@property (nonatomic, strong) NSMutableArray *upcomingEvents;
@property (nonatomic, strong) NSMutableArray *eventImages;

- (void) buildOutUpcomingEventsViewController;
- (void) setupScrollView;
- (void) autoScrollUpcomingEvents;


@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScrollView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(buildOutUpcomingEventsViewController)
                                                 name:NOTIFICATION_PARSED_JSON
                                               object:nil];
    
    self.upcomingEvents = [[NSMutableArray alloc] initWithObjects:nil];
    self.eventImages = [[NSMutableArray alloc] initWithObjects:nil];
    
    /*
     [[self view] addSubview:[[HBGCApplicationManager appManager] currentActivityIndicator]];
     [[[HBGCApplicationManager appManager] currentActivityIndicator] startAnimating];
     [[[HBGCApplicationManager appManager] currentActivityIndicator] setCenter:self.view.center];
     */
    
    NSURL *url = [NSURL URLWithString:@"https://api.myjson.com/bins/s8gv"];
    
    [[[HBGCApplicationManager appManager] networkManager] retrieveJSONFromURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scroll View Setup
- (void) buildOutUpcomingEventsViewController
{
    NSDictionary *events = [[HBGCApplicationManager appManager] currentEvents];
    
    for (NSDictionary *dictionary in events)
    {
        NSString *thumbnailURL = [dictionary objectForKey:THUMBNAIL_KEY];
        NSString *websiteURL = [dictionary objectForKey:WEBSITE_KEY];
        
        HBGCUpcomingEventsObject *newEvent = [[HBGCUpcomingEventsObject alloc] initWithImage:thumbnailURL
                                                                                  andWebsite:[NSURL URLWithString:websiteURL]];
        
        [self.upcomingEvents addObject:newEvent];
        [self.eventImages addObject:thumbnailURL];
    }
    
    [self setupScrollView];
}

- (void) setupScrollView
{
    NSInteger imagesCount = self.eventImages.count;
    
    if (imagesCount == 0)
    {
        self.upcomingEventsScrollView = nil;
        self.upcomingEventsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 100.0f)];
        [self.upcomingEventsScrollView setPagingEnabled:YES];
        [self.upcomingEventsScrollView setScrollEnabled:YES];
        
        [self.view addSubview:self.upcomingEventsScrollView];
        
        self.upcomingEventsScrollView.contentSize = CGSizeMake(self.upcomingEventsScrollView.frame.size.width * imagesCount, self.upcomingEventsScrollView.frame.size.height);
        
        AJGAsyncImageView *imageView = [[AJGAsyncImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 100.0)];
        [self.upcomingEventsScrollView addSubview:imageView];
        
        [imageView setupActivityIndicatorAtCenter:imageView.center];
    }
    else
    {
        [self.upcomingEventsScrollView removeFromSuperview];
        self.upcomingEventsScrollView = nil;
        self.upcomingEventsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 100.0f)];
        [self.upcomingEventsScrollView setPagingEnabled:YES];
        [self.upcomingEventsScrollView setScrollEnabled:YES];
        
        [self.view addSubview:self.upcomingEventsScrollView];
        
        self.upcomingEventsScrollView.contentSize = CGSizeMake(self.upcomingEventsScrollView.frame.size.width * imagesCount, self.upcomingEventsScrollView.frame.size.height);
        
        for (int i = 0; i < imagesCount; i++)
        {
            CGRect frame;
            frame.origin.x = self.upcomingEventsScrollView.frame.size.width * i;
            frame.origin.y = 0;
            frame.size = self.upcomingEventsScrollView.frame.size;
            
            // Should refactor this into a view controller with these items
            AJGAsyncImageView *imageView = [[AJGAsyncImageView alloc] initWithFrame:frame];
            [self.upcomingEventsScrollView addSubview:imageView];
            
            [imageView beginLoadingImageFromURL:[self.eventImages objectAtIndex:i]];
            
            UIButton *websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [websiteButton setFrame:imageView.frame];
            [websiteButton setTag:i];
            [websiteButton addTarget:self
                              action:@selector(handleWebsiteButtonTouchUpInside:)
                    forControlEvents:UIControlEventTouchUpInside];
            
            [self.upcomingEventsScrollView addSubview:websiteButton];
        }
        
        // Automatically Scroll
        [NSTimer scheduledTimerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(autoScrollUpcomingEvents)
                                       userInfo:nil
                                        repeats:YES];
    }
}

- (void) autoScrollUpcomingEvents
{
    CGFloat contentOffset = self.upcomingEventsScrollView.contentOffset.x;
    
    int nextPage = (int)(contentOffset/self.upcomingEventsScrollView.frame.size.width) + 1 ;
    
    if( nextPage!=self.eventImages.count)
    {
        [self.upcomingEventsScrollView scrollRectToVisible:CGRectMake(nextPage*self.upcomingEventsScrollView.frame.size.width, 0, self.upcomingEventsScrollView.frame.size.width, self.upcomingEventsScrollView.frame.size.height) animated:YES];
    }
    else
    {
        [self.upcomingEventsScrollView scrollRectToVisible:CGRectMake(0, 0, self.upcomingEventsScrollView.frame.size.width, self.upcomingEventsScrollView.frame.size.height) animated:YES];
    }
}

#pragma mark - Website Button handler
- (void) handleWebsiteButtonTouchUpInside:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSInteger tag = [button tag];
    
    HBGCUpcomingEventsObject *currentEvent = (HBGCUpcomingEventsObject*)[self.upcomingEvents objectAtIndex:tag];
    [[UIApplication sharedApplication] openURL:currentEvent.website];
}


@end
