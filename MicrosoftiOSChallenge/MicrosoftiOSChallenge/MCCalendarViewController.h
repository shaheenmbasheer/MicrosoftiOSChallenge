//
//  MCCalendarCollectionViewController.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import UIKit;

/**
 MCCalendarViewControllerDelegate is used to forward events when user taps on
 any cell in the calendar
 */
@protocol MCCalendarViewControllerDelegate <NSObject>

/**
 MCAgendaViewControllerDelegate repective delegate method is called when user scrolls to an indexPath.
 Once this event is called, its forwarded to MCCalendarViewController to select the respective
 date in calendar control.
 
 @param indexPath - MCCalendarViewControllerDelgate tableview indexPath to which user scrolled.
 */
- (void)didSelectCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)willScrollToTodayDate;

@end

/**
 MCCalendarCollectionViewController is used to display calendar interface to the user.
 User events on the calendar is handled by the class and tap event delegate methods are
 forwarded to MCCalendarAgendaViewController.
 */
@interface MCCalendarViewController : UIViewController
/**
 MCCalendarViewControllerDelegate object to which events are forwarded. The object
 is MCCalendarAgendaViewController in current scenario.
 */
@property(nonatomic, weak) id<MCCalendarViewControllerDelegate> delegate;
@property(nonatomic, strong) NSDictionary *eventDictionary;

/**
 Method scroll's to today's date in calendar control.
 */
- (void)scrollToCurrentDate;

/**
 Method scrolls to given indexPath in calendar and selects the particular cell

 @param indexPath indexPath to which calendar should scroll.
 */
- (void)scrollToIndexPath:(NSIndexPath *)indexPath;
-(void)reloadData;

@end
