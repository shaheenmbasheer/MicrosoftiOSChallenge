//
//  MCCalendarAgendaViewController.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCCalendarAgendaViewController.h"
#import "MCCalendarAgendaContainerView.h"
#import "MCCalendarViewController.h"
#import "MCAgendaTableViewController.h"
#import "MCDateRangeManager.h"
#import "MCDataControllerManager.h"
#import "MCLocationManager.h"
#import "MCWeatherDataRequest.h"

@interface MCCalendarAgendaViewController ()<MCAgendaTableViewControllerDelegate, MCCalendarViewControllerDelegate, MCCalendarAgendaContainerViewDelegate>


/**
  MCCalendarAgendaContainerView is used to position calendar view and agenda view.
 */
@property(nonatomic, strong) MCCalendarAgendaContainerView *containerView;
/**
  MCCalendarViewController is used to handle calendar delegates and forward
  user events to calendarAgendaViewController.
 */
@property(nonatomic, strong) MCCalendarViewController *calendarViewController;
/**
 MCAgendaTableViewController is used to handle agenda delegates and forward
 user events to calendarAgendaViewController.
*/

@property (weak, nonatomic) IBOutlet UIBarButtonItem *monthBarButtonItem;

@property(nonatomic, strong) MCAgendaTableViewController *agendaViewController;
@end

@implementation MCCalendarAgendaViewController


#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Register controller defaults
    [self registerDefaults];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UserDefined Methods

/**
 * Used to register default values for view controller
 */
-(void)registerDefaults{
    
    // Turning off translatesAutoresizingMaskIntoConstraints to work with constraints.
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Intializing container view with calendar and agenda views
    self.containerView = [[MCCalendarAgendaContainerView alloc] initWithTopView:({
        
        //Returns MCCalendarAgendaContainerView as topView
        self.calendarViewController = [[MCCalendarViewController alloc] init];
        _calendarViewController.view.backgroundColor = [UIColor grayColor];
        _calendarViewController.delegate = self;
        [self addChildViewController:_calendarViewController];
        _calendarViewController.view;

    }) andBottomView:({
        
        //Returns MCAgendaTableViewController as bottomView
        self.agendaViewController  = [[MCAgendaTableViewController alloc] init];
        _agendaViewController.view.backgroundColor = [UIColor whiteColor];
        _agendaViewController.delegate = self;
        [self addChildViewController:_agendaViewController];
        _agendaViewController.view;
    })];
    
    self.containerView.delegate = self;
    // Turning off translatesAutoresizingMaskIntoConstraints to work with constraints.
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Adding container view as subview
    [self.view addSubview:_containerView];
    
    //Adding horizontal contraints for container view
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|"
                                             options:0 metrics:nil
                                               views:@{@"containerView":_containerView}]
     ];
    //Adding vertical constraits for container view
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-108-[containerView]|"
                                             options:0 metrics:nil
                                               views:@{@"containerView":_containerView}]];
    //Updating constraits
    [self.view layoutIfNeeded];
    
    //Performing Event Data request.
    [self performEventRequest];
    //Performing Weather Data request.
    [self performWeatherRequest];
    
}

/**
 Displaying alert to user with title and description

 @param title alert title as string
 @param description alert description as string
 */
-(void)displayAlertWithTitle:(NSString *)title andDescription:(NSString *)description{

    //Displaying alert to user with title and description
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:title
                                                                  message:description
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okayButton = [UIAlertAction actionWithTitle:@"Okay"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil];

    [alert addAction:okayButton];
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 This method is used to retrieve device location and perform weather data request.
 */
-(void)performWeatherRequest{

    //Get user current location from device
    [[MCLocationManager sharedInstance] startUpdatingLocationWithCompletionBlock:^(CLLocation *location) {
        //Performing event request once user gets current device location
        [self performWeatherDataRequestWithLocation:location];

    } withErrorBlock:^(NSError *error) {
        //Displaying alert to user if application is denied location permission.
        [self displayAlertWithTitle:error.localizedFailureReason andDescription:error.localizedDescription];
        
    }];



}

/**
 Method is used to perform weather data request.

 @param location current location of device.
 */
-(void)performWeatherDataRequestWithLocation:(CLLocation *)location{
    
    
    [MCDataControllerManager initializeWeatherDataWithRequest:({
        //Creating request object.
        MCWeatherDataRequest *request = [[MCWeatherDataRequest alloc] init];
        request.location = location;
        (id)request;
        
    }) withCompletionBlock:^(id result) {
        //Moving UI updates to main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.agendaViewController setWeatherDictionary:result];
            [self.agendaViewController reloadData];
        });
        
    } withErrorBlock:^(NSError *error) {
        //Displaying alert if connection fails.
        [self displayAlertWithTitle:@"Network Error" andDescription:@"Unable to retrieve weather data."];
    }];
}

