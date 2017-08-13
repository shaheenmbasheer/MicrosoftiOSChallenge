//
//  MCCalendarCollectionViewController.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCCalendarViewController.h"
#import "MCCalendarDayCollectionViewCell.h"
#import "MCDateRangeManager.h"

@interface MCCalendarViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
/**
 Collectionview object to represent calendar.
 */
@property(nonatomic, strong) UICollectionView *calendarView;

/**
 Calendar dates array which is used to render calendar.
 */
@property(nonatomic, strong) NSMutableArray *calendarDateArray;

/**
 Old selected indexPath in calendar.
 */
@property(nonatomic, strong) NSIndexPath *oldSelectedIndexPath;

/**
 Used to indicate if scrollaction is performed via user action in agenda view.
 */
@property(nonatomic, assign) BOOL didInvokeScrollToIndexPath;

/**
Collection view overlay View
 */
@property(nonatomic, strong) UIView *calendarOverlayView;

@property(nonatomic, strong) NSIndexPath *todayDateIndexPath;
@end

@implementation MCCalendarViewController

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.calendarView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:({
            
            //Returns layout object for collection view.
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            //Width is calculated according to parent view since we always need 7 columns of the collection view.
            CGFloat width = self.view.bounds.size.width/7;
            layout.itemSize = CGSizeMake(width, width);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.minimumInteritemSpacing = 0;
            layout.minimumLineSpacing = 0;
            layout;
        })];
        [self.calendarView setDelegate:self];
        [self.calendarView setDataSource:self];
        self.calendarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"calender_background"]];
        [self.view addSubview:_calendarView];
        //Setting up contraints for collection view
        [self setUpConstraints];
        //Setting up defaults values for the controller
        [self registerDefaults];
        self.view.backgroundColor = [UIColor redColor];
        //Preparing data that is to be loaded to calendar.
        [self prepareData];
        
    }
    return self;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    [self.calendarView reloadData];

}
-(void)reloadData{


    [self.calendarView.collectionViewLayout invalidateLayout];

    // Giving a small delay before reloading the collection view.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.calendarView reloadData];
//    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    //Scrolling to today's date when calendarView loads.
    [self setUpOverlayView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UserDefined Methods

-(void)setUpOverlayView{

    if (!_calendarOverlayView) {
        self.calendarOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.calendarView.contentSize.width, self.calendarView.contentSize.height)];
        [self.calendarView addSubview:_calendarOverlayView];
        _calendarOverlayView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.8];
        _calendarOverlayView.hidden = YES;
        
    }

}

/**
 Prepares date data from MCDateRangeManager for calendar control. If data is already processed, its only 
 copied the second time.
 */
-(void)prepareData{

    self.calendarDateArray = [[MCDateRangeManager getDateRangeArray] mutableCopy];
}


/**
 Setting up contraints for calendar collection view.
 */
-(void)setUpConstraints{
    
    self.calendarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_calendarView]|"
                                             options:0 metrics:nil
                                               views:@{@"_calendarView":_calendarView}]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_calendarView]|"
                                             options:0 metrics:nil
                                               views:@{@"_calendarView":_calendarView}]];
}


/**
 Setting up defailt values for the controller.
 */
-(void)registerDefaults{
    
    self.view.userInteractionEnabled = YES;
    //Registering MCCalendarDayCollectionViewCell cell to calendar collection view.
    [self.calendarView registerClass:[MCCalendarDayCollectionViewCell class] forCellWithReuseIdentifier:[MCCalendarDayCollectionViewCell cellReuseIdentifier]];
    self.didInvokeScrollToIndexPath = NO;
    

//    self.calendarOverlayView.hidden = YES;

}


/**
 Scroll to today's date when calendar view loads.
 */
-(void)scrollToCurrentDate{

    NSIndexPath *currentDateIndexPath = [NSIndexPath indexPathForRow:[MCDateRangeManager todayDateIndex] inSection:0];

//    [self.delegate willScrollToTodayDate];
    [self.delegate didSelectCellAtIndexPath:currentDateIndexPath];
    if (self.oldSelectedIndexPath) {
        //Deselect the previously selected cell, if oldSelectedIndexPath object is not nil.
        [_calendarView deselectItemAtIndexPath:self.oldSelectedIndexPath animated:NO];
        
    }
    self.oldSelectedIndexPath = currentDateIndexPath;
    // Giving .1 delay for table to reset its position before selecting cell.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_calendarView selectItemAtIndexPath:currentDateIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];

    });


}


