//
//  MCAvailabilityView.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  HomeScreen running state
 */
typedef NS_ENUM(NSUInteger, MCAvailabilityViewKey){
    /**
     *  Availability status not set
     */
    MCAvailabilityViewKeyUnknown = 0,
    /**
     *  Availability status green
     */
    MCAvailabilityViewKeyAvailable = 0,
    /**
     *  Availability status yellow
     */
    MCAvailabilityViewKeyAway = 1,
    /**
     *  Availability status red
     */
    MCAvailabilityViewKeyBusy = 2,
};

@interface MCAvailabilityView : UIView

@property(nonatomic, assign) MCAvailabilityViewKey availabilty;
@end
