//
//  MCCalenderAgendaViewController.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCCalenderAgendaViewController.h"

@interface MCCalenderAgendaViewController ()

@end

@implementation MCCalenderAgendaViewController


#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Register controller defaults
    [self registerDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UserDefined Methods
-(void)registerDefaults{

}

#pragma mark - Class Methods
-(NSString *) getStoryBoardID{

    return @"kMCCalenderAgendaViewControllerKey";
}

#pragma mark - IBActions
#pragma mark - Accessor Methods

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
