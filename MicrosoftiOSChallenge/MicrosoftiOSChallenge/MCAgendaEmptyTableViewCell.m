//
//  MCAgendaEmptyTableViewCell.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCAgendaEmptyTableViewCell.h"

@interface MCAgendaEmptyTableViewCell()

/**
 EmptyLabel for displaying "No Events" or similar string.
 */
@property(nonatomic, strong) UILabel *emptyLabel;
@end
@implementation MCAgendaEmptyTableViewCell

/**
 Returns cell reuse identifier
 
 @return cellReuseIdentifier of type NSString
 */
+ (NSString *)cellReuseIdentifier{

    return @"kMCAgendaEmptyTableViewCellReuseKey";
}


/**
 Cell Initialization method
 
 @param style cell style
 @param reuseIdentifier cell reuse identifier
 @return initialized self.
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.emptyLabel = ({
            
            UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 40)];
            displayLabel.textAlignment = NSTextAlignmentCenter;
            displayLabel.text = @"No events";
            displayLabel.textColor = [UIColor grayColor];
            displayLabel;
        });
        [self.contentView addSubview:_emptyLabel];
    }
    return self;
}


/**
 Input data method as specified by MCBaseTableViewCellProtocol

 @param data cell inputData
 */
-(void)inputData:(id)data{
    //This method is blank as self is an empty cell.
}

@end
