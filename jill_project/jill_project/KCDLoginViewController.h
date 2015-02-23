//
//  ViewController.h
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/23/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ApigeeiOSSDK/Apigee.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "KCDCollectionView.h"
#import "KCDMyHouseHold.h"

@interface KCDLoginViewController : UIViewController <CLLocationManagerDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

//location stuff
@property (strong,nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic)CLLocation* location;
@property (strong,nonatomic ) NSNumber * latitude;
@property (strong,nonatomic ) NSNumber * longitude;

-(void)getEntityWithName: (NSString *)name;
-(void) newEntityWithPass:(NSString *) pass;

//table view
@property (strong, nonatomic) UITableView * tableView;
- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView;
- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section;
- (UITableViewCell *) tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath;
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) NSArray * userQuerry;
@property (strong, nonatomic) KCDMyHouseHold * userHouseHold;

@end

