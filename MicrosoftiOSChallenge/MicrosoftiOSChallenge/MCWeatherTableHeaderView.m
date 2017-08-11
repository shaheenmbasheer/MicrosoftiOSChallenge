//
//  MCWeatherTableHeaderView.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 11/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCWeatherTableHeaderView.h"

@implementation MCWeatherTableHeaderView

-(instancetype)initWithTodayDateString:(NSString *)todayDateString withWeatherData:(NSString *)weatherData{

    self = [super init];

    if (self) {
        
        //Stack View
        
        self.axis = UILayoutConstraintAxisVertical;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentLeading;
        self.spacing = 5;
        self.backgroundColor = [UIColor darkGrayColor];
        
        UILabel *dateDisplayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        dateDisplayLabel.textAlignment = NSTextAlignmentLeft;
        dateDisplayLabel.text = todayDateString;
        dateDisplayLabel.numberOfLines = 0;
        dateDisplayLabel.font = [UIFont boldSystemFontOfSize:16];
        dateDisplayLabel.textColor = [UIColor whiteColor];
        
        //Stack View
        UIStackView *weatherStackView = [[UIStackView alloc] init];
        
        weatherStackView.axis = UILayoutConstraintAxisHorizontal;
        weatherStackView.distribution = UIStackViewDistributionFill;
        weatherStackView.alignment = UIStackViewAlignmentLeading;
        weatherStackView.spacing = 5;
        
        UILabel *weatherIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        weatherIconLabel.textAlignment = NSTextAlignmentLeft;
        weatherIconLabel.numberOfLines = 0;
        [weatherIconLabel setFont:[UIFont fontWithName:@"WeatherIcons-Regular" size:17.0]];
        [weatherIconLabel setText:@"\uf004"];
        weatherIconLabel.textColor = [UIColor whiteColor];
        [weatherIconLabel.heightAnchor constraintGreaterThanOrEqualToConstant:30].active = true;
        [weatherIconLabel.widthAnchor constraintEqualToConstant:20].active = true;
        
        [weatherStackView addArrangedSubview:weatherIconLabel];

        UILabel *temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        temperatureLabel.textAlignment = NSTextAlignmentLeft;
        temperatureLabel.numberOfLines = 0;
        temperatureLabel.text = @"21ºF";
        temperatureLabel.font = [UIFont systemFontOfSize:15];
        temperatureLabel.textColor = [UIColor whiteColor];
        [temperatureLabel.heightAnchor constraintGreaterThanOrEqualToConstant:30].active = true;
        [temperatureLabel.widthAnchor constraintEqualToConstant:40].active = true;
        
        [weatherStackView addArrangedSubview:temperatureLabel];

        UILabel *weatherDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        weatherDescriptionLabel.textAlignment = NSTextAlignmentLeft;
        weatherDescriptionLabel.text = @"Mostly cloudy throughout the day.Might rain because its rainy.";
        weatherDescriptionLabel.numberOfLines = 0;
        weatherDescriptionLabel.textColor = [UIColor whiteColor];
        weatherDescriptionLabel.font = [UIFont systemFontOfSize:15];

        [weatherDescriptionLabel.heightAnchor constraintGreaterThanOrEqualToConstant:30].active = true;
        [weatherDescriptionLabel.widthAnchor constraintGreaterThanOrEqualToConstant:325].active = true;
        
        [weatherStackView addArrangedSubview:weatherDescriptionLabel];
        

        [self addArrangedSubview:dateDisplayLabel];
        if (weatherData) {
            [self addArrangedSubview:weatherStackView];

        }
    }


    return self;
}

@end
