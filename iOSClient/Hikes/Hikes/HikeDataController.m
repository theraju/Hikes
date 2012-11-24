//
//  HikeDataController.m
//  Hikes
//
//  Created by theraju on 11/23/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import "HikeDataController.h"
#import "Hike.h"

@interface HikeDataController ()
- (void)initializeDefaultDataList;
@end

@implementation HikeDataController
- (void)initializeDefaultDataList {
    NSMutableArray *hikeList = [[NSMutableArray alloc] init];
    self.masterHikeList = hikeList;
}

- (void) setMasterHikeList:(NSMutableArray *)masterHikeList {
    if (_masterHikeList != masterHikeList) {
        _masterHikeList = [masterHikeList mutableCopy];
    }
}

- (id) init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    
    return nil;
}

- (NSUInteger) countOfList {
    return [self.masterHikeList count];
}

- (Hike *) objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterHikeList objectAtIndex:theIndex];
}

- (void) addHike:(Hike *)hike {
    [self.masterHikeList addObject:hike];
}

-(void)clear {
    [self.masterHikeList removeAllObjects];
}
@end
