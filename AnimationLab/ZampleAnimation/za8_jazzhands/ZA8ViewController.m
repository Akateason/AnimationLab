//
//  ZA8ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/23.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA8ViewController.h"
#import "Masonry.h"
#import "ReactiveObjC.h"
#import <XTlib.h>

@interface ZA8ViewController ()
@property (nonatomic,strong) UIImageView *kobeHead ;
@property (nonatomic,strong) UIImageView *monkey ;
@property (nonatomic,strong) UIImageView *gold ;
@property (nonatomic,strong) UIImageView *coin ;

@property (nonatomic, strong) UIImageView *plane;
@property (nonatomic, strong) CAShapeLayer *planePathLayer;
@property (nonatomic, strong) UIView *planePathView;
@property (nonatomic, strong) IFTTTPathPositionAnimation *airplaneFlyingAnimation;

@property (nonatomic, strong) UIButton *button ;
@property (nonatomic, strong) UIPageControl *pageControl ;

@property (strong,nonatomic) RootCustomView *circle;


@end

@implementation ZA8ViewController

// Tell the scroll view how many pages it should have
- (NSUInteger)numberOfPages
{
    return 4;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    
    [self configureUI] ;
    [self configureAnimations] ;
    
    
    [self animateCurrentFrame] ;            
}

- (void)configureUI
{
    self.circle = [[RootCustomView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width * .8, self.scrollView.frame.size.width * .8)] ;
    [self.contentView addSubview:self.circle] ;
    [self.circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(60);
        make.width.equalTo(self.scrollView).multipliedBy(0.8).priorityHigh();
        make.height.equalTo(self.circle.mas_width);
        make.centerY.equalTo(self.contentView).multipliedBy(0.8);
    }];
    self.circle.xt_completeRound = YES ;
    
    
    self.kobeHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kobe"]] ;
    [self.contentView addSubview:self.kobeHead] ;
    
    self.monkey = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"monkeySpeed"]] ;
    [self.contentView addSubview:self.monkey] ;
    
    self.gold = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goldCoin"]] ;
    [self.contentView addSubview:self.gold] ;
    
    self.coin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"money"]] ;
    [self.contentView addSubview:self.coin] ;
    
    self.planePathView = [UIView new] ;
    [self.contentView addSubview:self.planePathView] ;
    
    self.plane = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plane"]] ;

    self.button = [[UIButton alloc] init] ;
    [self.button setTitle:@"BACK" forState:0] ;
    self.button.backgroundColor = [UIColor greenColor] ;
    [self.button addTarget:self
                    action:@selector(backAction)
          forControlEvents:UIControlEventTouchUpInside] ;
    [self.contentView addSubview:self.button] ;
    
    self.pageControl = [[UIPageControl alloc] init] ;
    self.pageControl.numberOfPages = [self numberOfPages] ;
    CGFloat wid = CGRectGetWidth([UIScreen mainScreen].bounds) ;
    @weakify(self)
    [RACObserve(self.scrollView, contentOffset) subscribeNext:^(NSValue *value) {
        @strongify(self)
        CGFloat x = self.scrollView.contentOffset.x;
        int page = x / wid ;
        NSLog(@"page : %@",@(page)) ;
        self.pageControl.currentPage = page ;
    }] ;
    [self.view addSubview:self.pageControl] ;
    [self.view bringSubviewToFront:self.pageControl] ;
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_bottom).offset(-40) ;
        make.centerX.equalTo(self.view) ;
    }] ;
    
    
    
    IFTTTBackgroundColorAnimation *scrollBG=[IFTTTBackgroundColorAnimation animationWithView:self.scrollView];
    [scrollBG addKeyframeForTime:1 color:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.f]];
    [scrollBG addKeyframeForTime:1.1 color:[UIColor colorWithRed:0.14f green:0.8f blue:1.f alpha:1.f]];
    [self.animator addAnimation:scrollBG];
    
    [self setupCircleAnimation] ;
}

