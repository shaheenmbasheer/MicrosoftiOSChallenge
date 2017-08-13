//
//  MCRequestObjectProtocol.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#ifndef MCRequestObjectProtocol_h
#define MCRequestObjectProtocol_h
@import Foundation;

@protocol MCRequestObjectProtocol <NSObject>

-(NSString *)generateRequestURL;
@optional
-(NSString *)generateRequestBody;

@end


#endif /* MCRequestObjectProtocol_h */
