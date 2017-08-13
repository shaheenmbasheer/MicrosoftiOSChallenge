//
//  MCWeatherTableHeaderView.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 11/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCWeatherTableHeaderView.h"

@implementation MCWeatherTableHeaderView

-(instancetype)initWithTodayDateString:(NSString *)todayDateString withWeatherData:(MCWeatherData *)weatherData{

    self = [super init];

    if (self) {
        
        //Outlier vertical stackview settings
        self.axis = UILayoutConstraintAxisVertical;
        self.distribution = UIStackViewDistributionFill;
        self.alignment = UIStackViewAlignmentLeading;
        self.spacing = 5;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        //Default label settings
        UILabel * (^getDefaultLabelType)() = ^UILabel *(){
            
            UILabel *dateDisplayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            dateDisplayLabel.textAlignment = NSTextAlignmentLeft;
            dateDisplayLabel.numberOfLines = 0;
            dateDisplayLabel.font = [UIFont boldSystemFontOfSize:16];
            dateDisplayLabel.textColor = [UIColor whiteColor];
            return dateDisplayLabel;
        };
      
        //Date label for displaying today's date
        UILabel *dateDisplayLabel = getDefaultLabelType();
        dateDisplayLabel.text = todayDateString;
        dateDisplayLabel.font = [UIFont boldSystemFontOfSize:16];
        
        //Horizontal stackview for displaying weather icon, temperature and weather description
        UIStackView *weatherStackView = ({
        
            UIStackView *weatherStackView = [[UIStackView alloc] init];
            weatherStackView.axis = UILayoutConstraintAxisHorizontal;
            weatherStackView.distribution = UIStackViewDistributionFill;
            weatherStackView.alignment = UIStackViewAlignmentLeading;
            weatherStackView.spacing = 5;
            weatherStackView.translatesAutoresizingMaskIntoConstraints = NO;
            weatherStackView;
        
        });
        
             //Temperature label for displaying current temperature
        UILabel *temperatureLabel = ({
        
            UILabel *temperatureLabel = getDefaultLabelType();
            temperatureLabel.text = [NSString stringWithFormat:@"%@ºF",weatherData.maxTemperature];
            temperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
            temperatureLabel.font = [UIFont systemFontOfSize:14];
            [temperatureLabel.heightAnchor constraintGreaterThanOrEqualToConstant:30].active = true;
            [temperatureLabel.widthAnchor constraintEqualToConstant:40].active = true;
            temperatureLabel;
        });
        
        [weatherStackView addArrangedSubview:temperatureLabel];

        //Weather icon label for display weather type icon using custom font.
        UILabel *weatherIconLabel = ({
        
            UILabel *weatherIconLabel = getDefaultLabelType();
            [weatherIconLabel setFont:[UIFont fontWithName:@"WeatherIcons-Regular" size:17.0]];
            weatherIconLabel.text = weatherData.iconFontName;
            [weatherIconLabel.heightAnchor constraintGreaterThanOrEqualToConstant:30].active = true;
            [weatherIconLabel.widthAnchor constraintEqualToConstant:20].active = true;
            weatherIconLabel.translatesAutoresizingMaskIntoConstraints = NO;
            weatherIconLabel;
        });

        [weatherStackView addArrangedSubview:weatherIconLabel];


        //Weather description label.
        UILabel *weatherDescriptionLabel = ({
            UILabel *weatherDescriptionLabel = getDefaultLabelType();
            weatherDescriptionLabel.text = weatherData.summary;
            weatherDescriptionLabel.font = [UIFont systemFontOfSize:15];
            [weatherDescriptionLabel.heightAnchor constraintGreaterThanOrEqualToConstant:30].active = true;
            [weatherDescriptionLabel.widthAnchor constraintGreaterThanOrEqualToConstant:270].active = true;
            weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
            weatherDescriptionLabel;
        
        });

        [weatherStackView addArrangedSubview:weatherDescriptionLabel];

        //Adding weather stackview to outlier(self) stackview.
        [self addArrangedSubview:dateDisplayLabel];
        if (weatherData) {
            //Add weather stackview only if the section have weather data
            //If there is no weather data, display only today's date
            [self addArrangedSubview:weatherStackView];

        }
    }


    return self;
}

@end
