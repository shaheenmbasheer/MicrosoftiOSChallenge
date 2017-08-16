 //
//  MCNetworkConnection.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCNetworkConnection.h"

@implementation MCNetworkConnection

/**
 Connects to server and returns parsed json response or encountered error.
 
 @param request requestObject contains request body and url information
 @param completionBlock completionBlock is called with parsed json on successful network connection
 @param errorBlock encountered error
 */
+(void)establishConnectionWithObject:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock withErrorBlock:(ErrorBlock)errorBlock{


    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //Generating request url.
    NSString *urlString = [request generateRequestURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:urlRequest
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    
                    if (data) {
                        
                        NSDictionary *parsedResponse =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        completionBlock(parsedResponse);
                        //Signalling context while encountering completion block
                        dispatch_semaphore_signal(semaphore);
                    }else{
                        
                        errorBlock(error);
                        //Signalling context while encountering error block
                        dispatch_semaphore_signal(semaphore);
                    }
                }] resume];
    //Waiting thread for completion block or error block execution.
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}
@end

