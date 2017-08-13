//
//  MCRequestObjectProtocol.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;
/**
 MCRequestObjectProtocol defines the base protocol for every request object.
 */
@protocol MCRequestObjectProtocol <NSObject>

/**
 The method used to return generated requestURL from request object
 
 @return request URL as string from request object.
 */
-(NSString *)generateRequestURL;

@optional
/**
 The method is used to return generated request body from request object
 
 @return request body from request object
 */
-(NSData *)generateRequestBody;
@end


