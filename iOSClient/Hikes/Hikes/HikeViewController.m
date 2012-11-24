//
//  HikeViewController.m
//  Hikes
//
//  Created by theraju on 11/10/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import "HikeViewController.h"
#import "HikeSearchCriteria.h"
#import "HikeSearchResultsViewController.h"

@interface HikeSearchCriteriaViewController ()

@end

@implementation HikeSearchCriteriaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    float maxDistance = [[self.maxDistance text] floatValue];
    float maxElevation = [[self.maxElevation text] floatValue];
    int middleDistance = (maxDistance) / 2;
    int middleElevation = (maxElevation) / 2;
    
    [self.currentRating setText:@"3"];
    [self.currentDistance setText: [NSString stringWithFormat: @"%d", middleDistance]];
    [self.currentElevation setText: [NSString stringWithFormat: @"%d", middleElevation]];
    
    self.ratingSlider.minimumValue = 0;
    self.ratingSlider.maximumValue = 5;
    self.ratingSlider.value = 3;
    
    self.distanceSlider.minimumValue = 0;
    self.distanceSlider.maximumValue = maxDistance;
    self.distanceSlider.value = middleDistance;
    
    self.elevationSlider.minimumValue = 0;
    self.elevationSlider.maximumValue = maxElevation;
    self.elevationSlider.value = middleElevation;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) sliderChanged:(id) sender{
    UISlider *slider = (UISlider *) sender;
    if (slider == self.ratingSlider) {
        self.currentRating.text = [NSString stringWithFormat:@"%d", (int)slider.value];
    }
    else if (slider == self.distanceSlider) {
        self.currentDistance.text = [NSString stringWithFormat:@"%d", (int)slider.value];
    }
    else if (slider == self.elevationSlider) {
        self.currentElevation.text = [NSString stringWithFormat:@"%d", (int)slider.value];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ShowSearchResults"])
    {
        HikeSearchCriteria *h = [[HikeSearchCriteria alloc] init];
        h.ratingGreaterThan = [self.currentRating.text intValue];
        h.distanceLessThan = [self.currentDistance.text intValue];
        h.elevationGainLessThan = [self.currentElevation.text intValue];
        
        HikeSearchResultsViewController *searchResultsViewController =
        [segue destinationViewController];
        [searchResultsViewController setHikeSearchCriteria:h];
    }
    
}
@end
