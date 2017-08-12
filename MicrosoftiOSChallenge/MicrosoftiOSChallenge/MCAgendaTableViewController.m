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
 Calender dates array which is used to render calender.
 */
@property(nonatomic, strong) NSMutableArray *calenderDateArray;
@property(nonatomic, assign) BOOL isUserInvokedScroll;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation MCAgendaTableViewController

-(instancetype)init{

    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self registerDefaults];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UserDefined Methods
- (void)registerDefaults {
    
    self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 30;

    self.tableView.estimatedRowHeight = 100;

    self.calenderDateArray = [[MCDateRangeManager getDateRangeArray] mutableCopy];
    [self.tableView registerClass:[MCAgendaEmptyTableViewCell class] forCellReuseIdentifier:[MCAgendaEmptyTableViewCell cellReuseIdentifier]];
    [self.tableView registerClass:[MCAgendaEventTableViewCell class] forCellReuseIdentifier:[MCAgendaEventTableViewCell cellReuseIdentifier]];

    self.isUserInvokedScroll = NO;

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

#pragma mark - Class Methods
- (NSString *)getStoryBoardID {
    
    return @"kMCAgendaTableViewControllerKey";
}
-(void)reloadData{

    [self.tableView reloadData];
}

#pragma mark - IBActions
#pragma mark - Accessor Methods

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_calenderDateArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!self.eventDictionary) {
        return 1;
    }
    NSDate *date = _calenderDateArray[section];
    NSArray *events = _eventDictionary[[MCDateRangeManager calculateStringFromDate:date withFormat:@"ddMMyyyy"]];
    if ([events count]) {
        return [events count];
    }else{
        return 1;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
    NSDate *dateForSection = _calenderDateArray[section];
    NSString *displayText;
    
    
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor darkGrayColor];
    
    NSString *dateKeyForSection = [MCDateRangeManager calculateStringFromDate:dateForSection withFormat:@"ddMMyyyy"];
    if ([dateKeyForSection isEqualToString:[MCDateRangeManager calculateStringFromDate:[NSDate date] withFormat:@"ddMMyyyy"]]) {
        
        displayText = [NSString stringWithFormat:@"Today - %@",[MCDateRangeManager calculateStringFromDate:dateForSection withFormat:@"dd MMMM yyyy"]];
    }else{
        
        displayText = [MCDateRangeManager calculateStringFromDate:dateForSection withFormat:@"dd MMMM yyyy"];
        
    }
    
    MCWeatherData *weatherDataForDate = self.weatherDictionary[dateKeyForSection];

    MCWeatherTableHeaderView *stackView = [[MCWeatherTableHeaderView alloc] initWithTodayDateString:displayText withWeatherData:weatherDataForDate];
    [headerView addSubview:stackView];
    
    
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(15)-[_calenderView]|"
                                             options:0 metrics:nil
                                               views:@{@"_calenderView":stackView}]];
    [headerView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_calenderView]|"
                                             options:0 metrics:nil
                                               views:@{@"_calenderView":stackView}]];
    [headerView setNeedsLayout];
    
    return headerView;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSDate *dateForSection = _calenderDateArray[section];
    NSString *displayText;
    
    if ([[MCDateRangeManager calculateStringFromDate:dateForSection withFormat:@"ddMMyyyy"] isEqualToString:[MCDateRangeManager calculateStringFromDate:[NSDate date] withFormat:@"ddMMyyyy"]]) {
        
        displayText = [NSString stringWithFormat:@"Today - %@",[MCDateRangeManager calculateStringFromDate:dateForSection withFormat:@"dd MMMM yyyy"]];
    }else{
        
        displayText = [MCDateRangeManager calculateStringFromDate:dateForSection withFormat:@"dd MMMM yyyy"];
    }

    return displayText;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *date = _calenderDateArray[indexPath.section];
    NSArray *events = _eventDictionary[[MCDateRangeManager calculateStringFromDate:date withFormat:@"ddMMyyyy"]];
    
    id<MCBaseTableViewCellProtocol> cell;
    if ([events count] == 0) {
        cell = (MCAgendaEmptyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[MCAgendaEmptyTableViewCell
                                                                                           cellReuseIdentifier]];
    }else{
    
        cell = (MCAgendaEventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[MCAgendaEventTableViewCell
                                                             cellReuseIdentifier]];
        [cell inputData:events[indexPath.row]];
    }
    

    return (UITableViewCell *)cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    _isUserInvokedScroll = NO;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (!_isUserInvokedScroll) {
        NSIndexPath *path = [[self.tableView indexPathsForVisibleRows] firstObject];
        [self.delegate didScrollToTableIndex:path];
    }

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    
//    if (!_isUserInvokedScroll) {
//        NSIndexPath *path = [[self.tableView indexPathsForVisibleRows] firstObject];
//        [self.delegate didScrollToTableIndex:path];
//    }
    _isUserInvokedScroll = NO;
 


}

/*
 
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
