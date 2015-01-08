//
//  HBGCBeaconZonesViewController.h
//  Gantt Center
//
//  Created by AJ Green on 12/2/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <UIKit/UICollectionView.h>

#define HBGCBeaconZones_NIB @"HBGCBeaconZonesViewController"
#define HBGCBeaconZones_Small_NIB @"HBGCBeaconZonesViewController_Small"

@interface HBGCBeaconZonesViewController : UIViewController <UICollectionViewDataSource,
                                UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, HBGCBeaconManagerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