-(void)setupCircleAnimation{
    [self keepView:self.circle onPages:@[@(0),@(1),@(2)]];
    
    //circle 的背景色从灰变蓝
    IFTTTBackgroundColorAnimation *circleColor=[IFTTTBackgroundColorAnimation animationWithView:self.circle];
    [circleColor addKeyframeForTime:0 color:[UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.f]];
    [circleColor addKeyframeForTime:1 color:[UIColor colorWithRed:0.14f green:0.8f blue:1.f alpha:1.f]];
    [self.animator addAnimation:circleColor];
    
    //circle 放大
    IFTTTScaleAnimation *circleScaleAnimation = [IFTTTScaleAnimation animationWithView:self.circle];
    [circleScaleAnimation addKeyframeForTime:0 scale:1 withEasingFunction:IFTTTEasingFunctionEaseInQuad];
    [circleScaleAnimation addKeyframeForTime:1 scale:6];
    [self.animator addAnimation:circleScaleAnimation];
    
    //circle 在第二页过一点点时隐藏
    IFTTTHideAnimation *circleHideAnimation=[IFTTTHideAnimation animationWithView:self.circle hideAt:1.1];
    [self.animator addAnimation:circleHideAnimation];
}


- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    [self.navigationController setNavigationBarHidden:YES
                                             animated:NO] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - iOS8+ Resizing

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self scaleAirplanePathToSize:size];
    } completion:nil];
}

#pragma mark - iOS7 Orientation Change Resizing

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGSize newPageSize;
    
    if ((UIInterfaceOrientationIsLandscape(self.interfaceOrientation)
         && UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
        || (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)
            && UIInterfaceOrientationIsLandscape(toInterfaceOrientation))) {
            
            newPageSize = CGSizeMake(CGRectGetHeight(self.scrollView.frame), CGRectGetWidth(self.scrollView.frame));
        } else {
            newPageSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        }
    
    [UIView animateWithDuration:duration animations:^{
        [self scaleAirplanePathToSize:newPageSize];
    } completion:nil];
}


- (void)configureAnimations
{
    [self configureScrollViewAnimations] ;
    [self configureKobe] ;
    [self configureMonkey] ;
    [self configureJazzHandsLabelAnimations] ;
    [self configureAirplaneAnimations] ;
    [self configureBackButton] ;
}

- (void)configureScrollViewAnimations
{
    IFTTTBackgroundColorAnimation *backgroundColorAnimation = [IFTTTBackgroundColorAnimation animationWithView:self.scrollView] ;
    [backgroundColorAnimation addKeyframeForTime:0
                                           color:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.f]] ;
    [backgroundColorAnimation addKeyframeForTime:1
                                           color:[UIColor colorWithRed:0.14f green:0.8f blue:1.f alpha:1.f]] ;
    [backgroundColorAnimation addKeyframeForTime:2
                                           color:[UIColor colorWithRed:0.32f green:0.52f blue:0.2f alpha:1.f]] ;
    [backgroundColorAnimation addKeyframeForTime:3
                                           color:[UIColor colorWithRed:0.8f green:0.1f blue:0.3f alpha:1.f]] ;
    [self.animator addAnimation:backgroundColorAnimation] ;
}

- (void)configureKobe
{
    // Keep IFTTTPresents centered at the top of pages 0 and 1
    [self keepView:self.kobeHead
           onPages:@[@(0), @(-1)]
           atTimes:@[@(0), @(1)]] ;
    IFTTTAlphaAnimation *kobeAnimation = [IFTTTAlphaAnimation animationWithView:self.kobeHead] ;
    [kobeAnimation addKeyframeForTime:0 alpha:1] ;
    [kobeAnimation addKeyframeForTime:0.8 alpha:0.] ;
    [self.animator addAnimation:kobeAnimation] ;

    [self.kobeHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100)) ;
        make.centerX.equalTo(self.contentView.mas_centerX) ;
        make.centerY.equalTo(self.contentView.mas_centerY) ;
    }] ;
}

- (void)configureMonkey
{
    [self keepView:self.monkey
           onPages:@[@(1), @(2)]
           atTimes:@[@(1), @(2)]];
    
    // Animate the sun moving down from above the screen to near the top of the screen bewteen pages 2.5 and 3
    NSLayoutConstraint *sunVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.monkey
                                                                             attribute:NSLayoutAttributeCenterY
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.contentView
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.f constant:0.f];
    
    [self.contentView addConstraint:sunVerticalConstraint] ;
    
    IFTTTConstraintConstantAnimation *sunVerticalAnimation = [IFTTTConstraintConstantAnimation animationWithSuperview:self.contentView
                                                                                                           constraint:sunVerticalConstraint];
    [sunVerticalAnimation addKeyframeForTime:1 constant:100.f];
    [sunVerticalAnimation addKeyframeForTime:2 constant:300.f];
    [self.animator addAnimation:sunVerticalAnimation];
    
    [self.monkey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100)) ;
        make.centerX.equalTo(self.contentView.mas_centerX) ;
        make.centerY.equalTo(self.contentView.mas_centerY) ;
    }] ;

}

