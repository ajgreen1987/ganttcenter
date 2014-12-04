//
//  HBGCRegionViewController.m
//  Gantt Center
//
//  Created by AJ Green on 12/3/14.
//  Copyright (c) 2014 Gantt Center. All rights reserved.
//

#import "HBGCRegionViewController.h"
#import "HBGCZoneObject.h"

@interface HBGCRegionViewController ()


@property (nonatomic, assign) BOOL isTextExpanded;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UIButton *expandingButton;
@property (nonatomic, strong) HBGCZoneObject *zone;

- (IBAction) handleExpandingButtonTouchUpInside:(id)sender;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button handler(s)
- (IBAction) handleExpandingButtonTouchUpInside:(id)sender
{
    [UIView animateWithDuration:0.6f
                     animations:^{
                         CGRect frame = self.descriptionTextView.frame;
                         CGFloat missingHeight = (self.view.frame.size.height - 8.0f) - (self.descriptionTextView.frame.size.height*2.0f);
                         frame.size.height = self.isTextExpanded ? 175.0f : (missingHeight + frame.size.height);
                         self.descriptionTextView.frame = frame;
                         
                         self.isTextExpanded = !self.isTextExpanded;
                     }];
}

@end
