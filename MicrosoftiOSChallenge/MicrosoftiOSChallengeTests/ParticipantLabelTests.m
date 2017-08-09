//
//  ParticipantLabelTests.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCParticipantLabel.h"

@interface MCParticipantLabel ()

+(NSString *)partsOfName:(NSString *)name;
@end

@interface ParticipantLabelTests : XCTestCase

@end

@implementation ParticipantLabelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPartsOfNameWithTwoPartNames{
    
    NSString *result = [MCParticipantLabel partsOfName:@"Shaheen Basheer"];
    XCTAssertEqualObjects(result, @"SB");
}

- (void)testPartsOfNameWithThreePartNames{
    
    NSString *result = [MCParticipantLabel partsOfName:@"Shaheen M Basheer"];
    XCTAssertEqualObjects(result, @"SM");
}
- (void)testPartsOfNameWithOnePartNames{
    
    NSString *result = [MCParticipantLabel partsOfName:@"Shaheen"];
    XCTAssertEqualObjects(result, @"S");
}
- (void)testPartsOfNameWithFourPartNames{
    
    NSString *result = [MCParticipantLabel partsOfName:@"Shaheen M Basheer S"];
    XCTAssertEqualObjects(result, @"SM");
}

//

/**
 * Name is a madatory part in response. Returning empty string incase there is no name.
 */
- (void)testPartsOfNameWithZeroPartNames{
    NSString *result = [MCParticipantLabel partsOfName:@""];
    XCTAssertEqualObjects(result, @" ");
}

@end
