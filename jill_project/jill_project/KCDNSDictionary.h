//
//  NSMutableDictionary+KCDNSDictionary.h
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/23/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCDNSDictionary : NSMutableDictionary

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress;
-(NSData*)toJSON;

@end
