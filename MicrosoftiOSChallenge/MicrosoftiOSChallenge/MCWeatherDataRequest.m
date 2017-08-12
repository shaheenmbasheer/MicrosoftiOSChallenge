//
//  MCWeatherDataRequest.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCWeatherDataRequest.h"

@implementation MCWeatherDataRequest


+(NSString *)apiKey{

    return @"8e2550fdd3e8d7ab7c106cf85b3cf162";
}

+(NSString *)baseURLString{

    return @"https://api.darksky.net/forecast";
}
-(NSString *)generateRequestURL{

    return [NSString stringWithFormat:@"%@/%@/%f,%f", [MCWeatherDataRequest baseURLString], [MCWeatherDataRequest apiKey], self.location.coordinate.latitude, self.location.coordinate.longitude];
}
@end
