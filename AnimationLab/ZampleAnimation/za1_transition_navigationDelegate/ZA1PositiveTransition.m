//
//  ZA1PositiveTransition.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA1PositiveTransition.h"
#import "ZA1ViewController.h"
#import "ZA1SecondController.h"
#import "ZA1CollectionViewCell.h"

@implementation ZA1PositiveTransition

#pragma mark - UIViewControllerAnimatedTransitioning <NSObject>
// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6 ;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    ZA1ViewController *fromVC = (ZA1ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] ;
    ZA1SecondController *toVC   = (ZA1SecondController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] ;
    UIView *containerView = [transitionContext containerView] ;
    
    
    //对Cell上的 imageView 截图，同时将这个 imageView 本身隐藏
    ZA1CollectionViewCell *cell = (ZA1CollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:[[fromVC.collectionView indexPathsForSelectedItems] firstObject]] ;
    fromVC.indexPath = [[fromVC.collectionView indexPathsForSelectedItems] firstObject] ;
    
    UIView * snapShotView = [cell.imgView snapshotViewAfterScreenUpdates:NO] ;
    snapShotView.frame = fromVC.finalCellRect = [containerView convertRect:cell.imgView.frame
                                                                  fromView:cell.imgView.superview] ;
    cell.imgView.hidden = YES ;
    
    
    //设置第二个控制器的位置、透明度
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC] ;
    toVC.view.alpha = 0 ;
    toVC.imageView.hidden = YES ;
    
    //把动画前后的两个ViewController加到容器中,顺序很重要,snapShotView在上方
    [containerView addSubview:toVC.view] ;
    [containerView addSubview:snapShotView] ;
    
    //动起来。第二个控制器的透明度0~1；让截图SnapShotView的位置更新到最新；
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [containerView layoutIfNeeded] ;
                         toVC.view.alpha = 1.0 ;
                         snapShotView.frame = [containerView convertRect:toVC.imageView.frame
                                                                fromView:toVC.imageView.superview] ;
                     } completion:^(BOOL finished) {
                         //为了让回来的时候，cell上的图片显示，必须要让cell上的图片显示出来
                         toVC.imageView.hidden = NO ;
                         cell.imgView.hidden = NO ;
                         [snapShotView removeFromSuperview] ;
                         //告诉系统动画结束
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled] ;
                     }];
}

@end
