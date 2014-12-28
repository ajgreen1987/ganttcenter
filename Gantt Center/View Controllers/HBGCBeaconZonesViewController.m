//
//  HBGCBeaconZonesViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/2/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCBeaconZonesViewController.h"
#import "HBGCZoneCollectionViewCell.h"
#import "HBGCZoneObject.h"
#import "HBGCSocialZoneObject.h"
#import "HBGCRegionViewController.h"
#import "HBGCSocialRegionViewController.h"
#import "HBGCBeaconObject.h"
#import "AJGAsyncImageView.h"


#define COLUMN_LENGTH 3
#define ROW_LENGTH 2

@interface HBGCBeaconZonesViewController ()

@property (nonatomic, strong) NSArray *zoneThumbnails;

- (void) makeSelfBeaconDelegate;

@end

@implementation HBGCBeaconZonesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.zoneThumbnails = [[NSArray alloc] initWithArray:[[HBGCApplicationManager appManager] zones]];
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self.collectionView registerClass:[HBGCZoneCollectionViewCell class]
            forCellWithReuseIdentifier:@"Zone"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setItemSize:CGSizeMake(160.0f, 160.0f)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    [[self collectionView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parse out zone
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self makeSelfBeaconDelegate];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[[HBGCApplicationManager appManager] beaconManager] setDelegate:nil];
}


#pragma mark - UICollectionView Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.zoneThumbnails.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *currentThumbnail = (NSArray*)[self.zoneThumbnails objectAtIndex:section];
    return currentThumbnail.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Zone";
    
    HBGCZoneCollectionViewCell *cell = (HBGCZoneCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                                                               forIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSArray *images = [self.zoneThumbnails objectAtIndex:section];
    HBGCZoneObject *zone = (HBGCZoneObject*)[images objectAtIndex:row];
    
    
    [cell.imageView setImage:zone.thumbnail];
    [cell.zoneTitle setText:zone.zoneTitle];
    
    return cell;
}

#pragma mark - UICollectionView Delegate
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectZoneForIndexPath:indexPath];
}

- (void) selectZoneForIndexPath:(NSIndexPath*)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSArray *images = [self.zoneThumbnails objectAtIndex:section];
    HBGCZoneObject *zone = (HBGCZoneObject*)[images objectAtIndex:row];
    
    if (![zone isKindOfClass:[HBGCSocialZoneObject class]])
    {
        HBGCRegionViewController *region = [[HBGCRegionViewController alloc] initWithNibName:HBGCRegion_NIB
                                                                                      bundle:nil
                                                                                     andZone:zone];
        
        
        
        [[self navigationController] pushViewController:region
                                               animated:YES];
    }
    else
    {
        // Push the Social View Controller!!!
        HBGCSocialRegionViewController *socialRegion = [[HBGCSocialRegionViewController alloc] initWithNibName:HBGCSOCIALREGION_NIB
                                                                                                        bundle:nil
                                                                                                       andZone:(HBGCSocialZoneObject*)zone];
        
        [self presentViewController:socialRegion
                           animated:YES
                         completion:nil];
    }
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
        for (NSArray *zoneArray in self.zoneThumbnails)
        {
            for (HBGCZoneObject *zone in zoneArray)
            {
                HBGCBeaconObject *beacon = zone.beacon;
                
                if ([[beacon majorID] isEqualToString:closestBeaconMajorID] && [[beacon minorID] isEqualToString:closestBeaconMinorID] && ([[closestBeacon distance] floatValue] < REGION_BEACON_DISTANCE))
                {
                    // Present the beacon for index Path
                    [self selectZoneForIndexPath:[NSIndexPath indexPathForRow:[zoneArray indexOfObject:zone]
                                                                    inSection:0]];
                }
            }
        }
    }
    
}

@end
