//
//  HBGCRegionViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCRegionViewController.h"
#import "HBGCZoneObject.h"
#import "HBGCHeaderObject.h"
#import "AJGAsyncImageView.h"
#import "HBGCContentObject.h"
#import "HBGCBeaconObject.h"

#define SCROLL_IMAGE_TAG 10001

@interface HBGCRegionViewController ()


@property (nonatomic, assign) BOOL isTextExpanded;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UIButton *expandingButton;
@property (nonatomic, strong) HBGCZoneObject *zone;
@property (nonatomic, strong) UIView *regionHeaderScrollView;
@property (nonatomic, strong) UIScrollView *regionContentScrollView;
@property (nonatomic, strong) UIPageControl *regionContentPageControl;
@property (nonatomic, strong) NSTimer *scrollTimer;
@property (nonatomic, assign) NSInteger imageCounter;

- (IBAction) handleExpandingButtonTouchUpInside:(id)sender;
- (IBAction) handleBackTouchUpInside:(id)sender;
- (void) setupRegionHeaderScroll;
- (void) setupRegionDescription;
- (void) setupRegionContentScroll;
- (void) autoScrollRegionHeader;
- (void) handleContentButtonTouchUpInside:(id)sender;

@end

@implementation HBGCRegionViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andZone:(HBGCZoneObject*)aZone
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.zone = aZone;
        self.isTextExpanded = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupRegionHeaderScroll];
    [self setupRegionDescription];
    [self setupRegionContentScroll];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self makeSelfBeaconDelegate];
    
    // Automatically Scroll
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:SCROLL_VIEW_ANIMATION_DURATION
                                                        target:self
                                                      selector:@selector(autoScrollRegionHeader)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[[HBGCApplicationManager appManager] beaconManager] setDelegate:nil];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self.scrollTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Region Header
- (void) setupRegionHeaderScroll
{
    self.regionHeaderScrollView = nil;
    self.regionHeaderScrollView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 196.0f)];
    [self.regionHeaderScrollView setUserInteractionEnabled:NO];
    
    [self.view addSubview:self.regionHeaderScrollView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.regionHeaderScrollView.frame];
    [[self regionHeaderScrollView] addSubview:image];
    [image setTag:SCROLL_IMAGE_TAG];
    
    self.imageCounter = 0;
    
    [image setImage:[[self.zone headerImages] objectAtIndex:self.imageCounter]];
    
    // Automatically Scroll
    [NSTimer scheduledTimerWithTimeInterval:FADE_ANIMATION_DURATION
                                     target:self
                                   selector:@selector(autoScrollRegionHeader)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) autoScrollRegionHeader
{
    UIImageView *scrollImage = (UIImageView*)[self.regionHeaderScrollView viewWithTag:SCROLL_IMAGE_TAG];
    UIImageView *scrollNextImage = [[UIImageView alloc] initWithFrame:scrollImage.frame];
    [scrollNextImage setTag:SCROLL_IMAGE_TAG];
    [scrollNextImage setImage:[[self.zone headerImages] objectAtIndex:self.imageCounter]];
    
    [self.regionHeaderScrollView insertSubview:scrollNextImage atIndex:0];
    
    [UIView animateWithDuration:FADE_IMAGE_DURATION
                     animations:^{
                         [scrollImage setAlpha:0.0f];
                     } completion:^(BOOL finished)
                    {
                         [scrollImage removeFromSuperview];
                        
                            self.imageCounter = (self.imageCounter == self.zone.headerImages.count-1) ? 0 : self.imageCounter+1;
                     }];
    
}

#pragma mark - Region Description
- (void) setupRegionDescription
{
    [[self view] bringSubviewToFront:self.descriptionTextView];
    
    [self.descriptionTextView setText:self.zone.zoneDescription];
    [self.descriptionTextView setTextColor:[UIColor whiteColor]];
}

