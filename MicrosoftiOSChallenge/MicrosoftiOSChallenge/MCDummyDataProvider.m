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
 Method for converting JSON file to NSDictionary/NSArray

 @param fileLocation name of JSON file from which data is loaded
 @return object of type NSDictionary/NSArray
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
 User  Outlook list of events for range of date Request
 
 @param completionBlock completionBlock
 @param errorBlock      errorBlock
 */
-(void)fetchOutlookEventsWithCompletionBlock:(CompletionBlock)completionBlock withErrorBlock:(ErrorBlock)errorBlock{

    completionBlock([MCDummyDataProvider dictionaryWithContentsOfJSONStringForFile:@"GetEventData"]);
}

/**
 Weather request for daily weather details.
 
 @param request contains weather request object
 @param completionBlock daily weather details
 @param errorBlock encountered error
 */
-(void)fetchForecastWeatherDataWithRequest:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock withErrorBlock:(ErrorBlock)errorBlock{
    
    completionBlock([MCDummyDataProvider dictionaryWithContentsOfJSONStringForFile:@"GetWeatherData"]);
}
@end
