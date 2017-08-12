//
//  MCLocationManager.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;
@import CoreLocation;

typedef void(^LocationCompletionBlock)(CLLocation *location);
typedef void (^LocationErrorBlock)(NSError *error);

/**
MCLocationManager is used to get current location of user's device.
It handles all the methods relacted to CoreLocation.
*/
@interface MCLocationManager : NSObject

@property (strong, nonatomic) CLLocation *currentLocation;

+(instancetype)sharedInstance;
-(void)startUpdatingLocationWithCompletionBlock:(LocationCompletionBlock)completionBlock withErrorBlock:(LocationErrorBlock)errorBlock;
@end
