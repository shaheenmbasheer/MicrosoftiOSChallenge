//
//  MCWeatherTableHeaderView.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 11/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCWeatherData.h"
@interface MCWeatherTableHeaderView : UIStackView

-(instancetype)initWithTodayDateString:(NSString *)todayDateString withWeatherData:(MCWeatherData *)weatherData;
@end
