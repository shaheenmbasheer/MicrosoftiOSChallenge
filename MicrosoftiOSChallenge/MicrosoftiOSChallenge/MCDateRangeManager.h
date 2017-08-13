//
//  MCDateProvider.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;

/**
 * MCDateRangeManager is used to calculating date range that is to be used
 * repeatedly in the application but calender and agenda controls. Singleton will
 * save the data and process data range only if required. 
 * DateFormatter initialization is an extensive process and avoid recreating the instance
 * everytime,MCDateRangeManager holds an initialized dataFormatter for calculation.
 */
@interface MCDateRangeManager : NSObject

+ (instancetype)sharedInstance;
+ (NSArray *)getDateRangeArray;
+ (NSDateFormatter *)dateFormatter;
+ (NSString *)calculateStringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSUInteger)todayDateIndex;
+ (NSString *)getDateKeyForDate:(NSDate *)date;
@end
