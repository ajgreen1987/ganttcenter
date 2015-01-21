//
//  HBGCSocialRegionViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/7/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCSocialRegionViewController.h"
#import "HBGCSocialZoneObject.h"
#import "HBGCSocialNetworksObject.h"
#import "AJGAsyncImageView.h"

@interface HBGCSocialRegionViewController ()

@property (nonatomic, weak) IBOutlet UITableView *socialTableView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) HBGCSocialZoneObject *zone;

@end

@implementation HBGCSocialRegionViewController



- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andZone:(HBGCSocialZoneObject *)aZone
{
        NSString *nibName = [HBGCApplicationManager isSmallScreenDevice] ? HBGCSOCIALREGION_NIB_SMALL : HBGCSOCIALREGION_NIB;
        self = [super initWithNibName:nibName
                               bundle:nil];
    
    self.zone = aZone;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    if ([HBGCApplicationManager isSmallScreenDevice])
    {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Post to Social
- (IBAction) handleEmailTouchUpInside:(id)sender
{
    for (HBGCSocialNetworksObject *network in self.zone.socialNetworks)
    {
        if (network.typeOfNetwork == Email)
        {
            [HBGCApplicationManager launchURL:network.networkURL
                           orShowErrorMessage:@"Email is unavailble"];
            break;
        }
    }
}

- (IBAction) handleFacebookTouchUpInside:(id)sender
{
    for (HBGCSocialNetworksObject *network in self.zone.socialNetworks)
    {
        if (network.typeOfNetwork == Facebook)
        {
            [HBGCApplicationManager launchURL:network.networkURL
                           orShowErrorMessage:@"Facebook is unavailble"];
            break;
        }
    }
}

- (IBAction) handleTwitterTouchUpInside:(id)sender
{
    for (HBGCSocialNetworksObject *network in self.zone.socialNetworks)
    {
        if (network.typeOfNetwork == Twitter)
        {
            [HBGCApplicationManager launchURL:network.networkURL
                           orShowErrorMessage:@"Twitter is unavailble"];
            break;
        }
    }
}

- (IBAction) handleYouTubeTouchUpInside:(id)sender
{
    for (HBGCSocialNetworksObject *network in self.zone.socialNetworks)
    {
        if (network.typeOfNetwork == Youtube)
        {
            [HBGCApplicationManager launchURL:network.networkURL
                           orShowErrorMessage:@"Youtube is unavailble"];
            break;
        }
    }
}

- (IBAction) handleDismissTouchUpInside:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
