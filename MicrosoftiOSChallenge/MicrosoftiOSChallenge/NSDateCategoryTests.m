//
//  NSDateCateogryTests.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+DateToString.h"

@interface NSDateCategoryTests : XCTestCase

@end

@implementation NSDateCategoryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 Testing NSDate+DateToString category by using stringValueWithFormat: and
 getNextDate calculation.
 Input date 01/01/2016, result date 02/01/2016.
 */
- (void)testDateToStringCategory {

  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"dd/MM/yyyy"];
  NSDate *date = [dateFormatter dateFromString:@"01/01/2016"];
  NSDate *nextDate = [date getNextDate];
  if ([[nextDate stringValueWithFormat:@"dd//MM/yyyy"]
          isEqualToString:@"02/01/2016"]) {

    XCTAssertTrue(true, @"Date matches string");
  } else {

    XCTAssertFalse(false, @"Date doesn't matches string");
  }
}

@end
