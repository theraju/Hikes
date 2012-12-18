//
//  Hike.h
//  Hikes
//
//  Created by theraju on 11/23/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hike : NSObject
@property (nonatomic, readonly) int id; // might have to change this to something that supports bigint
@property (nonatomic, copy) NSString *name;
@property (nonatomic, readonly) float distance;
@property (nonatomic, readonly) int elevation;
@property (nonatomic) bool hasDetails;
@property (nonatomic, copy) NSString *photoUrl;
@property (nonatomic) float avgRating;
@property (nonatomic, copy) NSString *description;
-(id) initWithId: (long) id name:(NSString *)name distance:(float) distance elevation:(int)elevation;
@end
