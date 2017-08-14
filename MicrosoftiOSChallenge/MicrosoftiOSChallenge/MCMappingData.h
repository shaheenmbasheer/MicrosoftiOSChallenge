//
//  MCMappingData.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 MCMappingData is used as a centralized mapper for both offline and online data.
 */
@interface MCMappingData : NSObject

/**
 Mapping information for Event Request

 @param entriesDictionary parsed event response dictionary
 @return nsdictionary of mapped event data
 */
+ (id)mappedObjectForEventRequestWithEntriesDictionary:(NSDictionary *)entriesDictionary;


/**
 Mapping information for Weather Request

 @param entriesDictionary parsed weather response dictionary
 @return nsdictionary of mapped weather data
 */
+ (id)mappedObjectForWeatherRequestWithEntriesDictionary:(NSDictionary *)entriesDictionary;

@end
