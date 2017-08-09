//
//  MCMappingData.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCMappingData.h"
#import "MCEventData.h"

@implementation MCMappingData

/**
 *  Mapping information for Events Request
 *
 *  @param entriesDictionary input response data
 *
 *  @return mapped object
 */
+ (id)mappedObjectForEventRequestWithEntriesDictionary:(NSDictionary *)entriesDictionary{

    
    NSArray *values = entriesDictionary[@"value"];
    
    NSMutableArray *eventArray = [@[] mutableCopy];
    
    for (NSDictionary *eventDictionary in values) {
        
        [eventArray addObject:[MCMappingData mappedObjectForEventDataWithEntriesDictionary:eventDictionary]];
    }
    return eventArray;
}


+ (id)mappedObjectForEventDataWithEntriesDictionary:(NSDictionary *)entriesDictionary{
    
    MCEventData *eventData = [MCEventData new];
    
    eventData.subject = entriesDictionary[@"Subject"];
    eventData.bodyPreview = entriesDictionary[@"BodyPreview"];
    eventData.importance = entriesDictionary[@"Importance"];
    
    NSDateFormatter *dateFormatter = ({
        NSDateFormatter *currentdateFormatter = [[NSDateFormatter alloc] init];
        currentdateFormatter.dateFormat = @"dd:MM:yyyy HH:mm:ss Z";
        currentdateFormatter;
    });
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];


    eventData.startTime = [dateFormatter dateFromString:entriesDictionary[@"Start"][@"DateTime"]];
    eventData.endTime = [dateFormatter dateFromString:entriesDictionary[@"End"][@"DateTime"]];

    eventData.location = ({
        NSString *location = entriesDictionary[@"Location"][@"DisplayName"];
        location;
    });
    
    [dateFormatter setDateFormat:@"ddMMyyyy"];

    eventData.eventDateKey = [dateFormatter stringFromDate:eventData.startTime];
    return eventData;
}
@end
