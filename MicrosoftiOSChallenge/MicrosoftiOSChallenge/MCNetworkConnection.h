//
//  MCNetworkConnection.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCProtocolHeaders.h"

@interface MCNetworkConnection : NSObject

+(void)establishConnectionWithObject:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock;

@end
