//
//  MCDummyDataProvider.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCDummyDataProvider.h"

@implementation MCDummyDataProvider


/**
 *  Method for converting JSON file to NSDictionary/NSArray
 *
 *  @param fileLocation name of JSON file from which data is loaded
 *
 *  @return object of type NSDictionary/NSArray
 */
+(id)dictionaryWithContentsOfJSONStringForFile:(NSString*)fileLocation{
    
    NSURL *filePathURL = [[NSBundle mainBundle] URLForResource:fileLocation withExtension:@"json"];
    NSData* data = [NSData dataWithContentsOfURL:filePathURL];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

/**
 *  User  Outlook list of events for range of date Request
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       forceLoad specifies if data should be forcefully loaded from server
 */
-(void)fetchOutlookEventsWithCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock enableForceLoad:(BOOL)forceLoad{


    completionBlock([MCDummyDataProvider dictionaryWithContentsOfJSONStringForFile:@"GetEventData"]);

}
@end
