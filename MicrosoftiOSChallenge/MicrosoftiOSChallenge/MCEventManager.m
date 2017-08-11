//
//  MCEventManager.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 10/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCEventManager.h"
#import "MCEventData.h"
@implementation MCEventManager

static MCEventManager *currentInstance = nil;

+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentInstance = [[MCEventManager alloc] init];
    });
    return currentInstance;
}

+ (NSDictionary *)getEventDictionary{

    return [[MCEventManager sharedInstance] eventDictionary];
}
-(NSDictionary *)eventDictionaryWithDateKeyUsingEventArray:(NSArray *)eventArray{

    NSMutableDictionary *eventDictionary = [@{} mutableCopy];
    for (MCEventData *event in eventArray) {
        
        if (eventDictionary[event.eventDateKey]) {
            NSMutableArray *events = [eventDictionary[event.eventDateKey] mutableCopy];
            [events addObject:event];
            
            NSArray *sortedList = [events sortedArrayUsingComparator: ^(MCEventData *event1, MCEventData *event2) {
                return [event1.startTime compare:event2.startTime];
            }];
            eventDictionary[event.eventDateKey] = sortedList;

        }else{
            eventDictionary[event.eventDateKey] = @[event];

        }
    }
    
    return eventDictionary;
}

-(void)setEventArray:(NSArray *)eventArray{

    _eventArray = eventArray;
    self.eventDictionary = [self eventDictionaryWithDateKeyUsingEventArray:eventArray];
}
@end
