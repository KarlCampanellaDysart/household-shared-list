//
//  UIViewController+KCDTableViewController.h
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "KCDMyHouseHold.h"

@interface KCDTableViewController : UIViewController <UIAlertViewDelegate>

//table view
@property (strong, nonatomic) UITableView * tableView;
- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView;
- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section;
- (UITableViewCell *) tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath;
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) KCDMyHouseHold * userHouseHold;
-(void)updateNotifications;

@end
