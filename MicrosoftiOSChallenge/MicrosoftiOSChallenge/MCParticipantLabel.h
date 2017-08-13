//
//  MCParticipantLabel.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import UIKit;
/**
 ParticipantLabel is used for displaying each attendee/participant in agenda control.
 */
@interface MCParticipantLabel : UILabel

/**
 Participant full name.
 */
@property(nonatomic, strong) NSString *participantName;
@end
