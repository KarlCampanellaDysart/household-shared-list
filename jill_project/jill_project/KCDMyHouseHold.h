//
//  Header.h
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/23/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCDMyHouseHold : NSObject

@property (strong, nonatomic) NSDictionary * houseHold;
@property (strong, nonatomic) NSMutableArray * allQuerry;
@property (strong, nonatomic) NSString * typeNotification;
@property (strong, nonatomic) NSMutableArray * userQuerry;

+ (instancetype) sharedModel;
-(void)populateNotifications;

@end