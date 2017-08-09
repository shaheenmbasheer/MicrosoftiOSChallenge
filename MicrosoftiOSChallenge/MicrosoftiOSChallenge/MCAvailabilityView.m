//
//  MCAvailabilityView.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCAvailabilityView.h"

@implementation MCAvailabilityView

-(void)setAvailabilty:(MCAvailabilityViewKey)availabilty{

    _availabilty = availabilty;
    
    switch (availabilty) {
        case MCAvailabilityViewKeyAvailable:
            
            self.backgroundColor = [UIColor greenColor];
            break;
        case MCAvailabilityViewKeyAway:
            self.backgroundColor = [UIColor yellowColor];

            break;
        case MCAvailabilityViewKeyBusy:
            self.backgroundColor = [UIColor redColor];

            break;
            
        default:
            self.backgroundColor = [UIColor greenColor];

            break;
            
              }
    
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = YES;




}
@end
