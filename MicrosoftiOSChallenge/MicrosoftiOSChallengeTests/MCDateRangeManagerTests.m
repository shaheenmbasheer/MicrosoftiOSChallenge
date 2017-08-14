//
//  MCDateRangeManagerTests.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 10/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCDateRangeManager.h"


/**
 DateRangeManager extension for exposing private methods.
 */
@interface MCDateRangeManager ()

- (NSArray *)prepareDataForDateRangeWithLowerLimit:(NSInteger)lowerLimit withUpperLimit:(NSInteger)upperLimit;
@end


@interface MCDateRangeManagerTests : XCTestCase

@end

@implementation MCDateRangeManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


/**
 Testing if DateRange operation returns a valid array
 */
-(void)testDateRangeOperation{

    NSArray *dates = [[MCDateRangeManager sharedInstance] prepareDataForDateRangeWithLowerLimit:-365 withUpperLimit:365];
    
    XCTAssertTrue([dates count]);
}


/**
 Testing if the first date returned by dateRange operation is a Sunday
 */
-(void)testIfFirstDateInDateRangeIsSunday{

    NSArray *dates = [[MCDateRangeManager sharedInstance] prepareDataForDateRangeWithLowerLimit:-365 withUpperLimit:365];
    NSDate *date = [dates firstObject];
    
    XCTAssertEqualObjects([MCDateRangeManager calculateStringFromDate:date withFormat:@"EEEE"], @"Sunday");
}


/**
 Testing today date returned by date range operation
 */
-(void)testIfDateRangetodayIndexIsTodayDate{

    NSDate *todayDate = [NSDate date];
    NSArray *dates = [[MCDateRangeManager sharedInstance] prepareDataForDateRangeWithLowerLimit:-365 withUpperLimit:365];
    NSInteger todayIndex = [MCDateRangeManager todayDateIndex];
    NSDate *todayDateFromIndex = dates[todayIndex];
    XCTAssertEqualObjects([MCDateRangeManager calculateStringFromDate:todayDate withFormat:@"ddMMyyyy"], [MCDateRangeManager calculateStringFromDate:todayDateFromIndex withFormat:@"ddMMyyyy"]);

}
@end
