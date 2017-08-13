//
//  MCDateProvider.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCDateRangeManager.h"

@interface MCDateRangeManager()
/**
 Calculated date list array.
 */
@property(atomic, strong) NSArray *calendarDateListArray;
/**
 Date formatter object for calculating string from date.
 */
@property(atomic, strong) NSDateFormatter *dateFormatter;
/**
 Today's date index in calendarDateListArray.
 */
@property(atomic, assign) NSInteger todayDate;
@end
@implementation MCDateRangeManager

static MCDateRangeManager *currentInstance = nil;
/**
 Returns shared instance of MCDateRangeManager
 
 @return sharedInstance of type MCDateRangeManager.
 */
+(instancetype)sharedInstance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentInstance = [[MCDateRangeManager alloc] init];
        [currentInstance prepareData];
        currentInstance.dateFormatter = [[NSDateFormatter alloc] init];
    });
    return currentInstance;
}

/**
 Shared DateFormatter.
 Around 500% improved performance in time profiler by using
 shared date formatter.
 
 @return NSDateFormatter object
 */
+(NSDateFormatter *)dateFormatter{

    return [[MCDateRangeManager sharedInstance] dateFormatter];
}

/**
 Calculate string from date with given format
 
 @param date input date
 @param format format string
 @return formatter string.
 */
+(NSString *)calculateStringFromDate:(NSDate *)date withFormat:(NSString *)format{

   MCDateRangeManager *currentInstance = [MCDateRangeManager sharedInstance];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    [currentInstance.dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [currentInstance.dateFormatter setLocale:locale];
    [currentInstance.dateFormatter setDateFormat:format];
    return [currentInstance.dateFormatter stringFromDate:date];
}

/**
 Returns index of today date in calculated date range array.
 
 @return index as integer
 */
+(NSUInteger)todayDateIndex{

    return [[MCDateRangeManager sharedInstance] todayDate];

}

/**
 Prepares calendarDateListArray from a lower and upper date limits.
 */
-(void)prepareData{

    self.calendarDateListArray = [self prepareDataForDateRangeWithLowerLimit:-365*4 withUpperLimit:365*4];
}


/**
 Calculate calendar dates from a lower and upper date limit. The date is calculated in such a way that the
 first day of the calendarDateListArray is a Sunday.

 @param lowerLimit number of days prior to current date.
 @param upperLimit number of days ahead to current date.
 @return calculated calendar date array.
 */
-(NSArray *)prepareDataForDateRangeWithLowerLimit:(NSInteger)lowerLimit withUpperLimit:(NSInteger)upperLimit{

    //Get today's date
    NSDate *now = [NSDate date];
    NSMutableArray *calendarDateArray = [@[] mutableCopy];
    //Specifies if its the day is first sunday or not.
    BOOL firstSunday = NO;
    //Loop from lower limit to upper limit to calculate valid date range.
    for (NSInteger i = lowerLimit; i < upperLimit; i ++) {
        //Reducing and increasing date by a day to get dates prior to and ahead of current date.
        NSDate *newDate = [now dateByAddingTimeInterval:i*24*60*60];
        //Calculating day type.
        NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:newDate];
        if ([component weekday] == 1) {
            //Current date is Sunday.
            firstSunday = YES;
        }
        if (firstSunday) {
            //Start date calculation from first Sunday and thereon.
            [calendarDateArray addObject:newDate];
        }
        
        if (i == 0) {
            //Indicates today's date index in calendarDateArray.
            self.todayDate = [calendarDateArray count] -1;
        }
    }
    return [calendarDateArray copy];
}
/**
 Returns calculated array of NSDate values
 
 @return array of NSDate values.
 */
+ (NSArray *)getDateRangeArray{

    return [[MCDateRangeManager sharedInstance] calendarDateListArray];
}
/**
 The method is used to generate date key in ddMMyyyy format from date.
 
 @param date date as NSDate
 @return datekey as string.
 */
+ (NSString *)getDateKeyForDate:(NSDate *)date{

    return [MCDateRangeManager calculateStringFromDate:date withFormat:@"ddMMyyyy"];
}
@end
