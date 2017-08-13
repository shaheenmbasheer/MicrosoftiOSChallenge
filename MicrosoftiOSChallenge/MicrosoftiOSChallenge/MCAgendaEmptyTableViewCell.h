//
//  MCAgendaEmptyTableViewCell.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCBaseTableViewCellProtocol.h"

@import UIKit;
/**
 MCAgendaEmptyTableViewCell is displayed in Agenda control if there is no event.
 */
@interface MCAgendaEmptyTableViewCell : UITableViewCell<MCBaseTableViewCellProtocol>

/**
 Returns cell reuse identifier
 
 @return cellReuseIdentifier of type NSString
 */
+ (NSString *)cellReuseIdentifier;
@end
