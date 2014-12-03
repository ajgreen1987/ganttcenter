//
//  HBGCBeaconZonesViewController.h
//  Gantt Center
//
//  Created by AJ Green on 12/2/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HBGCBeaconZones_NIB @"HBGCBeaconZonesViewController"

@interface HBGCBeaconZonesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
