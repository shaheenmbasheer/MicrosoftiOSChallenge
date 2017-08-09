//
//  MCAgendaEventTableViewCell.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCAgendaEventTableViewCell.h"
#import "MCParticipantLabel.h"
#import "MCAvailabilityView.h"

@interface MCAgendaEventTableViewCell()

@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *duration;
@property(nonatomic, strong) UIView *status;
@property(nonatomic, strong) UILabel *eventDescription;
@property(nonatomic, strong) NSArray *eventParticipantsList;
@end

@implementation MCAgendaEventTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;

        //MCAvailabilityView for showing meeting importance
        MCAvailabilityView *availabilityView = [[MCAvailabilityView alloc] init];
        availabilityView.availabilty = MCAvailabilityViewKeyBusy;
        [availabilityView.heightAnchor constraintEqualToConstant:10].active = true;
        [availabilityView.widthAnchor constraintEqualToConstant:10].active = true;
        availabilityView.layer.cornerRadius = 5;

        //Most outlier horizontal stackview.
        UIStackView *stackView = [[UIStackView alloc] initWithFrame:self.contentView.bounds];
        
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.distribution = UIStackViewDistributionFill;
        stackView.alignment = UIStackViewAlignmentTop;
        stackView.spacing = 20;
        [stackView addArrangedSubview:[MCAgendaEventTableViewCell getTimeAndDurationAsStackView:nil]];
        [stackView addArrangedSubview:availabilityView];
        [stackView addArrangedSubview:[MCAgendaEventTableViewCell getSubjectParticipantsAndLocationAsStackView:nil]];
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        [self.contentView addSubview:stackView];
        //Adding horizontal contraints for bottomView
        [self.contentView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[stackView]|"
                                                 options:0 metrics:nil
                                                   views:@{@"stackView":stackView}]
         ];
        
        //Adding vertical contraints for bottomView
        [self.contentView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[stackView]-(5)-|"
                                                 options:0 metrics:nil
                                                   views:@{@"stackView":stackView}]];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

+ (UIStackView *)getTimeAndDurationAsStackView:(NSArray *)participants{

    UILabel *durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    durationLabel.textAlignment = NSTextAlignmentLeft;
    durationLabel.font = [UIFont boldSystemFontOfSize:12];
    durationLabel.text = @"9 h 30 m";
    durationLabel.textColor = [UIColor grayColor];
    
    //Stack View
    UIStackView *timeVerticalStackView = [[UIStackView alloc] init];
    
    timeVerticalStackView.axis = UILayoutConstraintAxisVertical;
    timeVerticalStackView.distribution = UIStackViewDistributionFill;
    timeVerticalStackView.alignment = UIStackViewAlignmentFill;
    timeVerticalStackView.spacing = 0;
    
    
    [timeVerticalStackView addArrangedSubview:({
    
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.text = @"10:30 am";
        timeLabel.textColor = [UIColor darkGrayColor];
        timeLabel;
    
    })];
    [timeVerticalStackView addArrangedSubview:durationLabel];

    return timeVerticalStackView;
}

+ (UIStackView *)getMarkerAndLocationAsStackView:(NSArray *)participants{

    
    //Stack View
    UIStackView *eventStackView = [[UIStackView alloc] init];
    
    eventStackView.axis = UILayoutConstraintAxisHorizontal;
    eventStackView.distribution = UIStackViewDistributionFill;
    eventStackView.alignment = UIStackViewAlignmentCenter;
    eventStackView.spacing = 5;
       //View 2
    UIImageView *locationMarkerImageView = [[UIImageView alloc] init];
    locationMarkerImageView.image = [UIImage imageNamed:@"LocationMarker"];
    [locationMarkerImageView.heightAnchor constraintEqualToConstant:20].active = true;
    [locationMarkerImageView.widthAnchor constraintEqualToConstant:20].active = true;
    
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    displayLabel.textAlignment = NSTextAlignmentLeft;
    displayLabel.text = @"Shaheen's office next to my office near the table";
    displayLabel.font = [UIFont systemFontOfSize:13];
    displayLabel.numberOfLines = 0;
    displayLabel.textColor = [UIColor darkGrayColor];
  

    [eventStackView addArrangedSubview:locationMarkerImageView];
    [eventStackView addArrangedSubview:displayLabel];

     return eventStackView;
}

