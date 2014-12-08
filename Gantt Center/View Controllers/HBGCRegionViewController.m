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

@interface HBGCRegionViewController ()


@property (nonatomic, assign) BOOL isTextExpanded;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UIButton *expandingButton;
@property (nonatomic, strong) HBGCZoneObject *zone;
@property (nonatomic, strong) UIScrollView *regionHeaderScrollView;
@property (nonatomic, strong) UIScrollView *regionContentScrollView;
@property (nonatomic, strong) UIPageControl *regionContentPageControl;

- (IBAction) handleExpandingButtonTouchUpInside:(id)sender;
- (void) setupRegionHeaderScroll;
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
    [self setupRegionContentScroll];
    
    [[self view] bringSubviewToFront:self.descriptionTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Region Header
- (void) setupRegionHeaderScroll
{
    self.regionHeaderScrollView = nil;
    self.regionHeaderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 60.0f, 320.0f, 100.0f)];
    [self.regionHeaderScrollView setPagingEnabled:YES];
    [self.regionHeaderScrollView setScrollEnabled:YES];
    
    [self.view addSubview:self.regionHeaderScrollView];
    
    self.regionHeaderScrollView.contentSize = CGSizeMake(self.regionHeaderScrollView.frame.size.width * self.zone.headerImages.count, self.regionHeaderScrollView.frame.size.height);
    
    for (int i = 0; i < self.zone.headerImages.count; i++)
    {
        CGRect frame;
        frame.origin.x = self.regionHeaderScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.regionHeaderScrollView.frame.size;
        
        // Should refactor this into a view controller with these items
        AJGAsyncImageView *imageView = [[AJGAsyncImageView alloc] initWithFrame:frame];
        [self.regionHeaderScrollView addSubview:imageView];
        
        [imageView beginLoadingImageFromURL:[self.zone.headerImages objectAtIndex:i]];
    }
    
    // Automatically Scroll
    [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(autoScrollRegionHeader)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) autoScrollRegionHeader
{
    [HBGCApplicationManager autoScrollScrollView:self.regionHeaderScrollView
                                  andMaxPageSize:self.zone.headerImages.count];
}

#pragma mark - Region Content
- (void) setupRegionContentScroll
{
    self.regionContentScrollView = nil;
    self.regionContentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 369.0f, 320.0f, 192.0f)];
    [self.regionContentScrollView setPagingEnabled:YES];
    [self.regionContentScrollView setScrollEnabled:YES];
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
        AJGAsyncImageView *imageView = [[AJGAsyncImageView alloc] initWithFrame:frame];
        [self.regionContentScrollView addSubview:imageView];
        
        HBGCContentObject *content = (HBGCContentObject*)[self.zone.content objectAtIndex:i];
        
        [imageView beginLoadingImageFromURL:[content thumbnail]];
        
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
                         CGRect frame = self.descriptionTextView.frame;
                         CGFloat missingHeight = (self.view.frame.size.height - 8.0f) - (self.descriptionTextView.frame.size.height*2.0f);
                         frame.size.height = self.isTextExpanded ? 175.0f : (missingHeight + frame.size.height);
                         self.descriptionTextView.frame = frame;
                         
                         self.isTextExpanded = !self.isTextExpanded;
                     }];
}

- (void) handleContentButtonTouchUpInside:(id)sender
{
    UIButton *touched = (UIButton*)sender;
    NSInteger tag = [touched tag];
    HBGCContentObject *content = [self.zone.content objectAtIndex:tag];
    
    NSURL *contentURL = content.contentURL;
    MPMoviePlayerViewController *movieController = [[MPMoviePlayerViewController alloc]
                                      initWithContentURL:contentURL];
    
    [self.navigationController presentMoviePlayerViewControllerAnimated:movieController];
    
}

@end
