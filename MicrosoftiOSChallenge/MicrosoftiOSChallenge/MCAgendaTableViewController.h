//
//  MCAgendaTableViewController.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 MCAgendaTableViewControllerDelegate is used to forward events to the delegate object when user
 scrolls to any particular indexPath.
 */
@protocol MCAgendaTableViewControllerDelegate <NSObject>
/**
MCAgendaViewControllerDelegate repective delegate method is called when user scrolls to an indexPath.
Once this event is called, its forwarded to MCCalendarViewController to select the respective
date in calendar control.

@param indexPath - MCCalendarViewControllerDelgate tableview indexPath to which user scrolled.
*/
- (void)didScrollToTableIndex:(NSIndexPath *)indexPath;
@end

/**
 MCAgendaTableViewController is used to display events respective to the date
 the user.
 */
@interface MCAgendaTableViewController : UITableViewController
/**
 MCAgendaTableViewControllerDelegate object to which events are forwarded. The object
 is MCCalendarAgendaViewController in current scenario.
 */
@property (nonatomic, weak) id<MCAgendaTableViewControllerDelegate> delegate;
@property (nonatomic, strong) NSDictionary *eventDictionary;
@property (nonatomic, strong) NSDictionary *weatherDictionary;
/**
 Method scrolls to given indexPath in table and selects the particular cell
 @param indexPath indexPath to which table should scroll.
 */
-(void)scrollToIndexPath:(NSIndexPath *)indexPath;
/**
 Method is used to reload MCAgendaTableViewController
 */
-(void)reloadData;
/**
 Method is used to stop tableview scroll deceleration
 */
-(void)stopScrollDeceleration;
@end
