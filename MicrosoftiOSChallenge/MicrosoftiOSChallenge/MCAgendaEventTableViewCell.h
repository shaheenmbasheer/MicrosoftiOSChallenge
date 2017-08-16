//
//  MCAgendaEventTableViewCell.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCEventData.h"
#import "MCBaseTableViewCellProtocol.h"
@import UIKit;

/**
 * MCAgendaEventTableViewCell is used to display events in AgendaTableView
 */
@interface MCAgendaEventTableViewCell : UITableViewCell<MCBaseTableViewCellProtocol>

@property(nonatomic, strong) MCEventData *eventData;
/**
 Returns cell reuse identifier
 
 @return cellReuseIdentifier of type NSString
 */
+ (NSString *)cellReuseIdentifier;


@end
