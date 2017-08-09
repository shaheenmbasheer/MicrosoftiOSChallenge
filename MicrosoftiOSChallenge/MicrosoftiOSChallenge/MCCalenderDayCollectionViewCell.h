//
//  MCCalenderDayCollectionViewCell.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 MCCalenderDayCollectionViewCell is used to display each day cell in calender.
 */
@interface MCCalenderDayCollectionViewCell : UICollectionViewCell

/**
 Display date object for calender cell
 */
@property(nonatomic, strong) NSDate *displayDate;
@property(nonatomic, assign) BOOL isCenterDate;
@property(nonatomic, assign) BOOL isTodayDate;
@property(nonatomic, strong) NSDictionary *eventDictionary;
/**
 Returns cell reuse identifier

 @return cellReuseIdentifier of type NSString
 */
+ (NSString *)cellReuseIdentifier;

@end