- (void)configureJazzHandsLabelAnimations
{
    // lay out jazz and hands with autolayout (no x-position or y-position constraint since we are animating those separately)
    self.gold.contentMode = UIViewContentModeScaleAspectFill ;
    [self.gold mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.kobeHead).multipliedBy(0.89);
        make.height.equalTo(self.gold.mas_width).multipliedBy(186.f/607.f);
    }];
    self.coin.contentMode = UIViewContentModeScaleAspectFill ;
    [self.coin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.gold).multipliedBy(550.f / 607.f);
        make.height.equalTo(self.coin.mas_width).multipliedBy(244.f/550.f);
    }];
    
    NSLayoutConstraint *jazzVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.gold
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.kobeHead
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:1.f constant:0.f];
    NSLayoutConstraint *handsVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.coin
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.kobeHead
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1.f constant:0.f];
    
    [self.contentView addConstraint:jazzVerticalConstraint];
    [self.contentView addConstraint:handsVerticalConstraint];
    
    // move JAZZ up between pages 0 and 1
    IFTTTConstraintMultiplierAnimation *jazzVerticalAnimation = [IFTTTConstraintMultiplierAnimation animationWithSuperview:self.contentView
                                                                                                                constraint:jazzVerticalConstraint
                                                                                                                 attribute:IFTTTLayoutAttributeHeight
                                                                                                             referenceView:self.kobeHead];
    [jazzVerticalAnimation addKeyframeForTime:0 multiplier:-0.14f] ;
    [jazzVerticalAnimation addKeyframeForTime:1 multiplier:-0.64f] ;
    [self.animator addAnimation:jazzVerticalAnimation] ;
    
    // move HANDS down between pages 0 and 1
    IFTTTConstraintMultiplierAnimation *handsVerticalAnimation = [IFTTTConstraintMultiplierAnimation animationWithSuperview:self.contentView
                                                                                                                 constraint:handsVerticalConstraint
                                                                                                                  attribute:IFTTTLayoutAttributeHeight
                                                                                                              referenceView:self.kobeHead] ;
    [handsVerticalAnimation addKeyframeForTime:0 multiplier:0.2f];
    [handsVerticalAnimation addKeyframeForTime:1 multiplier:0.72f];
    [self.animator addAnimation:handsVerticalAnimation];
    
    // keep JAZZ on page 0, a little to the right
    [self keepView:self.gold onPages:@[@(0)] atTimes:@[@(0)]];
    
    // keep HANDS centered on page 0
    [self keepView:self.coin onPages:@[@(0)] atTimes:@[@(0)]];
    
    // Rotate Jazz 100 degrees counterclockwise between pages 0 and 1
    IFTTTRotationAnimation *jazzRotationAnimation = [IFTTTRotationAnimation animationWithView:self.gold];
    [jazzRotationAnimation addKeyframeForTime:0 rotation:0];
    [jazzRotationAnimation addKeyframeForTime:1 rotation:100];
    [self.animator addAnimation:jazzRotationAnimation];
    
    // Rotate Hands 100 degrees clockwise between pages 0 and 1
    IFTTTRotationAnimation *handsRotationAnimation = [IFTTTRotationAnimation animationWithView:self.coin];
    [handsRotationAnimation addKeyframeForTime:0 rotation:0];
    [handsRotationAnimation addKeyframeForTime:1 rotation:-100];
    [self.animator addAnimation:handsRotationAnimation];
}

