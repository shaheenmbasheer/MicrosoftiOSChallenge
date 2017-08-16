//
//  MCCalendarAgendaContainerView.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 04/08/17.
//  Copyright © 2017 Shaheen M. All rights reserved.
//

@import UIKit;

/**
 MCCalendarAgendaContainerViewDelegate is triggered on pan gesture event
 in the container view to the controllers.
 */
@protocol MCCalendarAgendaContainerViewDelegate <NSObject>


/**
 The method is called when the user starts pan gesture in container view.
 */
-(void)didStartPanningCalendarAgendaContainerView;

@end
/**
 MCCalendarAgendaContainerView handles both Calendar subview and Agenda subview and their constraints.
 The Pan operation along with view animation is also handled by this class.
 */
@interface MCCalendarAgendaContainerView : UIView

/**
 Init method that returns MCCalendarAgendaContainerView object
 
 @param topView topView of the container - Calendar view
 @param bottomView bottonView of the container - Agenda view
 @return returns initialized object of type MCCalendarAgendaContainerView
 */
-(instancetype)initWithTopView:(UIView *)topView andBottomView:(UIView *)bottomView;
@property(nonatomic, weak) id<MCCalendarAgendaContainerViewDelegate> delegate;
@end
