//
//  MCCalenderAgendaContainerView.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 04/08/17.
//  Copyright © 2017 Shaheen M. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 MCCalenderAgendaContainerView handles both Calender subview and Agenda subview and their constraints.
 The Pan operation along with view animation is also handled by this class.
 */
@interface MCCalenderAgendaContainerView : UIView

/**
 Init method that returns MCCalenderAgendaContainerView object
 
 @param topView topView of the container - Calender view
 @param bottomView bottonView of the container - Agenda view
 @return returns initialized object of type MCCalenderAgendaContainerView
 */
-(instancetype)initWithTopView:(UIView *)topView andBottomView:(UIView *)bottomView;
@end