/**
 Scroll to provided indexPath in collection view.

 @param indexPath of calendar collection view.
 */
- (void)scrollToIndexPath:(NSIndexPath *)indexPath{

    //Since this method is used invoked, we set _didInvokeScrollToIndexPath flag to YES.
    self.didInvokeScrollToIndexPath = YES;
    if (self.oldSelectedIndexPath) {
        //Deselect the previously selected cell, if oldSelectedIndexPath object is not nil.
        [_calendarView deselectItemAtIndexPath:self.oldSelectedIndexPath animated:NO];

    }
    [_calendarView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionTop];
    //Scroll to provided indexPath in calendar collection view.
    //Select cell in provided index path in calendar collection view.
    self.didInvokeScrollToIndexPath = NO;
    //Set oldSelectedIndexPath as current selectedIndexPath, so the same can be cleared the next time this method is called.
    self.oldSelectedIndexPath = indexPath;
    

}




#pragma mark - Class Methods

/**
 Returns current View Controller storyboardID.
 @return storyBoardID as string.
 */
- (NSString *)getStoryBoardID {
    
    return @"kMCCalendarCollectionViewControllerKey";
}

#pragma mark - IBActions
#pragma mark - Accessor Methods
#pragma mark - UICollectionViewDataSource

/**
Number of sections in calendar collection view corresponds to number of dates in _calendarDateArray.
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_calendarDateArray count];
}


/**
 Returns each day cell in calendar collection view which is of type MCCalendarDayCollectionViewCell.
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MCCalendarDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MCCalendarDayCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.displayDate = _calendarDateArray[indexPath.row];
    cell.eventDictionary = self.eventDictionary;
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
 
    if (cell.isCenterDate) {
        
        if (![self.calendarOverlayView viewWithTag:indexPath.row]) {
            [self.calendarOverlayView addSubview:({
                UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(attributes.frame.origin.x - 50, attributes.frame.origin.y, 150, 50)];
                displayLabel.text = [MCDateRangeManager calculateStringFromDate:_calendarDateArray[indexPath.row] withFormat:@"MMMM yyyy"];
                displayLabel.textAlignment = NSTextAlignmentCenter;
                displayLabel.tag = indexPath.row;
                displayLabel;
            })];
        }
   
    }
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout


/**
 This method is used to return calculated cell size when layout is invalid.
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //Calculating width so there will always be 7 columns in calendar collection view.
    CGFloat width = self.view.bounds.size.width/7;
    CGSize size = CGSizeMake(width, width);
    return size;
}


/**
 Invalidating layout if orientation is changed. This is required as we need to recalculate width of each cell.
 */
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration{
    
    [self.calendarView.collectionViewLayout invalidateLayout];
}
/**
 Invalidating layout if orientation is changed. This is required as we need to recalculate width of each cell.
 */
-(void)invalidateCalendarLayout{
    
    [self.calendarView.collectionViewLayout invalidateLayout];
}

#pragma mark <UICollectionViewDelegate>
/**
 This method is called before the user is about to select a cell.
 */
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //Deselect all index path before selecting item in cell
    for (NSIndexPath *indexPath in collectionView.indexPathsForSelectedItems) {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
    return collectionView.indexPathsForSelectedItems.count == 0;
}

/**
 This method is called when a particular indexPath cell is selected in the collection view. Here, if there is 
 a previously selected cell in oldSelectedIndexPath, it is deselected before continuing.
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

    if (self.oldSelectedIndexPath) {
        //Deselecting previously selected cell.
        [collectionView deselectItemAtIndexPath:self.oldSelectedIndexPath animated:NO];

    }
    [cell setSelected:YES];
    self.oldSelectedIndexPath = indexPath;
    if (!self.didInvokeScrollToIndexPath) {
        //If user selectes the cell, then only delegate method is called.
        [self.delegate didSelectCellAtIndexPath:indexPath];
    }
}


/**
 Deselect calendar cell at given indexPath.
 */
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:NO];
}

#pragma mark - UIScrollViewDelegate


/**
 Method is called when user begins dragging calenderView.
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //Displaying overlay view
    _calendarOverlayView.hidden = NO;
}
/**
 Method is called when calenderView begins decelerating.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (!decelerate) {
        //Hiding overlay view once scroll has ended.
        self.calendarOverlayView.hidden = YES;
    }
}
/**
 Method is called when calenderView has decelerated.
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //Hiding overlay view once scroll has ended.
    self.calendarOverlayView.hidden = YES;
}


@end
