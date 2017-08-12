//
//  MCWeatherData.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCWeatherData.h"

@implementation MCWeatherData

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

-(void)setIconName:(NSString *)iconName{

    _iconName = iconName;
    
    self.iconFontName = [self iconNameToFontMapping][iconName];

}
@end
