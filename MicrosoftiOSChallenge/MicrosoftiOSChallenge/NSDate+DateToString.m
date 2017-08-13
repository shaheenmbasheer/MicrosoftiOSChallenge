//
//  NSDate+DateToString.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "NSDate+DateToString.h"

@implementation NSDate (DateToString)

/**
 Convert NSDate to  string value with user specified format
 
 @return returns string value
 */
-(NSString *)stringValueWithFormat:(NSString *)format{
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
    
}

/**
 Convert NSDate to  string value with user specified format
 
 @return returns string value
 */
-(NSString *)stringValueWithFormat:(NSString *)format withTimeZone:(NSTimeZone *)timeZone{
    
    //TODO: TimeZone
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:timeZone];
    return [dateFormatter stringFromDate:self];
}
/**
 Number of days until
 
 @param endDate Date endDate
 @return number of days
 */
-(NSInteger)numberOfDaysUntil:(NSDate *)endDate {
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:endDate options:0];
    return [components day];
}

/**
 Outputs the next date
 
 @return outputs the next date
 */
-(NSDate *)getNextDate{
    
    NSCalendar*       calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    components.day = 1;
    NSDate* newDate = [calendar dateByAddingComponents:components toDate:self options: 0];
    return newDate;
}

@end

