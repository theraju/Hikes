//
//  Hike.h
//  Hikes
//
//  Created by theraju on 11/23/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hike : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, readonly) float distance;
@property (nonatomic, readonly) int elevation;
-(id) initWithName:(NSString *)name distance:(float) distance elevation:(int)elevation;
@end
