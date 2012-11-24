//
//  HikeViewController.h
//  Hikes
//
//  Created by theraju on 11/10/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HikeSearchCriteriaViewController : UIViewController
- (IBAction)searchHikes:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *maxElevation;
@property (weak, nonatomic) IBOutlet UILabel *currentRating;
@property (weak, nonatomic) IBOutlet UILabel *currentDistance;
@property (weak, nonatomic) IBOutlet UILabel *currentElevation;
@property (weak, nonatomic) IBOutlet UISlider *ratingSlider;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UISlider *elevationSlider;

@property (weak, nonatomic) IBOutlet UILabel *maxDistance;
@end
