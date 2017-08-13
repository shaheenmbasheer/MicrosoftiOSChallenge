//
//  MCEventData.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 10/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;
/**
 MCEventData is used to saved parsed outlook response.
 */
@interface MCEventData : NSObject
/**
 Event subject as string.
 */
@property(nonatomic, strong) NSString *subject;

/**
 Event bodyPreview as string.
 */
@property(nonatomic, strong) NSString *bodyPreview;

/**
 Event importance as high, medium and low.
 */
@property(nonatomic, strong) NSString *importance;

/**
 Event start time as NSDate.
 */
@property(nonatomic, strong) NSDate *startTime;

/**
 Event end time as NSDate.
 */
@property(nonatomic, strong) NSDate *endTime;

/**
 Event location as string.
 */
@property(nonatomic, strong) NSString *location;

/**
 Event attendees as MCParticipantData.
 */
@property(nonatomic, strong) NSArray *attendees;

//The following are calculated entries based on above data.
/**
 Event duration calculated from event startTime and event endTime.
 */
@property(nonatomic, strong) NSString *duration;

/**
 Event date key calculated from event start date. It is used for hashing.
 */
@property(nonatomic, strong) NSString *eventDateKey;

@end
