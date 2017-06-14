//
//  ZA1SecondController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA1SecondController.h"
#import "ZA1ViewController.h"
#import "ZA1ReverseTransition.h"
#import "Masonry.h"

@interface ZA1SecondController () <UINavigationControllerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@end

@implementation ZA1SecondController

#pragma mark - life
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutUI] ;
    //
    self.navigationController.delegate = self ;
    // 滑动手势 控制比例的pop动作
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGestureAction:)] ;
    //设置从什么边界滑入
    edgePanGestureRecognizer.edges = UIRectEdgeLeft ;
    [self.view addGestureRecognizer:edgePanGestureRecognizer] ;
}

- (void)layoutUI
{
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init] ;
        imageView.contentMode = UIViewContentModeScaleAspectFill ;
        [imageView.layer setMasksToBounds:YES] ;
        imageView.image = [UIImage imageNamed:@"111"] ;
        [self.view addSubview:imageView] ;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat wid = CGRectGetWidth([UIScreen mainScreen].bounds) - 4 * 2 ;
            make.top.equalTo(self.view).offset(4) ;
            make.width.mas_equalTo(wid) ;
            make.height.mas_equalTo(wid) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
        }] ;
        imageView ;
    }) ;
    self.textView = ({
        UITextView *textView = [[UITextView alloc] init] ;
        textView.text = @"2017高考已于上周落下帷幕，考生们从这周开始可以放松一夏。今年的高考理综全国I卷的生物大题的实验设计题挺有意思，于是便起了念头，想大家一起分享下我的答题思路。先来看看原题：29.(10分) 根据遗传物质的化学组成，可将病毒分为RNA病毒和DNA病毒两种类型。有些病毒对人类健康会造成很大危害。通常，一种新病毒出现后需要确定该病毒的类型。2017高考已于上周落下帷幕，考生们从这周开始可以放松一夏。今年的高考理综全国I卷的生物大题的实验设计题挺有意思，于是便起了念头，想大家一起分享下我的答题思路。先来看看原题：29.(10分) 根据遗传物质的化学组成，可将病毒分为RNA病毒和DNA病毒两种类型。有些病毒对人类健康会造成很大危害。通常，一种新病毒出现后需要确定该病毒的类型。2017高考已于上周落下帷幕，考生们从这周开始可以放松一夏。今年的高考理综全国I卷的生物大题的实验设计题挺有意思，于是便起了念头，想大家一起分享下我的答题思路。先来看看原题：29.(10分) 根据遗传物质的化学组成，可将病毒分为RNA病毒和DNA病毒两种类型。有些病毒对人类健康会造成很大危害。通常，一种新病毒出现后需要确定该病毒的类型。2017高考已于上周落下帷幕，考生们从这周开始可以放松一夏。今年的高考理综全国I卷的生物大题的实验设计题挺有意思，于是便起了念头，想大家一起分享下我的答题思路。先来看看原题：29.(10分) 根据遗传物质的化学组成，可将病毒分为RNA病毒和DNA病毒两种类型。有些病毒对人类健康会造成很大危害。通常，一种新病毒出现后需要确定该病毒的类型。" ;
        [self.view addSubview:textView] ;
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(4) ;
            make.top.equalTo(self.imageView.mas_bottom).offset(4) ;
        }] ;
        textView ;
    }) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - gesture action
- (void)edgePanGestureAction:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0) ;
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
    
    //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init] ;
        [self.navigationController popViewControllerAnimated:YES] ;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
    //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self.percentDrivenTransition updateInteractiveTransition:progress] ;
    }
    else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded)
    {
    //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.5)
        {
            [self.percentDrivenTransition finishInteractiveTransition];
        }
        else
        {
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
    
}


#pragma mark - <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[ZA1ViewController class]])
    {
        ZA1ReverseTransition *inverseTransition = [[ZA1ReverseTransition alloc] init] ;
        return inverseTransition ;
    }
    else
    {
        return nil ;
    }
}


- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if ([animationController isKindOfClass:[ZA1ReverseTransition class]])
    {
        return self.percentDrivenTransition;
    }
    else
    {
        return nil;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
