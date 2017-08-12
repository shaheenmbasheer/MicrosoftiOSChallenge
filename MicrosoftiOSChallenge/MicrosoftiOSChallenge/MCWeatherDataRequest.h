//
//  MCWeatherDataRequest.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCRequestObjectProtocol.h"

@import CoreLocation;
@interface MCWeatherDataRequest : NSObject<MCRequestObjectProtocol>

@property(nonatomic, strong) CLLocation *location;
@end
