//
//  HikeDetailViewController.m
//  Hikes
//
//  Created by theraju on 11/25/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import "HikeDetailViewController.h"
#import "Hike.h"
//
@implementation HikeDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scroller setScrollEnabled:YES];
    //[self.scroller setContentSize:CGSizeMake(320,1000)];
    [self.scroller setShowsVerticalScrollIndicator:YES];
    
    self.waitForHikeDetails.hidden = false;
    self.waitForHikeDetails.hidesWhenStopped = true;
    [self.waitForHikeDetails startAnimating];
    if (self.hike.hasDetails == false) {
        NSString *endpoint = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey: @"Server"];
        NSMutableString *urlString = [NSMutableString stringWithString:endpoint];
        [urlString appendString: @"trail/show?"];
    [urlString appendFormat: @"id=%d", self.hike.id];
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithString: urlString]];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: url];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    }
    else
    {
        [self displayData];
    }

}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* jsonDict = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    [self.waitForHikeDetails stopAnimating];
    //populate hikeDataController
    if (!jsonDict) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        self.hike.avgRating = [[self getStringFrom: jsonDict withKey:@"avg_rating" fallbackTo:@"0"] floatValue];
        self.hike.description = [self getStringFrom: jsonDict withKey:@"description" fallbackTo:@"No description available"];
        self.hike.photoUrl = [self getStringFrom:jsonDict withKey:@"photo_url" fallbackTo:@""];
        self.hike.hasDetails = true;
        [self displayData];
    }
}

- (void)fetchedImage:(NSData *)responseData {
    UIImage *image = [[UIImage alloc] initWithData: responseData];
    self.hikeImage.image = image;
    [self.hikeImage setNeedsDisplay];
}

-(void) displayData {
    self.hikeDistance.text = [NSString stringWithFormat:@"%.02f miles", self.hike.distance];
    self.hikeElevationGain.text = [NSString stringWithFormat:@"%d feet", self.hike.elevation];
    //TODO: set hike rating
    
    if (self.hike.photoUrl.length > 0) {
        NSURL *url = [NSURL URLWithString: [NSString stringWithString: self.hike.photoUrl]];
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL: url];
            [self performSelectorOnMainThread:@selector(fetchedImage:)
                                   withObject:data waitUntilDone:YES];
        });
    }
    
    NSString *trimmedDescription = [self.hike.description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    self.hikeDescription.text = trimmedDescription;
    CGRect frame = _hikeDescription.frame;
    frame.size.height = _hikeDescription.contentSize.height;
    _hikeDescription.frame = frame;
    
    [self.scroller setContentSize: CGSizeMake(self.hikeDescription.frame.origin.x + self.hikeDescription.frame.size.width,
                                              self.hikeDescription.frame.origin.y + self.hikeDescription.frame.size.height)];
    [self.view setNeedsDisplay];
    /*UIScrollView *tempScrollView = (UIScrollView *)self.view;
    tempScrollView.contentSize = CGSizeMake(self.hikeDescription.frame.origin.y + self.hikeDescription.frame.size.height,
                                            self.hikeDescription.frame.origin.x + self.hikeDescription.frame.size.width);
    [self.view setNeedsDisplay];*/
}

- (NSString *)getStringFrom:(NSDictionary *)dict withKey:(NSString *) key fallbackTo:(NSString *) fallback {
    id result = [dict objectForKey: key];
    
    if (!result)
        result = fallback;
    else if (![result isKindOfClass: [NSString class]])
        result = [result description];
    
    return result;
}
@end
