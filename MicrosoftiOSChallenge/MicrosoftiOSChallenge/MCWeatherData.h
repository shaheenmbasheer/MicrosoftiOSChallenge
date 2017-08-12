//
//  MCWeatherData.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCWeatherData : NSObject

@property(nonatomic, strong) NSDate *time;
@property(nonatomic, strong) NSString *timeKey;
@property(nonatomic, strong) NSString *summary;
@property(nonatomic, strong) NSString *iconName;
@property(nonatomic, strong) NSString *iconFontName;
@property(nonatomic, strong) NSString *minTemerature;
@property(nonatomic, strong) NSString *maxTemperature;



@end
