//
//  MCAgendaTableViewController.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCAgendaTableViewController.h"
#import "MCAgendaEmptyTableViewCell.h"
#import "MCDateRangeManager.h"
#import "MCAgendaEventTableViewCell.h"
#import "MCBaseTableViewCellProtocol.h"
#import "MCWeatherTableHeaderView.h"
#import "MCWeatherData.h"

@interface MCAgendaTableViewController ()<UIScrollViewDelegate>
/**
 Calendar dates array which is used to render calendar.
 */
@property(nonatomic, strong) NSMutableArray *calendarDateArray;

/**
 Flag indicates scroll is user invoked or not
 */
@property(nonatomic, assign) BOOL isUserInvokedScroll;
@end

@implementation MCAgendaTableViewController

/**
 Controller initialization method

 @return initialized self.
 */
-(instancetype)init{

    self = [super init];
    if (self) {
    }
    return self;
}


/**
 Method is called when controller is loaded.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Registering default values for controller
    [self registerDefaults];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UserDefined Methods
- (void)registerDefaults {
    
    //Adding tableview default settings.
    self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 30;
    self.tableView.estimatedRowHeight = 100;

    //Initialzing calender data array.
    self.calendarDateArray = [[MCDateRangeManager getDateRangeArray] mutableCopy];
    //Initializing isUserInvokedScroll
    self.isUserInvokedScroll = NO;

    //Registering cell with tableview
    [self.tableView registerClass:[MCAgendaEmptyTableViewCell class] forCellReuseIdentifier:[MCAgendaEmptyTableViewCell cellReuseIdentifier]];
    [self.tableView registerClass:[MCAgendaEventTableViewCell class] forCellReuseIdentifier:[MCAgendaEventTableViewCell cellReuseIdentifier]];

}

/**
 Method scrolls to given indexPath in table and selects the particular cell
 @param indexPath indexPath to which table should scroll.
 */
-(void)scrollToIndexPath:(NSIndexPath *)indexPath{

    self.tableView.contentOffset = self.tableView.contentOffset;
    self.isUserInvokedScroll = YES;
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];

}
/**
 Method is used to stop tableview scroll deceleration
 */
-(void)stopScrollDeceleration{

    //Changed the content offset stops the table from scrolling
    CGPoint offset = self.tableView.contentOffset;
    [self.tableView setContentOffset:offset animated:NO];

}

/**
 Method is used to get display date for table header view

 @param date section date for table view header
 @return formatted display date as NSString
 */
-(NSString *)getDisplayStringForDate:(NSDate *)date{
    
    NSString *displayText;
    //Generating date key from date
    NSString *dateKeyForSection = [MCDateRangeManager getDateKeyForDate:date];
    if ([dateKeyForSection isEqualToString:[MCDateRangeManager getDateKeyForDate:[NSDate date]]]) {
        //If date is today's date then append string Today to start of date.
        displayText = [NSString stringWithFormat:@"Today - %@",[MCDateRangeManager calculateStringFromDate:date withFormat:@"dd MMMM yyyy"]];
    }else{
        //Display date as usual if its not today's date
        displayText = [MCDateRangeManager calculateStringFromDate:date withFormat:@"dd MMMM yyyy"];
    }
    return displayText;
}


/**
 Get cell reuseIdentifier based on events

 @param events event data for date
 @return cell reuse identifier as string.
 */
-(NSString *)getCellReuseIdentifierForEvents:(NSArray *)events{

    if ([events count]) {
        //Return event cell if there are events
        return [MCAgendaEventTableViewCell
                cellReuseIdentifier];
  
    }else{
        //Return empty cell if there are no events.
        return [MCAgendaEmptyTableViewCell
                cellReuseIdentifier];
      
    }

}
#pragma mark - Class Methods

/**
 Get current storyBoardID

 @return current storyBoardID as NSString.
 */
- (NSString *)getStoryBoardID {
    
    return @"kMCAgendaTableViewControllerKey";
}


/**
 Chain of operation to reload data for controller.
 */
-(void)reloadData{
    //Reload tableview
    [self.tableView reloadData];
}

#pragma mark - IBActions
#pragma mark - Accessor Methods

#pragma mark - Table view data source

/**
 Method returns the total number of sections in table
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_calendarDateArray count];
}
/**
 Method returns the number of rows per section in table
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!self.eventDictionary) {
        //If event array is nil, show one empty cell.
        return 1;
    }
    NSDate *date = _calendarDateArray[section];
    NSArray *events = _eventDictionary[[MCDateRangeManager getDateKeyForDate:date]];
    if ([events count]) {
        //Number of events denote number of cells in section.
        return [events count];
    }else{
        //Display one empty cell.
        return 1;
    }
}

/**
 Method returns view for header in section for tableview.
 */
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    //Gets date for section from calendarDateArray
    NSDate *dateForSection = _calendarDateArray[section];
    //Get formatted display date from section date value.
    NSString *displayText = [self getDisplayStringForDate:dateForSection];
 
    //Get weather stackview which adds weather information if available.
    MCWeatherTableHeaderView *weatherStackView = ({
    
        //WeatherData for the particular date(dateForSection).
        MCWeatherData *weatherDataForDate = self.weatherDictionary[[MCDateRangeManager getDateKeyForDate:dateForSection]];
        //Initialized weather stack view.
        MCWeatherTableHeaderView *weatherStackView = [[MCWeatherTableHeaderView alloc] initWithTodayDateString:displayText withWeatherData:weatherDataForDate];
        weatherStackView.translatesAutoresizingMaskIntoConstraints = NO;
        weatherStackView;
    });
    
    //Container view for weatherstackview. Container view is required to given background color to weatherstackview
    // as drawRect method is not called for stackview.
    UIView *headerView = ({
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor darkGrayColor];
        headerView;
    });
    [headerView addSubview:weatherStackView];
    
    //Adding vertical constraints for header view
    [headerView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(15)-[weatherStackView]|"
                                             options:0 metrics:nil
                                               views:@{@"weatherStackView":weatherStackView}]];
    //Adding horizontal constraints for header view.
    [headerView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[weatherStackView]|"
                                             options:0 metrics:nil
                                               views:@{@"weatherStackView":weatherStackView}]];
    [headerView setNeedsLayout];
    
    return headerView;
}

/**
 Method returns cell for each indexPath.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Get date for indexPath from calendarDateArray.
    NSDate *date = _calendarDateArray[indexPath.section];
    //Get events for section date.
    NSArray *events = _eventDictionary[[MCDateRangeManager getDateKeyForDate:date]];
    //Cell can be either EmptyCell or EventCell depending on events.
    id<MCBaseTableViewCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:[self getCellReuseIdentifierForEvents:events]];
    //Cell cell input data.
    [cell inputData:events[indexPath.row]];
    return (UITableViewCell *)cell;
}

#pragma mark - UIScrollViewDelegate


/**
 This method is called when user begins dragging scrollview.

 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //Flag is used to identify if its user initiated scroll.
    _isUserInvokedScroll = NO;
}

/**
 This method is called when user is scrolling.

 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (!_isUserInvokedScroll) {
        //If its not user invoked scroll then apply similar changes to agenda tableview.
        NSIndexPath *path = [[self.tableView indexPathsForVisibleRows] firstObject];
        [self.delegate didScrollToTableIndex:path];
    }

}

/**
 This method is called when user scroll has ended.
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (!_isUserInvokedScroll) {
            
        NSIndexPath *path = [[self.tableView indexPathsForVisibleRows] firstObject];
        [self.delegate didScrollToTableIndex:path];
    }
    _isUserInvokedScroll = NO;
}

@end
