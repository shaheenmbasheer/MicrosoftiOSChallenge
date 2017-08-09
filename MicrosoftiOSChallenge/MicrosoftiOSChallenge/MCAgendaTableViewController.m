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

@interface MCAgendaTableViewController ()<UIScrollViewDelegate>
/**
 Calender dates array which is used to render calender.
 */
@property(nonatomic, strong) NSMutableArray *calenderDateArray;
@property(nonatomic, assign) BOOL isUserInvokedScroll;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation MCAgendaTableViewController


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

    self.isUserInvokedScroll = YES;
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];

}
#pragma mark - Class Methods
- (NSString *)getStoryBoardID {
    
    return @"kMCAgendaTableViewControllerKey";
}

#pragma mark - IBActions
#pragma mark - Accessor Methods

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_calenderDateArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
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
    
    MCAgendaEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MCAgendaEventTableViewCell
                                                                                     cellReuseIdentifier]];
    

    return cell;
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

    if (!_isUserInvokedScroll) {
        NSIndexPath *path = [[self.tableView indexPathsForVisibleRows] firstObject];
        [self.delegate didScrollToTableIndex:path];
    }
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
