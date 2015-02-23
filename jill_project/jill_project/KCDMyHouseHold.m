//
//  KCDMyHouseHold.m
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/23/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDMyHouseHold.h"

@interface  KCDMyHouseHold ()

@end

@implementation KCDMyHouseHold

- (id)init
{
    self = [super init];
    self.allQuerry = [[NSMutableArray alloc]init];
    self.userQuerry = [[NSMutableArray alloc]init];
    self.houseHold = [[NSDictionary alloc]init];
    self.typeNotification = [[NSString alloc]init];
    return self;
}

-(void)populateNotifications{
    [self.userQuerry removeAllObjects];
    for(NSDictionary* dict in self.allQuerry){
        if([[dict objectForKey:@"type"] isEqualToString:self.typeNotification]){
            [self.userQuerry addObject:dict];
        }
    }
}

+(instancetype) sharedModel{
    static KCDMyHouseHold *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
        
    });
    return _sharedModel;
}

@end