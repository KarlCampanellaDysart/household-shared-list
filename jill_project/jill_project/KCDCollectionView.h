//
//  UIViewController+KCDLoginTableView.h
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCDCollectionCellView.h"
#import "KCDTableViewController.h"
#import "KCDMyHouseHold.h"

@interface KCDCollectionView : UICollectionViewController

@property (strong, nonatomic) NSMutableArray * relavantNotifications;
@property (strong, nonatomic) KCDMyHouseHold * userHouseHold;

@end