#pragma mark - Region Content
- (void) setupRegionContentScroll
{
    self.regionContentScrollView = nil;
    self.regionContentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 389.0f, 320.0f, 180.0f)];
    [self.regionContentScrollView setPagingEnabled:YES];
    [self.regionContentScrollView setScrollEnabled:YES];
    [self.regionContentScrollView setBounces:NO];
    [self.regionContentScrollView setDelegate:self];
    
    [self.view addSubview:self.regionContentScrollView];
    
    self.regionContentPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f, 530.0f, 320.0f, 40.0f)];
    
    [self.regionContentPageControl setNumberOfPages:self.zone.content.count];
    [self.regionContentPageControl setCurrentPage:0.0f];
    
    [self.view addSubview:self.regionContentPageControl];
    
    self.regionContentScrollView.contentSize = CGSizeMake(self.regionContentScrollView.frame.size.width * self.zone.content.count, self.regionContentScrollView.frame.size.height);
    
    for (int i = 0; i < self.zone.content.count; i++)
    {
        CGRect frame;
        frame.origin.x = self.regionContentScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.regionContentScrollView.frame.size;
        
        // Should refactor this into a view controller with these items
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [self.regionContentScrollView addSubview:imageView];
        
        HBGCContentObject *content = (HBGCContentObject*)[self.zone.content objectAtIndex:i];
        
        [imageView setImage:[content thumbnail]];
        
        UIButton *websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [websiteButton setFrame:imageView.frame];
        [websiteButton setTag:i];
        [websiteButton addTarget:self
                          action:@selector(handleContentButtonTouchUpInside:)
                forControlEvents:UIControlEventTouchUpInside];
        
        [self.regionContentScrollView addSubview:websiteButton];
    }
}

#pragma mark - Scroll Delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.regionContentPageControl.currentPage = page;
}

#pragma mark - Button handler(s)
- (IBAction) handleExpandingButtonTouchUpInside:(id)sender
{
    [UIView animateWithDuration:1.1f
                     animations:^{
                         
                         self.regionContentPageControl.alpha = self.isTextExpanded ? 1.0f : 0.0f;
                         
                         CGRect frame = self.descriptionTextView.frame;
                         frame.size.height = self.isTextExpanded ? 128.0f : 320.0f;
                         self.descriptionTextView.frame = frame;
                         
                         CGRect contentFrame = self.regionContentScrollView.frame;
                         contentFrame.origin.y = self.isTextExpanded ? 389.0f : self.view.frame.size.height;
                         self.regionContentScrollView.frame = contentFrame;
                         
                         self.isTextExpanded = !self.isTextExpanded;
                     }];
}

- (IBAction) handleBackTouchUpInside:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)playContentFromURL:(NSURL *)contentURL
{
    MPMoviePlayerViewController *movieController = [[MPMoviePlayerViewController alloc]
                                                    initWithContentURL:contentURL];
    
    [[movieController view] setBounds:CGRectMake(0, 0, 480, 320)];
    [[movieController view] setCenter:CGPointMake(160, 240)];
    [[movieController view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    
    [self.navigationController presentMoviePlayerViewControllerAnimated:movieController];
}

- (void) handleContentButtonTouchUpInside:(id)sender
{
    UIButton *touched = (UIButton*)sender;
    NSInteger tag = [touched tag];
    HBGCContentObject *content = [self.zone.content objectAtIndex:tag];
    
    NSURL *contentURL = content.contentURL;
    [self playContentFromURL:contentURL];
    
}

#pragma mark - Beacon Delegate
- (void) makeSelfBeaconDelegate
{
    if (![[[HBGCApplicationManager appManager] beaconManager] isPrimed])
    {
        [[[HBGCApplicationManager appManager] beaconManager] setupBeaconManager];
    }
    
    // Delay execution of my block for 10 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [[[HBGCApplicationManager appManager] beaconManager] setDelegate:self];
    });
}

- (void) allBeaconsDiscovered
{
    if([[[HBGCApplicationManager appManager] beaconManager]beaconsArray].count > 0)
    {
        // The closest beacon will be at zero
        ESTBeacon *closestBeacon = (ESTBeacon*)[[[[HBGCApplicationManager appManager] beaconManager] beaconsArray] objectAtIndex:0];
        NSString *closestBeaconMajorID = [NSString stringWithFormat:@"%@",[closestBeacon major]];
        NSString *closestBeaconMinorID = [NSString stringWithFormat:@"%@",[closestBeacon minor]];
        
        // Compare the beacons to the zones beacon
        for (HBGCContentObject *content in self.zone.content)
        {
            HBGCBeaconObject *beacon = content.beacon;
            
            if ([[beacon majorID] isEqualToString:closestBeaconMajorID] && [[beacon minorID] isEqualToString:closestBeaconMinorID] && ([[closestBeacon distance] floatValue] < CONTENT_BEACON_DISTANCE))
            {
                // Create single method form button call for this
                NSURL *contentURL = content.contentURL;
                [self playContentFromURL:contentURL];
            }
        }
    }
}

@end
