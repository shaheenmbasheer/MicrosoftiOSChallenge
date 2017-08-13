//
//  MCWeatherData.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCWeatherData.h"

@implementation MCWeatherData


/**
 Icon name from forecast server to weather font mapping.

 @return font entity name in weather font as string.
 */
-(NSDictionary *)iconNameToFontMapping{

    return @{
             @"clear-day":@"\uf00d",
             @"clear-night":@"\uf02e",
             @"rain":@"\uf019",
             @"snow":@"\uf01b",
             @"sleet":@"\uf0b5",
             @"wind":@"\uf050",
             @"fog":@"\uf014",
             @"cloudy":@"\uf013",
             @"partly-cloudy-day":@"\uf002",
             @"partly-cloudy-night":@"\uf086",
             @"hail":@"\uf015",
             @"thunderstorm":@"\uf01e",
             @"tornado":@"\uf056",

             };
}


/**
 Icon name accessor method.

 @param iconName icons name as in forcast response.
 */
-(void)setIconName:(NSString *)iconName{

    _iconName = iconName;
    //Calculating iconFontName from iconName.
    self.iconFontName = [self iconNameToFontMapping][iconName];

}
@end
