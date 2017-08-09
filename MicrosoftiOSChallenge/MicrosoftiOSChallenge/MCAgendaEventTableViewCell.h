//
//  MCAgendaEventTableViewCell.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import UIKit;


/**
 * MCAgendaEventTableViewCell is used to display events in AgendaTableView
 */
@interface MCAgendaEventTableViewCell : UITableViewCell

/**
 Returns cell reuse identifier
 
 @return cellReuseIdentifier of type NSString
 */
+ (NSString *)cellReuseIdentifier;
- (void)prepareData;
@end
