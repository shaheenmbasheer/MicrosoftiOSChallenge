//
//  MCAgendaEmptyTableViewCell.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCAgendaEmptyTableViewCell.h"

@interface MCAgendaEmptyTableViewCell()
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

-(void)inputData:(id)data{

}
-(void)prepareForReuse{
    [super prepareForReuse];

}

- (UIEdgeInsets)layoutMargins{
    
    return UIEdgeInsetsZero;
}
/**
 Initialization method
 
 @param frame frame of cell
 @return cell instance
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        

    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
