//
//  MCErrorUtilities.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;

/**
  Generates error object
 */
NSError *MCErrorFromParameters(NSString *errorType, NSString *failureReason,NSString *errorRecoverySuggestion);
