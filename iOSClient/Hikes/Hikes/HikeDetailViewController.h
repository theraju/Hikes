//
//  HikeDetailViewController.h
//  Hikes
//
//  Created by theraju on 11/25/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Hike;
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface HikeDetailViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *hikeTitle;
@property (weak, nonatomic) IBOutlet UILabel *hikeDistance;
@property (weak, nonatomic) IBOutlet UIImageView *hikeImage;
@property (weak, nonatomic) IBOutlet UILabel *hikeElevationGain;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitForHikeDetails;
@property (weak, nonatomic) IBOutlet UITextView *hikeDescription;
@property (weak, nonatomic) IBOutlet UILabel *hikeDirections;
@property (nonatomic, retain) Hike *hike;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
-(void) setHikeForDisplay:(Hike *)hike;
@end
