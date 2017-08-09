//
//  MCMappingDataTests.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 10/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCDummyDataProvider.h"
#import "MCMappingData.h"

@interface MCDummyDataProvider()

+(NSDictionary*)dictionaryWithContentsOfJSONStringForFile:(NSString*)fileLocation;
@end


@interface MCMappingDataTests : XCTestCase

@property(nonatomic, strong) NSDictionary *responseArray;
@end

@implementation MCMappingDataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.responseArray = (NSDictionary *)[MCDummyDataProvider dictionaryWithContentsOfJSONStringForFile:@"GetEventData"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEventDataParsing {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [MCMappingData mappedObjectForEventRequestWithEntriesDictionary:self.responseArray];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
