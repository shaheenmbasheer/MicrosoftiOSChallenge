//
//  MCBaseTableViewCellProtocol.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 10/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

@import Foundation;
/**
 MCBaseTableViewCellProtocol defines the base protocol for every tableiView cell in
 Agenda control.
 */
@protocol MCBaseTableViewCellProtocol <NSObject>
/**
 Input date required for the particular cell
 
 @param data cell inputData
 */
-(void)inputData:(id)data;
@end
