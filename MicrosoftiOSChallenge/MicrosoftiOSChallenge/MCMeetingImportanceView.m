//
//  MCAvailabilityView.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCMeetingImportanceView.h"

@implementation MCMeetingImportanceView

-(void)setMeetingImportance:(MCMeetingImportanceViewKey)meetingImportance{

    _meetingImportance = meetingImportance;
    
    switch (meetingImportance) {
        case MCMeetingImportanceViewKeyNotImportant:
            
            self.backgroundColor = [UIColor greenColor];
            break;
        case MCMeetingImportanceViewKeyMediumImportance:
            self.backgroundColor = [UIColor yellowColor];

            break;
        case MCMeetingImportanceViewKeyHighImportance:
            self.backgroundColor = [UIColor redColor];

            break;
            
        default:
            self.backgroundColor = [UIColor greenColor];

            break;
            
              }
    
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = YES;




}
-(void)setImportance:(NSString *)importance{
    
    _importance = importance;
    
    if ([importance isEqualToString:@"High"]) {
        self.meetingImportance = MCMeetingImportanceViewKeyHighImportance;
    }else if([importance isEqualToString:@"Medium"]){
        self.meetingImportance = MCMeetingImportanceViewKeyMediumImportance;
    }else if([importance isEqualToString:@"Low"]){
        self.meetingImportance = MCMeetingImportanceViewKeyNotImportant;
    }else{
        self.meetingImportance = MCMeetingImportanceViewKeyUnknown;

    }

}
@end
