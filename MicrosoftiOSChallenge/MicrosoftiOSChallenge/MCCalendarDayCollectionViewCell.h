//
//  MCCalendarDayCollectionViewCell.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 MCCalanderDayCollectionViewCell is used to display each day cell in calendar.
 */
@interface MCCalendarDayCollectionViewCell : UICollectionViewCell

/**
 Display date object for calendar cell
 */
@property(nonatomic, strong) NSDate *displayDate;

/**
 isCenterDate is used to denote center wednesday in calender.
 It is used to position month and year in overlay view.
 */
@property(nonatomic, assign) BOOL isCenterDate;

/**
 eventDictionary indicates wheather event is there for the particular cell.
 */
@property(nonatomic, strong) NSDictionary *eventDictionary;
/**
 Returns cell reuse identifier

 @return cellReuseIdentifier of type NSString
 */
+ (NSString *)cellReuseIdentifier;

@end
