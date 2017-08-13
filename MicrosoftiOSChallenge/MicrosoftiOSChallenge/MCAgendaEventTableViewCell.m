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


/**
 Outlier stack view is a horizontal stackview consisting of 2 sub vertical stacviews and a label
 */
@property(nonatomic, strong) UIStackView *outlierStackView;
@end

@implementation MCAgendaEventTableViewCell

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
        //Cell contentview needs its autoresizing mask to work properly with subview constraints.
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;

          }
    return self;
}


/**
 Prepare for reuse
 */
-(void)prepareForReuse{
    [super prepareForReuse];
    //Remove outlier stack before cell reuse.
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
    MCMeetingImportanceView *meetingImportanceView = ({
    
        MCMeetingImportanceView *meetingImportanceView = [[MCMeetingImportanceView alloc] init];
        meetingImportanceView.importance = self.eventData.importance;
        [meetingImportanceView.heightAnchor constraintEqualToConstant:10].active = true;
        [meetingImportanceView.widthAnchor constraintEqualToConstant:10].active = true;
        meetingImportanceView.layer.cornerRadius = 5;
        meetingImportanceView;
    });
    
    //Most outlier horizontal stackview.
    self.outlierStackView = ({
    
        //Initializing outlier stackview with respective settings.
        UIStackView *outlierStackView = [[UIStackView alloc] initWithFrame:self.contentView.bounds];
        outlierStackView.axis = UILayoutConstraintAxisHorizontal;
        outlierStackView.distribution = UIStackViewDistributionFill;
        outlierStackView.alignment = UIStackViewAlignmentTop;
        outlierStackView.spacing = 10;
        outlierStackView.translatesAutoresizingMaskIntoConstraints = false;
        outlierStackView;
    });
    
    [_outlierStackView addArrangedSubview:[self getTimeAndDurationAsStackView:self.eventData]];
    [_outlierStackView addArrangedSubview:meetingImportanceView];
    [_outlierStackView addArrangedSubview:[self getSubjectParticipantsAndLocationAsStackView:self.eventData]];
    
    //Adding outlier stackview to tableviewcell.
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

/**
 This method is used to generate vertical stackview containing time and duration.
 This vertical stack view is positioned in the left pane of cell.

 @param eventData event data
 @return vertical stackview containing time and duration labels.
 */
- (UIStackView *)getTimeAndDurationAsStackView:(MCEventData *)eventData{


    //Stack View
    UIStackView *timeVerticalStackView =({
        //Time and duration vertical stackview initialization.
        UIStackView *timeVerticalStackView = [[UIStackView alloc] init];
        timeVerticalStackView.axis = UILayoutConstraintAxisVertical;
        timeVerticalStackView.distribution = UIStackViewDistributionFill;
        timeVerticalStackView.alignment = UIStackViewAlignmentFill;
        timeVerticalStackView.spacing = 0;
        timeVerticalStackView;
    });
    
    [timeVerticalStackView addArrangedSubview:({
        //Time label will contain event start time in hh mm a format.
        //Adding time label as subview to stackview.
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.text = [MCDateRangeManager calculateStringFromDate:eventData.startTime withFormat:@"hh:mm a"];
        timeLabel.textColor = [UIColor darkGrayColor];
        timeLabel.adjustsFontSizeToFitWidth = YES;
        timeLabel;
    
    })];
    //Adding duration label as
    [timeVerticalStackView addArrangedSubview:({
        //Duration label will contain difference between event start and end time.
        //Initializing duration label with respective settings. Adding durationLabel as subview to stackview.
        UILabel *durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        durationLabel.textAlignment = NSTextAlignmentLeft;
        durationLabel.font = [UIFont boldSystemFontOfSize:12];
        durationLabel.text = eventData.duration;
        durationLabel.textColor = [UIColor grayColor];
        durationLabel.adjustsFontSizeToFitWidth = YES;
        durationLabel;
    })];

    
    return timeVerticalStackView;
}


/**
 This method is used to generate horizontal stackview with marker and location label.

 @param eventData event data
 @return vertical stackview with marker and location.
 */
-(UIStackView *)getMarkerAndLocationAsStackView:(MCEventData *)eventData{

    
    //Stack View
    UIStackView *locationHorizontalStackView = ({
        //Initializing horizontal stackview for marker and location.
        UIStackView *locationHorizontalStackView = [[UIStackView alloc] init];
        locationHorizontalStackView.axis = UILayoutConstraintAxisHorizontal;
        locationHorizontalStackView.distribution = UIStackViewDistributionFill;
        locationHorizontalStackView.alignment = UIStackViewAlignmentCenter;
        locationHorizontalStackView.spacing = 5;
        locationHorizontalStackView;
    });

    [locationHorizontalStackView addArrangedSubview:({
        //Initializing and adding marker as subviiew to location stackview.
        UIImageView *locationMarkerImageView = [[UIImageView alloc] init];
        locationMarkerImageView.image = [UIImage imageNamed:@"LocationMarker"];
        [locationMarkerImageView.heightAnchor constraintEqualToConstant:20].active = true;
        [locationMarkerImageView.widthAnchor constraintEqualToConstant:20].active = true;
        locationMarkerImageView;
    })];
    [locationHorizontalStackView addArrangedSubview:({
        //Initializing and adding location label as subview to location stackview.
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        locationLabel.textAlignment = NSTextAlignmentLeft;
        locationLabel.text = eventData.location;
        locationLabel.font = [UIFont systemFontOfSize:13];
        locationLabel.numberOfLines = 0;
        locationLabel.textColor = [UIColor darkGrayColor];
        locationLabel;
    })];

     return locationHorizontalStackView;
}

/**
 This method generates container stackview for other stack views in cell right pane.
 This vertical stackview contains subject; participants and location stackviews.

 @param eventData event data
 @return vertical stackview containing subject; participants and location stackviews.
 */
-(UIStackView *)getSubjectParticipantsAndLocationAsStackView:(MCEventData *)eventData{

    //Stack View
    UIStackView *subjectParticipantsAndLocationStackView =({
        //Initializing vertical stackview for subject, participants and location in their respective order.
        UIStackView *subjectParticipantsAndLocationStackView = [[UIStackView alloc] init];
        subjectParticipantsAndLocationStackView.axis = UILayoutConstraintAxisVertical;
        subjectParticipantsAndLocationStackView.distribution = UIStackViewDistributionFill;
        subjectParticipantsAndLocationStackView.alignment = UIStackViewAlignmentFill;
        subjectParticipantsAndLocationStackView.spacing = 10;
        subjectParticipantsAndLocationStackView;
    
    });
    
    [subjectParticipantsAndLocationStackView addArrangedSubview:({
        //Initializing and adding subjectLabel as first entity in subjectParticipantsAndLocationStackView.
        UILabel *subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        subjectLabel.textAlignment = NSTextAlignmentLeft;
        subjectLabel.text = eventData.subject;
        subjectLabel.numberOfLines = 0;
        subjectLabel.textColor = [UIColor darkGrayColor];
        subjectLabel;
    })];
    
    //Adding participant stackview only if attendees exist in eventData.
    if ([eventData.attendees count]) {
        //Retrieving participant list stackview and adding it as subview.
        [subjectParticipantsAndLocationStackView addArrangedSubview:[self getParticipantsListAsStackView:eventData.attendees]];
    }
    
    //Adding location stackview only if location exists in eventData.
    if ([eventData.location length]) {
        //Retrieving location stackview and adding it as subview.
        [subjectParticipantsAndLocationStackView addArrangedSubview:[self getMarkerAndLocationAsStackView:eventData]];

    }

    [subjectParticipantsAndLocationStackView addArrangedSubview:({
        //Adding overflow view to keep a consistent width for the horizontal stackview.
        UIView *overflowView = [[UIView alloc] init];
        overflowView.backgroundColor = [UIColor whiteColor];
        [overflowView.heightAnchor constraintEqualToConstant:1].active = true;
        [overflowView.widthAnchor constraintEqualToConstant:220].active = true;
        overflowView;
    })];
    
    return subjectParticipantsAndLocationStackView;
}


/**
 This method generates container stackview for list of participants

 @param participants participants in eventData
 @return horizontal stackview containing MCParticipantLabel's.
 */
-(UIStackView *)getParticipantsListAsStackView:(NSArray *)participants{

    //Stack View
    UIStackView *participantHorizontalStackView = ({
        
        UIStackView *participantHorizontalStackView = [[UIStackView alloc] init];
        participantHorizontalStackView.axis = UILayoutConstraintAxisHorizontal;
        participantHorizontalStackView.distribution = UIStackViewDistributionFill;
        participantHorizontalStackView.alignment = UIStackViewAlignmentCenter;
        participantHorizontalStackView.spacing = 5;
        participantHorizontalStackView;
    });
    //Calculating display names from participant data
    NSMutableArray *names = [@[] mutableCopy];
    for (MCParticipantData *participant in participants) {
        [names addObject:participant.name];
    }
    //If number of participants are more than 4 add a "..." at the end.
    if ([names count] > 3) {
        names =  [[names subarrayWithRange:NSMakeRange(0, 3)] mutableCopy];
        [names addObject:@"..."];
    }
    
    for (NSString *name in names) {
        //For each calculated name, create label and add them to stackview.
        [participantHorizontalStackView addArrangedSubview:({
            //Adding participant name to horizontal stackview.
            MCParticipantLabel *nameLabel = [[MCParticipantLabel alloc] init];
            [nameLabel setParticipantName:name];
            [nameLabel.heightAnchor constraintEqualToConstant:40].active = true;
            [nameLabel.widthAnchor constraintEqualToConstant:40].active = true;
            nameLabel.layer.cornerRadius = 20;
            nameLabel;
        })];
    }
    //If there is only one participant, display his full name alongside the truncated name.
    if ([names count] == 1) {
        
        [participantHorizontalStackView addArrangedSubview:({
            //Adding participant full name.
            UILabel *displayLabel = [[UILabel alloc] init];
            displayLabel.textAlignment = NSTextAlignmentCenter;
            displayLabel.text = names[0];
            displayLabel.textColor = [UIColor darkGrayColor];
            displayLabel;
        
        })];
    }
    
    [participantHorizontalStackView addArrangedSubview:({
        //Adding overflow view to keep a consistent height in respective stackview.
        UIView *overflowView = [[UIView alloc] init];
        overflowView.backgroundColor = [UIColor whiteColor];
        [overflowView.heightAnchor constraintEqualToConstant:40].active = true;
        [overflowView.widthAnchor constraintGreaterThanOrEqualToConstant:1].active = true;
        overflowView;
    
    })];
    
    return participantHorizontalStackView;
}


/**
 Returns cell reuse identifier
 
 @return cellReuseIdentifier of type NSString
 */
+ (NSString *)cellReuseIdentifier{

    return @"MCAgendaEventTableViewCellkReuseKey";
}

/**
 Cell input data as specified by MCBaseTableViewCellProtocol

 @param data cell data
 */
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
