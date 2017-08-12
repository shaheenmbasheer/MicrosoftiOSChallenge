 //
//  MCNetworkConnection.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCNetworkConnection.h"

@implementation MCNetworkConnection

+(void)establishConnectionWithObject:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock{


    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    
    NSString *urlString = [request generateRequestURL];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:urlRequest
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    // handle response
                    //                    NSLog(@"Response data %@",[data responseString]);
                    if (data) {
                        NSDictionary *parsedResponse =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        
                        
                        
                        completionBlock(parsedResponse);
                        dispatch_semaphore_signal(semaphore);
                        
                    }else{
                        
                        errorBlock(error);
                        dispatch_semaphore_signal(semaphore);
                        
                    }
                    
                }] resume];
    
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

}
@end