- (void)configureAirplaneAnimations
{
    // Set up the view that contains the airplane view and its dashed line path view
    self.planePathLayer = [self airplanePathLayer] ; // cashapelayer
    [self.planePathView.layer addSublayer:self.planePathLayer] ;
    
    [self.planePathView addSubview:self.plane];
    [self.plane mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50)) ;
        make.bottom.equalTo(self.planePathView.mas_centerY);
        make.right.equalTo(self.planePathView.mas_centerX);
    }];
    
    [self.planePathView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView).offset(55);
        make.width.and.height.equalTo(self.plane);
    }];
    
    // Keep the left edge of the planePathView at the center of pages 1 and 2
    [self keepView:self.planePathView
           onPages:@[@(3), @(3.5)]
           atTimes:@[@(3), @(4)]
     withAttribute:IFTTTHorizontalPositionAttributeLeft] ;
    
    // Fly the plane along the path
    self.airplaneFlyingAnimation = [IFTTTPathPositionAnimation animationWithView:self.plane path:self.planePathLayer.path];
    [self.airplaneFlyingAnimation addKeyframeForTime:2 animationProgress:0];
    [self.airplaneFlyingAnimation addKeyframeForTime:3 animationProgress:1];
    [self.animator addAnimation:self.airplaneFlyingAnimation];
    
    // Change the stroke end of the dashed line airplane path to match the plane's current position
    IFTTTLayerStrokeEndAnimation *planePathAnimation = [IFTTTLayerStrokeEndAnimation animationWithLayer:self.planePathLayer];
    [planePathAnimation addKeyframeForTime:1 strokeEnd:0];
    [planePathAnimation addKeyframeForTime:2 strokeEnd:1];
    [self.animator addAnimation:planePathAnimation];
    
    // Fade the plane path view in after page 1 and fade it out again after page 2.5
    IFTTTAlphaAnimation *planeAlphaAnimation = [IFTTTAlphaAnimation animationWithView:self.planePathView];
    [planeAlphaAnimation addKeyframeForTime:1.06f alpha:0];
    [planeAlphaAnimation addKeyframeForTime:1.08f alpha:1];
    [planeAlphaAnimation addKeyframeForTime:2.5f alpha:1];
    [planeAlphaAnimation addKeyframeForTime:4.f alpha:0];
    [self.animator addAnimation:planeAlphaAnimation];
}

- (CGPathRef)airplanePath
{
    // Create a bezier path for the airplane to fly along
    UIBezierPath *airplanePath = [UIBezierPath bezierPath];
    [airplanePath moveToPoint: CGPointMake(120, 20)];
    [airplanePath addCurveToPoint: CGPointMake(40, -130)
                    controlPoint1: CGPointMake(120, 20)
                    controlPoint2: CGPointMake(140, -50)];
    [airplanePath addCurveToPoint: CGPointMake(30, -430)
                    controlPoint1: CGPointMake(-60, -210)
                    controlPoint2: CGPointMake(-320, -430)];
    [airplanePath addCurveToPoint: CGPointMake(-210, -190)
                    controlPoint1: CGPointMake(320, -430)
                    controlPoint2: CGPointMake(130, -190)];
    
    return airplanePath.CGPath;
}

- (CAShapeLayer *)airplanePathLayer
{
    // Create a shape layer to draw the airplane's path
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [self airplanePath];
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineDashPattern = @[@(20), @(20)];
    shapeLayer.lineWidth = 4;
    shapeLayer.miterLimit = 4;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    return shapeLayer;
}

- (void)scaleAirplanePathToSize:(CGSize)pageSize
{
    // Scale the airplane path to the given page size
    CGSize scaleSize = CGSizeMake(pageSize.width / 375.f, pageSize.height / 667.f);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scaleSize.width, scaleSize.height);
    CGPathRef scaledPath = CGPathCreateCopyByTransformingPath(self.airplanePath, &scaleTransform);
    self.planePathLayer.path = scaledPath;
    self.airplaneFlyingAnimation.path = scaledPath;
    CGPathRelease(scaledPath);
}

- (void)configureBackButton
{
    [self keepView:self.button
           onPages:@[@3,@4]] ;
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30)) ;
        make.center.equalTo(self.contentView) ;
    }] ;
    IFTTTScaleAnimation *scaleAnimation = [IFTTTScaleAnimation animationWithView:self.button] ;
    [scaleAnimation addKeyframeForTime:1 scale:1] ;
    [scaleAnimation addKeyframeForTime:2 scale:2] ;
    [scaleAnimation addKeyframeForTime:3 scale:1] ;
    
    [self.animator addAnimation:scaleAnimation] ;

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
