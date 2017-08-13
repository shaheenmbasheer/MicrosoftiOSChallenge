//
//  MCWeatherDataRequest.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCWeatherDataRequest.h"

@implementation MCWeatherDataRequest

/**
 Returns Forecast.ios API key

 @return api key as string.
 */
+(NSString *)apiKey{

    return @"8e2550fdd3e8d7ab7c106cf85b3cf162";
}

/**
 Returns Forecast.io base url.

 @return base url as string.
 */
+(NSString *)baseURLString{

    return @"https://api.darksky.net/forecast";
}

/**
 Generating request url from parameters.

 @return request url as string.
 */
-(NSString *)generateRequestURL{

    return [NSString stringWithFormat:@"%@/%@/%f,%f", [MCWeatherDataRequest baseURLString], [MCWeatherDataRequest apiKey], self.location.coordinate.latitude, self.location.coordinate.longitude];
}
@end
