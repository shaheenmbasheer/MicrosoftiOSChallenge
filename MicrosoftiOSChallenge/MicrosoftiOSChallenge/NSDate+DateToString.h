//
//  NSDate+DateToString.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;
@interface NSDate (DateToString)
/**
 *  Convert NSDate to  string value with user specified format
 *
 *  @return returns string value
 */
- (NSString *)stringValueWithFormat:(NSString *)format;

/**
 *  Number of days until
 *
 *  @param endDate endDate
 *
 *  @return number of days
 */
- (NSInteger)numberOfDaysUntil:(NSDate *)endDate;

/**
 *  Outputs the next date
 *
 *  @return outputs the next date
 */
- (NSDate *)getNextDate;

@end
