//
//  HikeSearchResultsViewController.h
//  Hikes
//
//  Created by theraju on 11/12/12.
//  Copyright (c) 2012 theraju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HikeSearchCriteria.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@class HikeDataController;

@interface HikeSearchResultsViewController : UITableViewController {
NSArray *_tableViewArray;
}

@property (nonatomic, retain) NSArray *tableViewArray;
@property (nonatomic, retain) HikeSearchCriteria *hikeSearchCriteria;
@property (nonatomic, strong) HikeDataController *hikeDataController;
@end
