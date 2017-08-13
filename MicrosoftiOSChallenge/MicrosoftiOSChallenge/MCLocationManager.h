//
//  MCLocationManager.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;
@import CoreLocation;


/**
 Completion block is called after retrieving location

 @param location as CLLocation coordinates.
 */
typedef void(^LocationCompletionBlock)(CLLocation *location);

/**
 Error block is location retrieving encounters error.

 @param error encountered error.
 */
typedef void (^LocationErrorBlock)(NSError *error);

/**
MCLocationManager is used to get current location of user's device.
It handles all the methods relacted to CoreLocation.
*/
@interface MCLocationManager : NSObject

/**
 Current location as CLLocation coordinates.
 */
@property (strong, nonatomic) CLLocation *currentLocation;

/**
 Returns shared instance of MCLocationManager.

 @return instance of type MCLocationManager.
 */
+(instancetype)sharedInstance;

/**
 Starts updating location with completion block containing location coordinates or error block containing error.

 @param completionBlock completionBlock with location coordinates.
 @param errorBlock errorBlock with encountered error.
 */
-(void)startUpdatingLocationWithCompletionBlock:(LocationCompletionBlock)completionBlock withErrorBlock:(LocationErrorBlock)errorBlock;
@end
