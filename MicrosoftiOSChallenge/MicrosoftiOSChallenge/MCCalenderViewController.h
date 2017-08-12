//
//  MCCalenderCollectionViewController.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 MCCalenderViewControllerDelegate is used to forward events when user taps on
 any cell in the calender
 */
@protocol MCCalenderViewControllerDelegate <NSObject>

/**
 MCAgendaViewControllerDelegate repective delegate method is called when user scrolls to an indexPath.
 Once this event is called, its forwarded to MCCalenderViewController to select the respective
 date in calender control.
 
 @param indexPath - MCCalenderViewControllerDelgate tableview indexPath to which user scrolled.
 */
- (void)didSelectCellAtIndexPath:(NSIndexPath *)indexPath;
@end

/**
 MCCalenderCollectionViewController is used to display calender interface to the user.
 User events on the calender is handled by the class and tap event delegate methods are 
 forwarded to MCCalenderAgendaViewController.
 */
@interface MCCalenderViewController : UIViewController
/**
 MCCalenderViewControllerDelegate object to which events are forwarded. The object 
 is MCCalenderAgendaViewController in current scenario.
 */
@property(nonatomic, weak) id<MCCalenderViewControllerDelegate> delegate;
@property(nonatomic, strong) NSDictionary *eventDictionary;

/**
 Method scroll's to today's date in calender control.
 */
- (void)scrollToCurrentDate;

/**
 Method scrolls to given indexPath in calender and selects the particular cell

 @param indexPath indexPath to which calender should scroll.
 */
- (void)scrollToIndexPath:(NSIndexPath *)indexPath;
-(void)reloadData;

@end
