//
//  MCAvailabilityView.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import UIKit;

/**
 *  Meeting importance key
 */
typedef NS_ENUM(NSUInteger, MCMeetingImportanceViewKey){
    /**
     *  Meeting status not set
     */
    MCMeetingImportanceViewKeyUnknown = 0,
    /**
     *  Meeting status green
     */
    MCMeetingImportanceViewKeyNotImportant = 0,
    /**
     *  Meeting status yellow
     */
    MCMeetingImportanceViewKeyMediumImportance = 1,
    /**
     *  Meeting status red
     */
    MCMeetingImportanceViewKeyHighImportance = 2,
};


/**
 MCMeetingImportanceView is used to display meeting importance in an event.
 */
@interface MCMeetingImportanceView : UIView


/**
 Meeting importance as MCMeetingImportanceViewKey.
 */
@property(nonatomic, assign) MCMeetingImportanceViewKey meetingImportance;
/**
 Meeting importance as in event response.
 */
@property(nonatomic, strong) NSString *importance;
@end
