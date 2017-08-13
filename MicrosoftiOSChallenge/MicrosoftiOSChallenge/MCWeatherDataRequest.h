//
//  MCWeatherDataRequest.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCRequestObjectProtocol.h"

@import Foundation;
@import CoreLocation;

/**
 MCWeatherDataRequest is used to create weather data request from location.
 */
@interface MCWeatherDataRequest : NSObject<MCRequestObjectProtocol>

/**
 Location coordinates for retrieving weather.
 */
@property(nonatomic, strong) CLLocation *location;
@end
