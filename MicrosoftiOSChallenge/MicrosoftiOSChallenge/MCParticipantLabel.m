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


-(instancetype)init{

    self = [super init];
    if (self) {
     
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.masksToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return self;
}
+(NSString *)partsOfName:(NSString *)name{

    if (![name length]) {
        return @" ";
    }
    NSArray *partsOfName = [name componentsSeparatedByString:@" "];
    NSString *result = @"";

    for (NSString *string in partsOfName) {
        
        result = [NSString stringWithFormat:@"%@%c", result, [string characterAtIndex:0]];
    }

    if ([result length] >= 2) {
        result = [result substringToIndex:2];
    }else if([result length] == 0){
    
        result = @" ";
    }
    return result;
}

-(void)setParticipantName:(NSString *)participantName{


    _participantName = participantName;
   
    if ([participantName isEqualToString:@"..."]) {
        self.text = participantName;
        self.backgroundColor = [UIColor grayColor];
    }else{
        self.text = [MCParticipantLabel partsOfName:participantName];
        self.backgroundColor = MCAutoThemeCreator();
    
    }
    
}
@end