/**
 Method is used to perform event data request
 */
-(void)performEventRequest{

    [MCDataControllerManager initializeEventDataWithCompletionBlock:^(id result) {
        //Moving UI updates to main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.calendarViewController setEventDictionary:result];
            [self.agendaViewController setEventDictionary:result];
            [self.agendaViewController reloadData];
            [self.calendarViewController reloadData];
            [_calendarViewController scrollToCurrentDate];
            [self.view layoutIfNeeded];

        });
    } withErrorBlock:^(NSError *error) {
        //Displaying alert if connection fails.
        [self displayAlertWithTitle:@"Network Error" andDescription:@"Unable to retrieve outlook events data."];
        
    }];

}

#pragma mark - Class Methods

/**
 Returns storyboard ID of current view controller.

 @return current view controller storyboardID
 */
- (NSString *)getStoryBoardID {

  return @"kMCCalendarAgendaViewControllerKey";
}

#pragma mark - IBActions
/**
 Method is triggered when user taps on today bar button.
 */
- (IBAction)didSelectScrollToToday:(UIBarButtonItem *)sender {
    
        [self.calendarViewController scrollToCurrentDate];
}

#pragma mark - Accessor Methods
#pragma mark - MCAgendaViewControllerDelegate


/**
 MCAgendaViewControllerDelegate repective delegate method is called when user scrolls to an indexPath.
 Once this event is called, its forwarded to MCCalendarViewController to select the respective
 date in calendar control.

 @param indexPath - MCCalendarViewControllerDelgate tableview indexPath to which user scrolled.
 */
- (void)didScrollToTableIndex:(NSIndexPath *)indexPath{

    //Since Date is populated section wise in table and row wise in calendar, we swap the values.
    [_calendarViewController scrollToIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0]];
    
    //Update month title when table is scrolled
    NSArray *dateRange = [MCDateRangeManager getDateRangeArray];
    NSDate *date = dateRange[indexPath.section];
    self.monthBarButtonItem.title = [MCDateRangeManager calculateStringFromDate:date withFormat:@"MMMM yyyy"];
   
}
#pragma mark - MCCalendarViewControllerDelegate

/**
 MCCalendarViewControllerDelgate respective delegate method id called when user taps on a particular
 date in calendar. Once the event is called, its forwarded to MCAgendaTableViewController to scroll to the
 respective indexPath in Agenda control.

 @param indexPath MCCalendarViewController collection view indexPath on which user tapped.
 */
- (void)didSelectCellAtIndexPath:(NSIndexPath *)indexPath{

    //Since Date is populated section wise in table and row wise in calendar, we swap the values.
    [_agendaViewController scrollToIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]];
    
    //Update month title when tapped on collection view
    NSArray *dateRange = [MCDateRangeManager getDateRangeArray];
    NSDate *date = dateRange[indexPath.row];
    self.monthBarButtonItem.title = [MCDateRangeManager calculateStringFromDate:date withFormat:@"MMMM yyyy"];
}


/**
 MCCalendarViewControllerDelegate method is called when calender is about to scroll to today's date.
 */
- (void)willScrollToTodayDate{

    [self.agendaViewController stopScrollDeceleration];

}

/**
 MCCalendarAgendaContainerViewDelegate is called when user starts pan gesture on container view.
 */
-(void)didStartPanningCalendarAgendaContainerView{

    [self.agendaViewController stopScrollDeceleration];

}

@end
