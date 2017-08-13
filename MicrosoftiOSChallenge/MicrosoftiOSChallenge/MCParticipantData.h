//
//  MCParticipantData.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 10/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;
/**
 MCParticipantData is used to save parsed respose of each participant/attendee
 for a particular event data.
 */
@interface MCParticipantData : NSObject

/**
 Participant type specifies the attendee type eg Required.
 */
@property(nonatomic, strong) NSString *type;

/**
 Participant full name.
 */
@property(nonatomic, strong) NSString *name;

/**
 Participant email address.
 */
@property(nonatomic, strong) NSString *email;

@end
