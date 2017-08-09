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
