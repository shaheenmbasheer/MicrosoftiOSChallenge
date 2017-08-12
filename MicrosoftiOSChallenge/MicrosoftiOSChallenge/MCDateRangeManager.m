//
//  MCDateProvider.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCDateRangeManager.h"

@interface MCDateRangeManager()

@property(atomic, strong) NSArray *dateListArray;
@property(atomic, strong) NSDateFormatter *dateFormatter;
@property(atomic, assign) NSInteger todayDate;
@end
@implementation MCDateRangeManager

static MCDateRangeManager *currentInstance = nil;

+ (instancetype)sharedInstance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentInstance = [[MCDateRangeManager alloc] init];
        [currentInstance prepareData];
        currentInstance.dateFormatter = [[NSDateFormatter alloc] init];
    });
    return currentInstance;
}

+ (NSDateFormatter *)dateFormatter{

    return [[MCDateRangeManager sharedInstance] dateFormatter];
}
+ (NSString *)calculateStringFromDate:(NSDate *)date withFormat:(NSString *)format{

   MCDateRangeManager *currentInstance = [MCDateRangeManager sharedInstance];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    [currentInstance.dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [currentInstance.dateFormatter setLocale:locale];
    [currentInstance.dateFormatter setDateFormat:format];
    return [currentInstance.dateFormatter stringFromDate:date];
}
+ (NSUInteger)todayDateIndex{

    return [[MCDateRangeManager sharedInstance] todayDate];

}
- (void)prepareData{

    self.dateListArray = [self prepareDataForDateRangeWithLowerLimit:-365*4 withUpperLimit:365*4];
}
- (NSArray *)prepareDataForDateRangeWithLowerLimit:(NSInteger)lowerLimit withUpperLimit:(NSInteger)upperLimit{

    NSDate *now = [NSDate date];
    NSMutableArray *calenderDateArray = [@[] mutableCopy];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:now];
    
    BOOL firstSunday = NO;;
    for (NSInteger i = lowerLimit; i < upperLimit; i ++) {
        
        [comps setDay:[comps day] - i];
        NSDate *newDate = [now dateByAddingTimeInterval:i*24*60*60];
        NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:newDate];
        if ([component weekday] == 1) {
            
            firstSunday = YES;
        }
        if (firstSunday) {
            
            [calenderDateArray addObject:newDate];
        }
        
        if (i == 0) {
            self.todayDate = [calenderDateArray count] -1;
        }
        
    }
    
    return [calenderDateArray copy];
}

+ (NSArray *)getDateRangeArray{

    return [[MCDateRangeManager sharedInstance] dateListArray];
}

@end
