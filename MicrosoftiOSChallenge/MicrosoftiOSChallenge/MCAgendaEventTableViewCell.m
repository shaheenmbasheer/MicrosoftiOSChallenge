//
//  MCAgendaEventTableViewCell.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCAgendaEventTableViewCell.h"
#import "MCParticipantLabel.h"
#import "MCMeetingImportanceView.h"
#import "MCDateRangeManager.h"
#import "MCParticipantData.h"

@interface MCAgendaEventTableViewCell()

@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *duration;
@property(nonatomic, strong) UIView *status;
@property(nonatomic, strong) UILabel *eventDescription;
@property(nonatomic, strong) NSArray *eventParticipantsList;
@property(nonatomic, strong) UIStackView *outlierStackView;
@end

@implementation MCAgendaEventTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;

          }
    return self;
}

-(void)prepareForReuse{
    [super prepareForReuse];
    
    [self.outlierStackView removeFromSuperview];
    self.outlierStackView = nil;
}

-(void)setUpConstraints{

    // The setup totally consists of 5 stackview
    // 1- Horizontal outlier stackview
    // 2- Vertical stackview for time and duration
    // 3- Vertical stackview for subject, participants and location
    // 4- Horizontal stackview for participants
    // 5- Horizontal stackview for location icon and location description
    
    //MCAvailabilityView for showing meeting importance
    MCMeetingImportanceView *meetingImportanceView = [[MCMeetingImportanceView alloc] init];
    meetingImportanceView.importance = self.eventData.importance;
    [meetingImportanceView.heightAnchor constraintEqualToConstant:10].active = true;
    [meetingImportanceView.widthAnchor constraintEqualToConstant:10].active = true;
    meetingImportanceView.layer.cornerRadius = 5;
    
    //Most outlier horizontal stackview.
    self.outlierStackView = [[UIStackView alloc] initWithFrame:self.contentView.bounds];
    
    _outlierStackView.axis = UILayoutConstraintAxisHorizontal;
    _outlierStackView.distribution = UIStackViewDistributionFill;
    _outlierStackView.alignment = UIStackViewAlignmentTop;
    _outlierStackView.spacing = 20;
    [_outlierStackView addArrangedSubview:[self getTimeAndDurationAsStackView:self.eventData]];
    [_outlierStackView addArrangedSubview:meetingImportanceView];
    [_outlierStackView addArrangedSubview:[MCAgendaEventTableViewCell getSubjectParticipantsAndLocationAsStackView:self.eventData]];
    _outlierStackView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.contentView addSubview:_outlierStackView];
    //Adding horizontal contraints for bottomView
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[stackView]|"
                                             options:0 metrics:nil
                                               views:@{@"stackView":_outlierStackView}]
     ];
    
    //Adding vertical contraints for bottomView
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[stackView]-(5)-|"
                                             options:0 metrics:nil
                                               views:@{@"stackView":_outlierStackView}]];
    [self.contentView setNeedsUpdateConstraints];

}
- (UIStackView *)getTimeAndDurationAsStackView:(MCEventData *)eventData{

    UILabel *durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    durationLabel.textAlignment = NSTextAlignmentLeft;
    durationLabel.font = [UIFont boldSystemFontOfSize:12];
    durationLabel.text = eventData.duration;
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
        timeLabel.text = [MCDateRangeManager calculateStringFromDate:eventData.startTime withFormat:@"hh:mm a"];
//        timeLabel.text = @"10 30 am";

        timeLabel.textColor = [UIColor darkGrayColor];
        timeLabel;
    
    })];
    [timeVerticalStackView addArrangedSubview:durationLabel];

    return timeVerticalStackView;
}

+ (UIStackView *)getMarkerAndLocationAsStackView:(MCEventData *)eventData{

    
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
    displayLabel.text = eventData.location;
    displayLabel.font = [UIFont systemFontOfSize:13];
    displayLabel.numberOfLines = 0;
    displayLabel.textColor = [UIColor darkGrayColor];
  

    [eventStackView addArrangedSubview:locationMarkerImageView];
    [eventStackView addArrangedSubview:displayLabel];

     return eventStackView;
}

+ (UIStackView *)getSubjectParticipantsAndLocationAsStackView:(MCEventData *)eventData{

    //Stack View
    UIStackView *verticalStackView = [[UIStackView alloc] init];
    
    verticalStackView.axis = UILayoutConstraintAxisVertical;
    verticalStackView.distribution = UIStackViewDistributionFill;
    verticalStackView.alignment = UIStackViewAlignmentFill;
    verticalStackView.spacing = 10;
    
    UILabel *subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    subjectLabel.textAlignment = NSTextAlignmentLeft;
    subjectLabel.text = eventData.subject;
    subjectLabel.numberOfLines = 0;
    subjectLabel.textColor = [UIColor darkGrayColor];
    [verticalStackView addArrangedSubview:subjectLabel];
    
    UIStackView *participantStackView = [MCAgendaEventTableViewCell getParticipantsListAsStackView:eventData.attendees];
    if ([eventData.attendees count]) {
        [verticalStackView addArrangedSubview:participantStackView];

    }
    if ([eventData.location length]) {
        [verticalStackView addArrangedSubview:[MCAgendaEventTableViewCell getMarkerAndLocationAsStackView:eventData]];

    }

    UIView *overflowView = [[UIView alloc] init];
    overflowView.backgroundColor = [UIColor whiteColor];
    [overflowView.heightAnchor constraintEqualToConstant:1].active = true;
    [overflowView.widthAnchor constraintEqualToConstant:225].active = true;

    [verticalStackView addArrangedSubview:overflowView];
    
    return verticalStackView;
}
+ (UIStackView *)getParticipantsListAsStackView:(NSArray *)participants{

    //Stack View
    UIStackView *eventStackView = [[UIStackView alloc] init];
    
    eventStackView.axis = UILayoutConstraintAxisHorizontal;
    eventStackView.distribution = UIStackViewDistributionFill;
    eventStackView.alignment = UIStackViewAlignmentCenter;
    eventStackView.spacing = 5;
    
//    NSMutableArray *names = [@[@"Shaheen M Basheer", @"Ruksana Banu", @"Nial Harris", @"Ruksana Banu", @"Ruksana Banu", @"Ruksana Banu"] mutableCopy];
//                    NSMutableArray *names = [@[@"Shaheen M Basheer"] mutableCopy];
    
    NSMutableArray *names = [@[] mutableCopy];
    for (MCParticipantData *participant in participants) {
        [names addObject:participant.name];
    }
    
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
-(void)inputData:(id)data{

    self.eventData = (MCEventData *)data;
    [self setUpConstraints];

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
