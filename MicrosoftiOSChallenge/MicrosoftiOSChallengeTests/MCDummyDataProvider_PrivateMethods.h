//
//  MCDummyDataProvider_PrivateMethods.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 13/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCDummyDataProvider.h"
/**
 MCDummyDataProvider extension for exposing private classes
 */
@interface MCDummyDataProvider ()

+(NSDictionary*)dictionaryWithContentsOfJSONStringForFile:(NSString*)fileLocation;
@end
