//
//  MCMappingData.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCMappingData.h"
#import "MCEventData.h"
#import "MCParticipantData.h"
#import "MCWeatherData.h"

@implementation MCMappingData

/**
 *  Mapping information for Events Request
 *
 *  @param entriesDictionary input response data
 *
 *  @return mapped object
 */
//+ (id)mappedObjectForEventRequestWithEntriesDictionary:(NSDictionary *)entriesDictionary{
//
//    
//    NSArray *values = entriesDictionary[@"value"];
//    
//    NSMutableArray *eventArray = [@[] mutableCopy];
//    
//    for (NSDictionary *eventDictionary in values) {
//
//        [eventArray addObject:[MCMappingData mappedObjectForEventDataWithEntriesDictionary:eventDictionary]];
//    }
//    return eventArray;
//}
+ (id)mappedObjectForEventRequestWithEntriesDictionary:(NSDictionary *)entriesDictionary{
    
    
    NSArray *values = entriesDictionary[@"value"];
    NSMutableDictionary *eventDictionary = [@{} mutableCopy];
    for (NSDictionary *eventItem in values) {
        
        
        MCEventData *event = [MCMappingData mappedObjectForEventDataWithEntriesDictionary:eventItem];
        
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
    
    NSArray *attendees = entriesDictionary[@"Attendees"];
    
    NSMutableArray *attendeeList = [@[] mutableCopy];
    for (NSDictionary *attendee in attendees) {
        
        [attendeeList addObject:[MCMappingData mappedObjectForAttendiesEntriesDictionary:attendee]];
    }
    eventData.attendees = [attendeeList copy];
    
    NSTimeInterval timeIntervalBetweenDates = [eventData.endTime timeIntervalSinceDate:eventData.startTime];
    NSInteger secondsInAnHour = 3600;
    NSInteger hours = timeIntervalBetweenDates / secondsInAnHour;
    NSInteger minutes = ((NSInteger)timeIntervalBetweenDates % secondsInAnHour)/60;
    if (minutes == 0) {
        eventData.duration = [NSString stringWithFormat:@"%ldh", (long)hours];

    }else{
        eventData.duration = [NSString stringWithFormat:@"%ldh %ldm", (long)hours, minutes];

    }

    return eventData;
}

+ (id)mappedObjectForAttendiesEntriesDictionary:(NSDictionary *)entriesDictionary{
    
    MCParticipantData *participant = [MCParticipantData new];
    participant.type = entriesDictionary[@"Type"];
    participant.name = entriesDictionary[@"EmailAddress"][@"Name"];
    participant.email = entriesDictionary[@"EmailAddress"][@"Address"];
    return participant;
}

+ (id)mappedObjectForWeatherRequestWithEntriesDictionary:(NSDictionary *)entriesDictionary{

    NSMutableDictionary *weatherDataDictionary = [@{} mutableCopy];

    for (NSDictionary *entry in entriesDictionary[@"daily"][@"data"]) {
        
        MCWeatherData *weatherData = [MCMappingData mappedObjectForWeatherEntriesDictionary:entry];
        
        weatherDataDictionary[weatherData.timeKey] = weatherData;
    }
    return weatherDataDictionary;
}
+ (id)mappedObjectForWeatherEntriesDictionary:(NSDictionary *)entriesDictionary{
    
    MCWeatherData *weatherData = [MCWeatherData new];
    
    NSDateFormatter *dateFormatter = ({
        NSDateFormatter *currentdateFormatter = [[NSDateFormatter alloc] init];
        currentdateFormatter.dateFormat = @"ddMMyyyy";
        currentdateFormatter;
    });
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[entriesDictionary[@"time"] longLongValue]];

    weatherData.time = date;
    weatherData.timeKey = [dateFormatter stringFromDate:weatherData.time];
    weatherData.summary = entriesDictionary[@"summary"];
    weatherData.iconName = entriesDictionary[@"icon"];
    weatherData.minTemerature = [NSString stringWithFormat:@"%d",[entriesDictionary[@"temperatureMin"] intValue]];
    weatherData.maxTemperature = [NSString stringWithFormat:@"%d",[entriesDictionary[@"temperatureMax"] intValue]];

    return weatherData;
}


@end
