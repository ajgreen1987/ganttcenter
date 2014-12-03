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

#define COLUMN_LENGTH 3
#define ROW_LENGTH 2

@interface HBGCBeaconZonesViewController ()

@property (nonatomic, strong) NSMutableArray *zoneThumbnails;

@end

@implementation HBGCBeaconZonesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(buildOutUpcomingEventsViewController)
                                                 name:NOTIFICATION_PARSED_JSON
                                               object:nil];
     */
    
    self.zoneThumbnails = [[NSMutableArray alloc] initWithObjects:
                           @[@"http://upload.wikimedia.org/wikipedia/commons/7/71/Weaved_truncated_square_tiling.png",
                             @"http://upload.wikimedia.org/wikipedia/commons/7/71/Weaved_truncated_square_tiling.png"],
                           @[@"http://upload.wikimedia.org/wikipedia/commons/7/71/Weaved_truncated_square_tiling.png",
                             @"http://upload.wikimedia.org/wikipedia/commons/7/71/Weaved_truncated_square_tiling.png"],
                           @[@"http://upload.wikimedia.org/wikipedia/commons/7/71/Weaved_truncated_square_tiling.png",
                             @"http://upload.wikimedia.org/wikipedia/commons/7/71/Weaved_truncated_square_tiling.png"],nil];
    
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
    
    
    [cell.imageView beginLoadingImageFromURL:[images objectAtIndex:row]];
    
    [cell setBackgroundColor:[UIColor grayColor]];
    
    return cell;
}

@end
