//
//  WeatherDataAndLocationTests.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 13/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCWeatherDataRequest.h"
#import "MCRequestObjectProtocol.h"
#import "MCLocationManager.h"
#import "MCDataControllerManager.h"
#import "MCDummyDataProvider_PrivateMethods.h"
#import "MCMappingData.h"
#import "MCWeatherData.h"

@interface WeatherDataAndLocationTests : XCTestCase


/**
 Weather data json response is saved in this dictionary
 */
@property(nonatomic, strong) NSDictionary *weatherResponseDictionary;

/**
 Weather data request which confirms to MCRequestObjectProtocol for generating request URL.
 */
@property(nonatomic, strong) MCWeatherDataRequest<MCRequestObjectProtocol> *weatherDataRequest;

@end

@implementation WeatherDataAndLocationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.weatherDataRequest = [[MCWeatherDataRequest alloc] init];
    _weatherDataRequest.location = ({
        
        double desired_horizontal_accuracy = 200.0; // in meters
        double desired_vertical_accuracy = 200.0; // in meters
        
        CLLocation *location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(37.785834,-122.406417)
                                                             altitude:-1
                                                   horizontalAccuracy:desired_horizontal_accuracy
                                                     verticalAccuracy:desired_vertical_accuracy
                                                            timestamp:[NSDate date]];
        location;
    });
    
    self.weatherResponseDictionary = [MCDummyDataProvider dictionaryWithContentsOfJSONStringForFile:@"GetWeatherData"];

}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//Test if weather data url is not nil
- (void)testWeatherDataURLisNotNil{
    
    NSString *generatedURLString = [self.weatherDataRequest generateRequestURL];
    XCTAssertNotNil(generatedURLString,@"Generated url is not nil");
}

//Testing MCLocationManager whether it returns a valid location or not.
-(void)testLocationisNotNil{

    //Testing if MCLocationManager returns a valid location.
    XCTestExpectation *locationExpectation = [self expectationWithDescription:@"Location"];
    [[MCLocationManager sharedInstance] startUpdatingLocationWithCompletionBlock:^(CLLocation *location) {
        
        NSLog(@"Location is %f %f", location.coordinate.latitude, location.coordinate.longitude);
        //Test passes if location is valid
        XCTAssertNotNil(location, @"Retrieved location data");
        [locationExpectation fulfill];
        
    } withErrorBlock:^(NSError *error) {

        XCTAssertFalse(error, @"Failed to retrieve location");
    }];

    [self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
        XCTAssertFalse(error, @"Failed to retrieve location");

    }];
}

//Test if weather data parsing is returning a valid object
-(void)testWeatherDataMappedObjectNotNil{

    NSDictionary *weatherDataDictionary = [MCMappingData mappedObjectForWeatherRequestWithEntriesDictionary:self.weatherResponseDictionary];
    
    XCTAssertNotNil(weatherDataDictionary, @"Parsed weather data is not nil");
    
}

//Test if weather data values are coming.
-(void)testWeatherDataMappedObjectIsValid{
    
    NSDictionary *weatherDataDictionary = [MCMappingData mappedObjectForWeatherRequestWithEntriesDictionary:self.weatherResponseDictionary];
    for (NSString *key in [weatherDataDictionary allKeys]) {
        
        MCWeatherData *weatherData = weatherDataDictionary[key];
        XCTAssertNotNil(weatherData.summary);
        XCTAssertNotNil(weatherData.iconName);
        XCTAssertNotNil(weatherData.time);
        XCTAssertNotNil(weatherData.minTemperature);
        XCTAssertNotNil(weatherData.maxTemperature);
        //Processed value
        XCTAssertNotNil(weatherData.iconFontName);
    }
}

/*
-(void)testWeatherDataFromServer{

    XCTestExpectation *weatherResponseExpectation = [self expectationWithDescription:@"WeatherResponse"];

    [MCDataControllerManager initializeWeatherDataWithRequest:self.weatherDataRequest withCompletionBlock:^(id result) {
        
        NSLog(@"Result %@", result);
        XCTAssertNotNil(result, @"Retrieved weather data");

        [weatherResponseExpectation fulfill];

    } withErrorBlock:nil];
    
    [self waitForExpectationsWithTimeout:30 handler:^(NSError *error) {
        XCTAssertFalse(error, @"Failed to retrieve location");
        
    }];
}
*/


@end
