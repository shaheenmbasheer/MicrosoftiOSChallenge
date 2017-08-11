//
//  MCCalenderCollectionViewController.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 07/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCCalenderViewController.h"
#import "MCCalenderDayCollectionViewCell.h"
#import "MCDateRangeManager.h"

@interface MCCalenderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
/**
 Collectionview object to represent calender.
 */
@property(nonatomic, strong) UICollectionView *calenderView;

/**
 Calender dates array which is used to render calender.
 */
@property(nonatomic, strong) NSMutableArray *calenderDateArray;

/**
 Old selected indexPath in calender.
 */
@property(nonatomic, strong) NSIndexPath *oldSelectedIndexPath;

/**
 Used to indicate if scrollaction is performed via user action in agenda view.
 */
@property(nonatomic, assign) BOOL didInvokeScrollToIndexPath;

/**
Collection view overlay View
 */
@property(nonatomic, strong) UIView *calenderOverlayView;

@property(nonatomic, strong) NSIndexPath *todayDateIndexPath;
@end

@implementation MCCalenderViewController

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.calenderView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:({
            
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
        [self.calenderView setDelegate:self];
        [self.calenderView setDataSource:self];
        self.calenderView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"calender_background"]];
        [self.view addSubview:_calenderView];
        //Setting up contraints for collection view
        [self setUpConstraints];
        //Setting up defaults values for the controller
        [self registerDefaults];
        self.view.backgroundColor = [UIColor redColor];
        //Preparing data that is to be loaded to calender.
        [self prepareData];
        
    }
    return self;
}
-(void)reloadData{

    [self.calenderView.collectionViewLayout invalidateLayout];

    [self.calenderView reloadData];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    //Scrolling to today's date when calenderView loads.
    [self scrollToCurrentDate];
    [self setUpOverlayView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UserDefined Methods

-(void)setUpOverlayView{

    if (!_calenderOverlayView) {
        self.calenderOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.calenderView.contentSize.width, self.calenderView.contentSize.height)];
        [self.calenderView addSubview:_calenderOverlayView];
        _calenderOverlayView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.8];
        _calenderOverlayView.hidden = YES;
        
    }

}

/**
 Prepares date data from MCDateRangeManager for calender control. If data is already processed, its only 
 copied the second time.
 */
-(void)prepareData{

    self.calenderDateArray = [[MCDateRangeManager getDateRangeArray] mutableCopy];
}


/**
 Setting up contraints for Calender collection view.
 */
-(void)setUpConstraints{
    
    self.calenderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_calenderView]|"
                                             options:0 metrics:nil
                                               views:@{@"_calenderView":_calenderView}]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_calenderView]|"
                                             options:0 metrics:nil
                                               views:@{@"_calenderView":_calenderView}]];
}


/**
 Setting up defailt values for the controller.
 */
-(void)registerDefaults{
    
    self.view.userInteractionEnabled = YES;
    //Registering MCCalenderDayCollectionViewCell cell to calender collection view.
    [self.calenderView registerClass:[MCCalenderDayCollectionViewCell class] forCellWithReuseIdentifier:[MCCalenderDayCollectionViewCell cellReuseIdentifier]];
    self.didInvokeScrollToIndexPath = NO;
    

//    self.calenderOverlayView.hidden = YES;

}


/**
 Scroll to today's date when calender view loads.
 */
-(void)scrollToCurrentDate{
//    [self killScroll];
    NSIndexPath *currentDateIndexPath = [NSIndexPath indexPathForRow:[MCDateRangeManager todayDateIndex] inSection:0];
    [_calenderView selectItemAtIndexPath:currentDateIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionTop];

    [self.delegate didSelectCellAtIndexPath:currentDateIndexPath];
    self.oldSelectedIndexPath = currentDateIndexPath;

}


/**
 Scroll to provided indexPath in collection view.

 @param indexPath of calender collection view.
 */
- (void)scrollToIndexPath:(NSIndexPath *)indexPath{

//    if(self.oldSelectedIndexPath == indexPath)
//        return;
    //Since this method is used invoked, we set _didInvokeScrollToIndexPath flag to YES.
    self.didInvokeScrollToIndexPath = YES;
    if (self.oldSelectedIndexPath) {
        //Deselect the previously selected cell, if oldSelectedIndexPath object is not nil.
        [_calenderView deselectItemAtIndexPath:indexPath animated:NO];

    }
    [_calenderView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionTop];
    //Scroll to provided indexPath in calender collection view.
    //Select cell in provided index path in calender collection view.
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
    
    return @"kMCCalenderCollectionViewControllerKey";
}

#pragma mark - IBActions
#pragma mark - Accessor Methods
#pragma mark - UICollectionViewDataSource

/**
Number of sections in calender collection view corresponds to number of dates in _calenderDateArray.
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_calenderDateArray count];
}


/**
 Returns each day cell in calender collection view which is of type MCCalenderDayCollectionViewCell.
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MCCalenderDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MCCalenderDayCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.displayDate = _calenderDateArray[indexPath.row];
    cell.eventDictionary = self.eventDictionary;
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
 
    if (cell.isCenterDate) {
        
        if (![self.calenderOverlayView viewWithTag:indexPath.row]) {
            [self.calenderOverlayView addSubview:({
                UILabel *displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(attributes.frame.origin.x - 50, attributes.frame.origin.y, 150, 50)];
                displayLabel.text = [MCDateRangeManager calculateStringFromDate:_calenderDateArray[indexPath.row] withFormat:@"MMMM yyyy"];
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
    
    //Calculating width so there will always be 7 columns in calender collection view.
    CGFloat width = self.view.bounds.size.width/7;
    CGSize size = CGSizeMake(width, width);
    return size;
}


/**
 Invalidating layout if orientation is changed. This is required as we need to recalculate width of each cell.
 */
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration{
    
    [self.calenderView.collectionViewLayout invalidateLayout];
}
/**
 Invalidating layout if orientation is changed. This is required as we need to recalculate width of each cell.
 */
-(void)invalidateCalenderLayout{
    
    [self.calenderView.collectionViewLayout invalidateLayout];
}

#pragma mark <UICollectionViewDelegate>

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    for (NSIndexPath *indexPath in collectionView.indexPathsForSelectedItems) {
//        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
//    }
//    return collectionView.indexPathsForSelectedItems.count == 0 && indexPath.section == 1;
//}

/**
 This method is called when a particular indexPath cell is selected in the collection view. Here, if there is 
 a previously selected cell in oldSelectedIndexPath, it is deselected before continuing.
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

    if (self.oldSelectedIndexPath) {
        //Deselecting previously selected cell.
//        [self collectionView:_calenderView didDeselectItemAtIndexPath:_oldSelectedIndexPath];
        [collectionView deselectItemAtIndexPath:self.oldSelectedIndexPath animated:NO];

    }
    [cell setSelected:YES];
//    self.oldSelectedIndexPath = indexPath;

    if (!self.didInvokeScrollToIndexPath) {
        //If user selectes the cell, then only delegate method is called.
        [self.delegate didSelectCellAtIndexPath:indexPath];
    }
}


/**
 Deselect calender cell at given indexPath.

 */
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelected:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

  


    _calenderOverlayView.hidden = NO;
    

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (!decelerate) {
        self.calenderOverlayView.hidden = YES;

    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    self.calenderOverlayView.hidden = YES;

}
- (void)killScroll{
    CGPoint offset = _calenderView.contentOffset;
    [_calenderView setContentOffset:offset animated:NO];
}

@end
