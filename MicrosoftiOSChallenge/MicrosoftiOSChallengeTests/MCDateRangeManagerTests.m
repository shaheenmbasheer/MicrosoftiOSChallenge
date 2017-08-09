//
//  MCDateRangeManagerTests.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 10/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCDateRangeManager+PrivateMethodsToTest.h"

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

-(void)testDateRangeOperation{

    NSArray *dates = [[MCDateRangeManager sharedInstance] prepareDataForDateRangeWithLowerLimit:-365 withUpperLimit:365];
    
    XCTAssertTrue([dates count]);
}

-(void)testIfFirstDateInDateRangeIsSunday{

    NSArray *dates = [[MCDateRangeManager sharedInstance] prepareDataForDateRangeWithLowerLimit:-365 withUpperLimit:365];
    NSDate *date = [dates firstObject];
    
    XCTAssertEqualObjects([MCDateRangeManager calculateStringFromDate:date withFormat:@"EEEE"], @"Sunday");
}

-(void)testIfDateRangetodayIndexIsTodayDate{

    NSDate *todayDate = [NSDate date];
    NSArray *dates = [[MCDateRangeManager sharedInstance] prepareDataForDateRangeWithLowerLimit:-365 withUpperLimit:365];
    NSInteger todayIndex = [MCDateRangeManager todayDateIndex];
    NSDate *todayDateFromIndex = dates[todayIndex];
    XCTAssertEqualObjects([MCDateRangeManager calculateStringFromDate:todayDate withFormat:@"ddMMyyyy"], [MCDateRangeManager calculateStringFromDate:todayDateFromIndex withFormat:@"ddMMyyyy"]);

}
@end
