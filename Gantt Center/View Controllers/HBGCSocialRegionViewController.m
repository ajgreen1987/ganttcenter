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
@property (nonatomic, strong) HBGCSocialZoneObject *zone;

@end

@implementation HBGCSocialRegionViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andZone:(HBGCSocialZoneObject *)aZone
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    self.zone = aZone;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableview Data Source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.zone.socialNetworks.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cells";
    
    UITableViewCell *toReturn = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (toReturn == nil)
    {
        toReturn = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:identifier];
        
        [toReturn setBackgroundColor:[UIColor clearColor]];
        
        AJGAsyncImageView *image = [[AJGAsyncImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 100.0f)];
        
        [[toReturn contentView] addSubview:image];
        
        HBGCSocialNetworksObject *network = (HBGCSocialNetworksObject*)[self.zone.socialNetworks objectAtIndex:indexPath.row];
        
        [image beginLoadingImageFromURL:network.thumbnail];
    }
    
    return toReturn;
}

#pragma mark - UITableview Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBGCSocialNetworksObject *network = (HBGCSocialNetworksObject*)[self.zone.socialNetworks objectAtIndex:indexPath.row];
    
    [[UIApplication sharedApplication] openURL:network.networkURL];
}

@end
