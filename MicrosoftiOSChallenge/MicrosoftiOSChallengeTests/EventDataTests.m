//
//  EventDataTests.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 13/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCMappingData.h"
#import "MCDummyDataProvider_PrivateMethods.h"
#import "MCEventData.h"

@interface EventDataTests : XCTestCase

@property(nonatomic, strong) NSDictionary *eventDataResponseDictionary;

@end

@implementation EventDataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.eventDataResponseDictionary = (NSDictionary *)[MCDummyDataProvider dictionaryWithContentsOfJSONStringForFile:@"GetEventData"];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//Test if EventDataMapping returns a non nil object.
-(void)testEventDataMappingNotNil{

    NSDictionary *weatherDataDictionary = [MCMappingData mappedObjectForEventRequestWithEntriesDictionary:self.eventDataResponseDictionary];
    XCTAssertNotNil(weatherDataDictionary);

}

//Test if all required values in mapped result is valid.
-(void)testEventDataMappingDictionaryIsValid{

     NSDictionary *weatherDataDictionary = [MCMappingData mappedObjectForEventRequestWithEntriesDictionary:self.eventDataResponseDictionary];
    
    for (NSString *key in weatherDataDictionary) {
        
        for (MCEventData *eventData in weatherDataDictionary[key]) {
            NSLog(@"Event Data is %@", [eventData description]);
            //Checking all required objects.
            XCTAssertNotNil(eventData.subject);
            XCTAssertNotNil(eventData.startTime);
            XCTAssertNotNil(eventData.endTime);
            XCTAssertNotNil(eventData.duration);
            XCTAssertNotNil(eventData.eventDateKey);
        }
      
    }
}

//Test if event Data in mapped dictionary is ordered according to start time.
-(void)testIfEventDataIsOrderedAsPerStartDate{

    NSDictionary *eventDataDictionary = [MCMappingData mappedObjectForEventRequestWithEntriesDictionary:self.eventDataResponseDictionary];
    
    for (NSString *key in eventDataDictionary) {
        
        MCEventData *oldEventData;
        for (MCEventData *eventData in eventDataDictionary[key]) {

            if (oldEventData) {
                XCTAssertTrue([oldEventData.startTime compare:eventData.startTime] == NSOrderedAscending);
            }
            oldEventData = eventData;
            
        }
        
    }

}


@end
