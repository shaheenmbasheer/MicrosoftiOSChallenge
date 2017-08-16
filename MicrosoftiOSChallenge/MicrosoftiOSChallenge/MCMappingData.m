//
//  MCMappingData.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCMappingData.h"
#import "MCDataModels.h"

@implementation MCMappingData

/**
 Mapping information for Event Request
 
 @param entriesDictionary parsed event response dictionary
 @return nsdictionary of mapped event data
 */
+ (id)mappedObjectForEventRequestWithEntriesDictionary:(NSDictionary *)entriesDictionary{
    
    
    NSArray *values = entriesDictionary[@"value"];
    NSMutableDictionary *eventDictionary = [@{} mutableCopy];
    for (NSDictionary *eventItem in values) {
        //For each event in values, map event to MCEventData
        MCEventData *event = [MCMappingData mappedObjectForEventDataWithEntriesDictionary:eventItem];
        if (eventDictionary[event.eventDateKey]) {
            //If event is already present for the date
            NSMutableArray *events = [eventDictionary[event.eventDateKey] mutableCopy];
            [events addObject:event];
            //Sort multiple events for the date according to event startTime.
            NSArray *sortedList = [events sortedArrayUsingComparator: ^(MCEventData *event1, MCEventData *event2) {
                return [event1.startTime compare:event2.startTime];
            }];
            eventDictionary[event.eventDateKey] = sortedList;
        }else{
            //If event is not present for the date, add event.
            eventDictionary[event.eventDateKey] = @[event];
            
        }
    }
    
    return eventDictionary;
    
}


/**
 Mapping information for MCEventData

 @param entriesDictionary json response for event data.
 @return MCEventData object
 */
+ (id)mappedObjectForEventDataWithEntriesDictionary:(NSDictionary *)entriesDictionary{
    
    MCEventData *eventData = [MCEventData new];
    eventData.subject = entriesDictionary[@"Subject"];
    eventData.bodyPreview = entriesDictionary[@"BodyPreview"];
    eventData.importance = entriesDictionary[@"Importance"];
    
    //Date formatter for converting starttime and endTime to NSDate.
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
    //Get each attendee object for event data.
    for (NSDictionary *attendee in attendees) {
        //Get mapped attendee from list of attendees.
        [attendeeList addObject:[MCMappingData mappedObjectForAttendiesEntriesDictionary:attendee]];
    }
    eventData.attendees = [attendeeList copy];
    
    //Event duration calculation.
    NSTimeInterval timeIntervalBetweenDates = [eventData.endTime timeIntervalSinceDate:eventData.startTime];
    NSInteger secondsInAnHour = 3600;
    NSInteger hours = timeIntervalBetweenDates / secondsInAnHour;
    NSInteger minutes = ((NSInteger)timeIntervalBetweenDates % secondsInAnHour)/60;
    if (minutes == 0) {
        //Hide minutes if minutes is not present.
        eventData.duration = [NSString stringWithFormat:@"%ldh", (long)hours];

    }else{
        eventData.duration = [NSString stringWithFormat:@"%ldh %ldm", (long)hours, (long)minutes];

    }
    return eventData;
}


/**
 Mapping information for attendee/participant

 @param entriesDictionary json response for participant
 @return MCParticipantData object
 */
+ (id)mappedObjectForAttendiesEntriesDictionary:(NSDictionary *)entriesDictionary{
    
    MCParticipantData *participant = [MCParticipantData new];
    participant.type = entriesDictionary[@"Type"];
    participant.name = entriesDictionary[@"EmailAddress"][@"Name"];
    participant.email = entriesDictionary[@"EmailAddress"][@"Address"];
    return participant;
}

/**
 Mapping information for Weather Request
 
 @param entriesDictionary parsed weather response dictionary
 @return nsdictionary of mapped weather data
 */
+ (id)mappedObjectForWeatherRequestWithEntriesDictionary:(NSDictionary *)entriesDictionary{

    NSMutableDictionary *weatherDataDictionary = [@{} mutableCopy];

    for (NSDictionary *entry in entriesDictionary[@"daily"][@"data"]) {

        MCWeatherData *weatherData = [MCMappingData mappedObjectForWeatherEntriesDictionary:entry];
        weatherDataDictionary[weatherData.timeKey] = weatherData;
    }
    return weatherDataDictionary;
}


/**
 Mapping information for weather entries

 @param entriesDictionary json response for weather data
 @return MCWeatherData object
 */
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
    weatherData.minTemperature = [NSString stringWithFormat:@"%d",[entriesDictionary[@"temperatureMin"] intValue]];
    weatherData.maxTemperature = [NSString stringWithFormat:@"%d",[entriesDictionary[@"temperatureMax"] intValue]];

    return weatherData;
}


@end
