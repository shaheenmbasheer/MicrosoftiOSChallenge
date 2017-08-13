//
//  MCLocationManager.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCLocationManager.h"
#import "MCErrorUtilities.h"

@interface MCLocationManager()<CLLocationManagerDelegate>

/**
 Location manager object for retrieving location
 */
@property(nonatomic, strong) CLLocationManager *locationManager;

/**
 Location completion block with location coordinates.
 */
@property(nonatomic, copy) LocationCompletionBlock completionBlock;

/**
 Error block with encountered error data.
 */
@property(nonatomic, copy) LocationErrorBlock errorBlock;
@end
@implementation MCLocationManager

static MCLocationManager *currentInstance = nil;
/**
 Returns shared instance of MCLocationManager.
 
 @return instance of type MCLocationManager.
 */
+(instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentInstance = [[MCLocationManager alloc] init];
    });
    
    return currentInstance;
}


/**
 Initialize method used to initialize location manager and self.

 @return initialized self.
 */
- (instancetype)init {
    
    self = [super init];
    if(self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 100; // meters
        self.locationManager.delegate = self;
    }
    return self;
}
/**
 Starts updating location with completion block containing location coordinates or error block containing error.
 
 @param completionBlock completionBlock with location coordinates.
 @param errorBlock errorBlock with encountered error.
 */
-(void)startUpdatingLocationWithCompletionBlock:(LocationCompletionBlock)completionBlock withErrorBlock:(LocationErrorBlock)errorBlock{
    
    self.completionBlock = completionBlock;
    self.errorBlock = errorBlock;
    
    //Requesting for authorization
    [self.locationManager requestAlwaysAuthorization];
    
    if ([CLLocationManager locationServicesEnabled]) {
        //If location services are enabled.
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            //If user denies location access to application.
            self.errorBlock(MCErrorFromParameters(@"Privacy Error", @"App Permission denied", @"To re-enable, please go to Settings and turn on Location Service for this app."));
        }else{
            //If application gets access to location.
            [self startUpdatingLocation];

        }
    }
}

/**
 Start updating location using location manager.
 */
- (void)startUpdatingLocation{
    //Start updating location.
    [self.locationManager startUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate

/**
 Location manager error delegate method.
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    //Calling error block with encountered error and display messages.
    self.errorBlock(MCErrorFromParameters(@"CoreLocation", @"Unable to Retrieve CoreLocation", @"Try again later"));
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray*)locations{
    
    //Get current location.
    CLLocation *location = [locations lastObject];
    //Stop updating location once location object is populated.
    [self.locationManager stopUpdatingLocation];
    //Saving retrieved location.
    self.currentLocation = location;
    //Call completion block.
    if (self.completionBlock != nil) {
        self.completionBlock(location);

    }
    self.completionBlock = nil;
}
@end
