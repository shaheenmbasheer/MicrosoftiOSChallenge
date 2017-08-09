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
        
        
        
        //View 1
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = [UIColor blueColor];
        [view1.heightAnchor constraintEqualToConstant:100].active = true;
        [view1.widthAnchor constraintEqualToConstant:120].active = true;
        
        
        //View 2
        UIView *view2 = [[UIView alloc] init];
        view2.backgroundColor = [UIColor greenColor];
        [view2.heightAnchor constraintEqualToConstant:100].active = true;
        [view2.widthAnchor constraintEqualToConstant:70].active = true;
        
        //View 3
        UIView *view3 = [[UIView alloc] init];
        view3.backgroundColor = [UIColor magentaColor];
        [view3.heightAnchor constraintEqualToConstant:100].active = true;
        [view3.widthAnchor constraintEqualToConstant:180].active = true;
        
        //Stack View
        UIStackView *stackView = [[UIStackView alloc] initWithFrame:self.contentView.bounds];
        
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.distribution = UIStackViewDistributionEqualSpacing;
        stackView.alignment = UIStackViewAlignmentCenter;
        stackView.spacing = 30;
        
        
        [stackView addArrangedSubview:view1];
        [stackView addArrangedSubview:view2];
        [stackView addArrangedSubview:view3];
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:stackView];

        
        //Layout for Stack View
        [stackView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = true;
        [stackView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = true;
   
////

//        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//        _emptyLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        //Adding horizontal contraints for bottomView
//        [self.contentView addConstraints:
//         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_emptyLabel(100)]-(>=20)-|"
//                                                 options:0 metrics:nil
//                                                   views:@{@"_emptyLabel":_emptyLabel}]
//         ];
//        
//        //Adding vertical contraints for bottomView
//        [self.contentView addConstraints:
//         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_emptyLabel(40)]|"
//                                                 options:0 metrics:nil
//                                                   views:@{@"_emptyLabel":_emptyLabel}]];
//        [self.contentView setNeedsUpdateConstraints];
//        //
//        self.contentView.backgroundColor = [UIColor greenColor];
    }
    return self;
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
