//
//  MCEventManager.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 10/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCEventManager : NSObject

@property(nonatomic, strong) NSArray *eventArray;
@property(nonatomic, strong) NSDictionary *eventDictionary;
-(NSDictionary *)eventDictionaryWithDateKeyUsingEventArray:(NSArray *)eventArray;
+ (instancetype)sharedInstance;
+ (NSDictionary *)getEventDictionary;
@end
