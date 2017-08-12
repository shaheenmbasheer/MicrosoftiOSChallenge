//
//  MCErrorUtilities.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCErrorUtilities.h"

NSError *MCErrorFromParameters(NSString *errorType, NSString *failureReason,NSString *errorRecoverySuggestion) {
    return [NSError
            errorWithDomain:@"com.microsoft.iOSChallenge"
            code:-1
            userInfo:@{
                       NSLocalizedDescriptionKey : errorType,
                       NSLocalizedFailureReasonErrorKey : failureReason,
                       NSLocalizedRecoverySuggestionErrorKey :errorRecoverySuggestion
                       }];
    
}

