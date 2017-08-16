//
//  MCWeatherTableHeaderView.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 11/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import UIKit;
@class MCWeatherData;
/**
 MCWeatherTableHeaderView is used to generate stackview to display weather information alongside today's date
 in table section view header.
 */
@interface MCWeatherTableHeaderView : UIStackView

/**
 Initializing MCWeatherTableHeaderView

 @param todayDateString todayDate as string
 @param weatherData weatherData for the respective date
 @return MCWeatherTableHeaderView as UIStackView
 */
-(instancetype)initWithTodayDateString:(NSString *)todayDateString withWeatherData:(MCWeatherData *)weatherData;
@end
