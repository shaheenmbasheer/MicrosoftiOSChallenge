//
//  MCWeatherData.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;

/**
 MCWeatherData is used to denote each parsed weather data.
 */
@interface MCWeatherData : NSObject

/**
 Weather recorded time.
 */
@property(nonatomic, strong) NSDate *time;

/**
 Weather time key which is calculated for hashing.
 */
@property(nonatomic, strong) NSString *timeKey;

/**
 Weather summay
 */
@property(nonatomic, strong) NSString *summary;

/**
 Weather icon name as send by the server
 */
@property(nonatomic, strong) NSString *iconName;

/**
 Calculated weather font name
 */
@property(nonatomic, strong) NSString *iconFontName;

/**
 Weather min temperature in Fahrenheit
 */
@property(nonatomic, strong) NSString *minTemperature;

/**
 Weather max temperature in Fahrenheit
 */
@property(nonatomic, strong) NSString *maxTemperature;
@end
