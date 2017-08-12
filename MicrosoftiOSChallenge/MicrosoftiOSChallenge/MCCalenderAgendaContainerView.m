//
//  MCCalenderAgendaContainerView.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 04/08/17.
//  Copyright © 2017 Shaheen M. All rights reserved.
//

#import "MCCalenderAgendaContainerView.h"


@interface MCCalenderAgendaContainerView()<UIGestureRecognizerDelegate>

@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) NSLayoutConstraint *topConstraint;
@property(nonatomic, strong) NSLayoutConstraint *updatedTopConstraint;
@property(nonatomic, strong) UIPanGestureRecognizer *topViewPanGesture;
@property(nonatomic, strong) UIPanGestureRecognizer *bottomViewPanGesture;

@end


@implementation MCCalenderAgendaContainerView

#pragma mark - Init

/**
 Init method that returns MCCalenderAgendaContainerView object

 @param topView topView of the container - Calender view
 @param bottomView bottonView of the container - Agenda view
 @return returns initialized object of type MCCalenderAgendaContainerView
 */
-(instancetype)initWithTopView:(UIView *)topView andBottomView:(UIView *)bottomView{

    self = [super init];
    if (self) {
        
        self.topView = topView;
        self.bottomView = bottomView;
//        [self setUpSubViewsWithStackView];
        [self setUpViewContraints];
        [self addPanGestureToSubViews];
        [self addPanGestureForState:YES];
    }
    return self;
}

/**
 Set up constraints for subviews's topView and bottonView
 */
-(void)setUpViewContraints{
    
    // Turning off translatesAutoresizingMaskIntoConstraints to work with constraints.
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_topView];
    [self addSubview:_bottomView];
    //Adding horizontal contraints for topView
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomView]|"
                                             options:0 metrics:nil
                                               views:@{@"_bottomView":_bottomView}]
     ];
    //Adding vertical contraints for topView
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomView]|"
                                             options:0 metrics:nil
                                               views:@{@"_bottomView":_bottomView}]];
    
    
    // Turning off translatesAutoresizingMaskIntoConstraints to work with constraints.
    _topView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Adding horizontal contraints for bottomView
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topView]|"
                                             options:0 metrics:nil
                                               views:@{@"_topView":_topView}]
     ];
    
    //Adding vertical contraints for bottomView
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topView(400)]"
                                             options:0 metrics:nil
                                               views:@{@"_topView":_topView}]];
    
    self.topConstraint = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:300.0f];
    self.topConstraint.priority = 999;
    self.updatedTopConstraint =  [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:120.0f];
    self.updatedTopConstraint.priority = 998;
    [self addConstraint:_topConstraint];
    [self addConstraint:_updatedTopConstraint];
    [self layoutIfNeeded];
}


-(void)addPanGestureToSubViews{

    
    self.userInteractionEnabled = YES;
    /**
     Adding swipe down pan gesture to topView
     */
    self.topViewPanGesture = ({
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewPanGesture:)];
        panGesture.delegate = self;
        panGesture.cancelsTouchesInView = NO;
        panGesture.enabled = YES;
        panGesture;
    });
    
    UIView *topTouchView = [[UIView alloc] initWithFrame:self.topView.bounds];
    topTouchView.backgroundColor = [UIColor brownColor];
    [self.topView addSubview:topTouchView];
    [topTouchView addGestureRecognizer:self.topViewPanGesture];
    
    [_topView addGestureRecognizer:_topViewPanGesture];

    /**
     Adding swipe up pan gesture to bottomView
     */
    self.bottomViewPanGesture = ({
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewPanGesture:)];
        panGesture.delegate = self;
        panGesture.cancelsTouchesInView = NO;
        panGesture.enabled = YES;
        panGesture;
    });
    
    [_bottomView addGestureRecognizer:_bottomViewPanGesture];
}



-(void)addPanGestureForState:(BOOL)isTopViewDominant{
    
    if (isTopViewDominant) {
        
        _bottomViewPanGesture.enabled = YES;
        _topViewPanGesture.enabled = NO;
    }else{
        
        _bottomViewPanGesture.enabled = NO;
        _topViewPanGesture.enabled = YES;
        }

}

-(void)animateViewAnimationDirection:(BOOL)animationDirectioUp{

    if ((self.topConstraint.priority == 999)) {
        
        [UIView animateWithDuration:.3f animations:^{
            
            self.topConstraint.priority = 995;
            [self layoutIfNeeded];
        }];
        
        [self addPanGestureForState:NO];
    }else if((self.topConstraint.priority == 995)){
        
        [UIView animateWithDuration:0.3f animations:^{
            
            self.topConstraint.priority = 999;
            [self layoutIfNeeded];
        }];
        [self addPanGestureForState:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate



-(void)handleViewPanGesture:(UIPanGestureRecognizer *)recognizer{


    if(recognizer.state == UIGestureRecognizerStateBegan){

    }else if((recognizer.state == UIGestureRecognizerStateChanged)){
    
        [self animateViewAnimationDirection:NO];

// Code if pan needs fine tuning according to direction of PAN
//        CGPoint finalPoint = [recognizer translationInView:self];
//        if ((finalPoint.y - initialPoint.y) > 0) {
//            
//            [self animateViewAnimationDirection:NO];
//
//        }else{
//
//            [self animateViewAnimationDirection:YES];
//        }
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
