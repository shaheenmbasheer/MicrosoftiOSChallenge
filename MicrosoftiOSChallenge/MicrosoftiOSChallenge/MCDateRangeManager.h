//
//  MCDateProvider.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;

/**
 MCDateRangeManager is used to calculating date range that is to be used
 repeatedly in the application but calender and agenda controls. Singleton will
 save the data and process data range only if required.
 DateFormatter initialization is an extensive process and avoid recreating the instance
 everytime,MCDateRangeManager holds an initialized dataFormatter for calculation.
 */
@interface MCDateRangeManager : NSObject

/**
 Returns shared instance of MCDateRangeManager

 @return sharedInstance of type MCDateRangeManager.
 */
+(instancetype)sharedInstance;

/**
 Returns calculated array of NSDate values

 @return array of NSDate values.
 */
+(NSArray *)getDateRangeArray;

/**
 Shared DateFormatter. 
 Around 500% improved performance in time profiler by using
 shared date formatter.

 @return NSDateFormatter object
 */
+(NSDateFormatter *)dateFormatter;

/**
 Returns index of today date in calculated date range array.

 @return index as integer
 */
+(NSUInteger)todayDateIndex;

/**
 The method is used to generate date key in ddMMyyyy format from date.

 @param date date as NSDate
 @return datekey as string.
 */
+(NSString *)getDateKeyForDate:(NSDate *)date;

/**
 Calculate string from date with given format

 @param date input date
 @param format format string
 @return formatter string.
 */
+(NSString *)calculateStringFromDate:(NSDate *)date withFormat:(NSString *)format;
@end
