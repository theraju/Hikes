//
//  Hike.m
//  Hikes
//
//  Created by theraju on 11/23/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import "Hike.h"

@implementation Hike
-(id)initWithId: (long) hikeId name:(NSString *)name distance:(float)distance elevation:(int)elevation {
    self = [super init];
    if (self) {
        _id = hikeId;
        _name = name;
        _distance = distance;
        _elevation = elevation;
        _hasDetails = false;
        return self;
    }
    
    return nil;
}
@end
