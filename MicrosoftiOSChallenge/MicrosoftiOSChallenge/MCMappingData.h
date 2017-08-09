//
//  MCMappingData.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMappingData : NSObject

/**
 *  Mapping information for Events Request
 *
 *  @param entriesDictionary input response data
 *
 *  @return mapped object
 */
+ (id)mappedObjectForEventRequestWithEntriesDictionary:(NSDictionary *)entriesDictionary;
@end
