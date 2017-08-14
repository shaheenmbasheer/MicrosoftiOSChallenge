//
//  MCGlobalHelpers.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCGlobalHelpers.h"

/**
 Coded in such a way that it won't hide the darkest/lightest label
 
 @return UIColor parameter
 */
UIColor *MCAutoThemeCreator(){
    
    return [UIColor colorWithRed:((arc4random() % 70) + 20)/100.0f
                           green:((arc4random() % 70) + 20)/100.0f
                            blue:((arc4random() % 70) + 20)/100.0f
                           alpha:1];
    
    ;
}

