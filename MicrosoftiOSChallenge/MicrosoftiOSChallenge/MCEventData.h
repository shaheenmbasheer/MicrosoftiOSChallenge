//
//  MCEventData.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 10/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCEventData : NSObject

@property(nonatomic, strong) NSString *subject;
@property(nonatomic, strong) NSString *bodyPreview;
@property(nonatomic, strong) NSString *importance;
@property(nonatomic, strong) NSDate *startTime;
@property(nonatomic, strong) NSDate *endTime;
@property(nonatomic, strong) NSString *location;
//Calculated entries
@property(nonatomic, strong) NSString *duration;
@property(nonatomic, strong) NSString *eventDateKey;

@end
