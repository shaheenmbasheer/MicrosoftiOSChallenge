//
//  MCParticipantLabel.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCParticipantLabel.h"
#import "MCGlobalHelpers.h"

@implementation MCParticipantLabel


/**
 Initializing MCParticipantLabel

 @return MCParticipantLabel
 */
-(instancetype)init{

    self = [super init];
    if (self) {
     
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.masksToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

/**
 This method is used to truncate and retrieve name from full name

 @param name full name as string
 @return truncated name.
 */
+(NSString *)partsOfName:(NSString *)name{

    if (![name length]) {
        //If name is nil, return empty string.
        return @" ";
    }
    //Get each string component if its a multi-part name.
    NSArray *partsOfName = [name componentsSeparatedByString:@" "];
    NSString *result = @"";
    for (NSString *string in partsOfName) {
        //For each name component, take the first letter and add it to result.
        result = [NSString stringWithFormat:@"%@%c", result, [string characterAtIndex:0]];
    }
    
    if ([result length] >= 2) {
        //If name is greater than 2, truncate it to two for display.
        result = [result substringToIndex:2];
    }else if([result length] == 0){
        result = @" ";
    }
    return result;
}


/**
 ParticipantName accessort method which is also used for setting color for "..." label.

 @param participantName participant name.
 */
-(void)setParticipantName:(NSString *)participantName{
    
    _participantName = participantName;
    if ([participantName isEqualToString:@"..."]) {
        //Add gray color if participant is a more lavel.
        self.text = participantName;
        self.backgroundColor = [UIColor grayColor];
    }else{
        self.text = [MCParticipantLabel partsOfName:participantName];
        self.backgroundColor = MCAutoThemeCreator();
    
    }
}
@end
