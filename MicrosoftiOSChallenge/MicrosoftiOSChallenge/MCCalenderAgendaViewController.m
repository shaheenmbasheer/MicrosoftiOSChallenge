//
//  MCCalenderAgendaViewController.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCCalenderAgendaViewController.h"
#import "MCCalenderAgendaContainerView.h"
#import "MCCalenderViewController.h"
#import "MCAgendaTableViewController.h"
#import "MCDateRangeManager.h"
#import "MCDataControllerManager.h"
#import "MCEventManager.h"
@interface MCCalenderAgendaViewController ()<MCAgendaTableViewControllerDelegate, MCCalenderViewControllerDelegate>


/**
  MCCalenderAgendaContainerView is used to position calender view and agenda view.
 */
@property(nonatomic, strong) MCCalenderAgendaContainerView *containerView;
/**
  MCCalenderViewController is used to handle calender delegates and forward
  user events to calenderAgendaViewController.
 */
@property(nonatomic, strong) MCCalenderViewController *calenderViewController;
/**
 MCAgendaTableViewController is used to handle agenda delegates and forward
 user events to calenderAgendaViewController.
*/

@property (weak, nonatomic) IBOutlet UIBarButtonItem *monthBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *weatherIconBarButtonItem;

@property(nonatomic, strong) MCAgendaTableViewController *agendaViewController;
@end

@implementation MCCalenderAgendaViewController


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
    
    //Intializing container view with calender and agenda views
    self.containerView = [[MCCalenderAgendaContainerView alloc] initWithTopView:({
        
        //Returns MCCalenderAgendaContainerView as topView
        self.calenderViewController = [[MCCalenderViewController alloc] init];
        _calenderViewController.view.backgroundColor = [UIColor grayColor];
        _calenderViewController.delegate = self;

        [self addChildViewController:_calenderViewController];
        _calenderViewController.view;

//        UIView *topView = [[UIView alloc] init];
//        topView.backgroundColor = [UIColor blueColor];
//        topView;
    }) andBottomView:({
        
        //Returns MCAgendaTableViewController as bottomView
        self.agendaViewController  = [[MCAgendaTableViewController alloc] init];
        _agendaViewController.view.backgroundColor = [UIColor whiteColor];
        _agendaViewController.delegate = self;
        [self addChildViewController:_agendaViewController];
        _agendaViewController.view;
        
//        UIView *bottomView = [[UIView alloc] init];
//        bottomView.backgroundColor = [UIColor greenColor];
//        bottomView;
    })];
    
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
    
    [self performEventRequest];

    
}

-(void)performEventRequest{

    [MCDataControllerManager initializeEventDataWithCompletionBlock:^(id result) {
        
        NSDictionary *eventDictionary = [MCEventManager getEventDictionary];

        
        [self.calenderViewController setEventDictionary:eventDictionary];
        [self.agendaViewController setEventDictionary:eventDictionary];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            [self.agendaViewController reloadData];
            [self.calenderViewController reloadData];
            [_calenderViewController scrollToCurrentDate];
        });
        
  

    } WithErrorBlock:nil enableForceLoad:YES];

}

#pragma mark - Class Methods

/**
 Returns storyboard ID of current view controller.

 @return current view controller storyboardID
 */
- (NSString *)getStoryBoardID {

  return @"kMCCalenderAgendaViewControllerKey";
}

#pragma mark - IBActions
- (IBAction)didSelectScrollToToday:(UIBarButtonItem *)sender {
    
    [self.calenderViewController scrollToCurrentDate];
}

#pragma mark - Accessor Methods
#pragma mark - MCAgendaViewControllerDelegate


/**
 MCAgendaViewControllerDelegate repective delegate method is called when user scrolls to an indexPath.
 Once this event is called, its forwarded to MCCalenderViewController to select the respective
 date in calender control.

 @param indexPath - MCCalenderViewControllerDelgate tableview indexPath to which user scrolled.
 */
- (void)didScrollToTableIndex:(NSIndexPath *)indexPath{

    //Since Date is populated section wise in table and row wise in calender, we swap the values.
    [_calenderViewController scrollToIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0]];
    
    //Update month title when table is scrolled
    NSArray *dateRange = [MCDateRangeManager getDateRangeArray];
    NSDate *date = dateRange[indexPath.section];
    self.monthBarButtonItem.title = [MCDateRangeManager calculateStringFromDate:date withFormat:@"MMMM yyyy"];
   
}
#pragma mark - MCCalenderViewControllerDelegate

/**
 MCCalenderViewControllerDelgate respective delegate method id called when user taps on a particular
 date in calender. Once the event is called, its forwarded to MCAgendaTableViewController to scroll to the
 respective indexPath in Agenda control.

 @param indexPath MCCalenderViewController collection view indexPath on which user tapped.
 */
- (void)didSelectCellAtIndexPath:(NSIndexPath *)indexPath{

    //Since Date is populated section wise in table and row wise in calender, we swap the values.
    [_agendaViewController scrollToIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]];
    
    //Update month title when tapped on collection view
    NSArray *dateRange = [MCDateRangeManager getDateRangeArray];
    NSDate *date = dateRange[indexPath.row];
    self.monthBarButtonItem.title = [MCDateRangeManager calculateStringFromDate:date withFormat:@"MMMM yyyy"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
