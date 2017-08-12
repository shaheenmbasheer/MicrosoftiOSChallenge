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

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, copy) LocationCompletionBlock completionBlock;
@property(nonatomic, copy) LocationErrorBlock errorBlock;
@end
@implementation MCLocationManager

static MCLocationManager *currentInstance = nil;

+(instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentInstance = [[MCLocationManager alloc] init];
    });
    
    return currentInstance;
}

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

-(void)startUpdatingLocationWithCompletionBlock:(LocationCompletionBlock)completionBlock withErrorBlock:(LocationErrorBlock)errorBlock{
    
    self.completionBlock = completionBlock;
    self.errorBlock = errorBlock;
    
    [self.locationManager requestAlwaysAuthorization];

    if ([CLLocationManager locationServicesEnabled]) {
        
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            
            self.errorBlock(MCErrorFromParameters(@"Privacy Error", @"App Permission denied", @"To re-enable, please go to Settings and turn on Location Service for this app."));
        }else{
        
            [self startUpdatingLocation];

        }
    }
    
    

}
- (void)startUpdatingLocation{
    
    NSLog(@"Starting location updates");
    [self.locationManager startUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
    self.errorBlock(MCErrorFromParameters(@"CoreLocation", @"Unable to Retrieve CoreLocation", @"Try again later"));
    NSLog(@"Location service failed with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray*)locations{
    
    CLLocation *location = [locations lastObject];
    NSLog(@"Latitude %+.6f, Longitude %+.6f\n",
          location.coordinate.latitude,
          location.coordinate.longitude);
    [self.locationManager stopUpdatingLocation];
    self.currentLocation = location;
    if (self.completionBlock != nil) {
        self.completionBlock(location);

    }
    self.completionBlock = nil;
}
@end
