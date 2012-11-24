//
//  HikeDataController.h
//  Hikes
//
//  Created by theraju on 11/23/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Hike;

@interface HikeDataController : NSObject
@property (nonatomic, copy) NSMutableArray *masterHikeList;
- (NSUInteger)countOfList;
- (Hike *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addHike:(Hike *)hike;
- (void)clear;
@end
