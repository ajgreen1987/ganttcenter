//
//  HBGCBeaconZonesViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/2/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCBeaconZonesViewController.h"
#import "HBGCZoneCollectionViewCell.h"
#import "AJGAsyncImageView.h"
#import "HBGCZoneObject.h"
#import "HBGCSocialZoneObject.h"
#import "HBGCRegionViewController.h"

#define COLUMN_LENGTH 3
#define ROW_LENGTH 2

@interface HBGCBeaconZonesViewController ()

@property (nonatomic, strong) NSMutableArray *zoneThumbnails;

@end

@implementation HBGCBeaconZonesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.zoneThumbnails = [[NSMutableArray alloc] initWithObjects:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(buildOutZones)
                                                 name:NOTIFICATION_PARSED_JSON
                                               object:nil];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parse out zone
- (void) buildOutZones
{
    NSArray *zones = [[HBGCApplicationManager appManager] currentZones];
    NSMutableArray *intermediateThumbnail = [[NSMutableArray alloc] initWithObjects:nil];
    
    for (NSDictionary *dictionary in zones)
    {
        if ([[dictionary allKeys] containsObject:SOCIAL_KEY])
        {
            HBGCSocialZoneObject *socialZone = [[HBGCSocialZoneObject alloc] initWithDictionary:dictionary];
            
            [intermediateThumbnail addObject:socialZone];
        }
        else
        {
            HBGCZoneObject *zone = [[HBGCZoneObject alloc] initWithDictionary:dictionary];
            
            [intermediateThumbnail addObject:zone];
        }
    }
    
    for (int i=0; i<intermediateThumbnail.count; i++)
    {
        if (i%2==0)
        {
            NSMutableArray *toAddTo = [[NSMutableArray alloc] initWithObjects:nil];
            
            [toAddTo addObject:[intermediateThumbnail objectAtIndex:i]];
            
            [self.zoneThumbnails addObject:toAddTo];
        }
        else
        {
            NSInteger lastIndex = i-1;
            [[self.zoneThumbnails objectAtIndex:lastIndex] addObject:[intermediateThumbnail objectAtIndex:i]];
        }
    }
    
    [[self collectionView] reloadData];

}

#pragma mark - UICollectionView Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.zoneThumbnails.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ROW_LENGTH;
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
    
    
    [cell.imageView beginLoadingImageFromURL:zone.thumbnail];
    
    return cell;
}

#pragma mark - UICollectionView Delegate
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSArray *images = [self.zoneThumbnails objectAtIndex:section];
    HBGCZoneObject *zone = (HBGCZoneObject*)[images objectAtIndex:row];
    
    HBGCRegionViewController *region = [[HBGCRegionViewController alloc] initWithNibName:HBGCRegion_NIB
                                                                                  bundle:nil
                                                                                 andZone:zone];
    
    [[self navigationController] pushViewController:region
                                           animated:YES];
}

@end