+ (UIStackView *)getSubjectParticipantsAndLocationAsStackView:(NSArray *)participants{

    //Stack View
    UIStackView *verticalStackView = [[UIStackView alloc] init];
    
    verticalStackView.axis = UILayoutConstraintAxisVertical;
    verticalStackView.distribution = UIStackViewDistributionFill;
    verticalStackView.alignment = UIStackViewAlignmentFill;
    verticalStackView.spacing = 10;
    
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    displayLabel.textAlignment = NSTextAlignmentLeft;
    displayLabel.text = @"Scrum meeting ";
    displayLabel.numberOfLines = 0;
    displayLabel.textColor = [UIColor darkGrayColor];
    [verticalStackView addArrangedSubview:displayLabel];
    
    UIStackView *participantStackView = [MCAgendaEventTableViewCell getParticipantsListAsStackView:nil];
    if (participantStackView) {
        [verticalStackView addArrangedSubview:participantStackView];

    }
    [verticalStackView addArrangedSubview:[MCAgendaEventTableViewCell getMarkerAndLocationAsStackView:nil]];

    return verticalStackView;
}
+ (UIStackView *)getParticipantsListAsStackView:(NSArray *)participants{

    //Stack View
    UIStackView *eventStackView = [[UIStackView alloc] init];
    
    eventStackView.axis = UILayoutConstraintAxisHorizontal;
    eventStackView.distribution = UIStackViewDistributionFill;
    eventStackView.alignment = UIStackViewAlignmentCenter;
    eventStackView.spacing = 5;
    
    NSMutableArray *names = [@[@"Shaheen M Basheer", @"Ruksana Banu", @"Nial Harris", @"Ruksana Banu", @"Ruksana Banu", @"Ruksana Banu"] mutableCopy];
    //                NSMutableArray *names = [@[@"Shaheen M Basheer"] mutableCopy];
    
    if ([names count] > 4) {
        names =  [[names subarrayWithRange:NSMakeRange(0, 4)] mutableCopy];
        [names addObject:@"..."];
    }
    
    for (NSString *name in names) {
        MCParticipantLabel *label = [[MCParticipantLabel alloc] init];
        [label setParticipantName:name];
        [label.heightAnchor constraintEqualToConstant:40].active = true;
        [label.widthAnchor constraintEqualToConstant:40].active = true;
        label.layer.cornerRadius = 20;
        [eventStackView addArrangedSubview:label];
    }
    if ([names count] == 1) {
        
        UILabel *displayLabel = [[UILabel alloc] init];
        displayLabel.textAlignment = NSTextAlignmentCenter;
        displayLabel.text = names[0];
        displayLabel.textColor = [UIColor darkGrayColor];
        [eventStackView addArrangedSubview:displayLabel];
    }
    
    //View 2
    UIView *overflowView = [[UIView alloc] init];
    overflowView.backgroundColor = [UIColor whiteColor];
    [overflowView.heightAnchor constraintEqualToConstant:40].active = true;
    [overflowView.widthAnchor constraintGreaterThanOrEqualToConstant:1].active = true;
    
    
    [eventStackView addArrangedSubview:overflowView];
    
    return eventStackView;

}

- (void)prepareData{
    
    UILabel *emptyLabel = ({
        
        UILabel *displayLabel = [[UILabel alloc] init];
        displayLabel.textAlignment = NSTextAlignmentCenter;
        displayLabel.text = @"No events";
        displayLabel.textColor = [UIColor grayColor];
        displayLabel;
    });
    [self.contentView addSubview:emptyLabel];
    
}

/**
 Returns cell reuse identifier
 
 @return cellReuseIdentifier of type NSString
 */
+ (NSString *)cellReuseIdentifier{

    return @"MCAgendaEventTableViewCellkReuseKey";
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
