//
//  ZA1ReverseTransition.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA1ReverseTransition.h"
#import "ZA1ViewController.h"
#import "ZA1SecondController.h"
#import "ZA1CollectionViewCell.h"

@implementation ZA1ReverseTransition


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //获取动画前后两个VC 和 发生的容器containerView
    ZA1ViewController *toVC = (ZA1ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] ;
    ZA1SecondController *fromVC = (ZA1SecondController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] ;
    UIView *containerView = [transitionContext containerView] ;
    
    //在前一个VC上创建一个截图
    UIView  *snapShotView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO] ;
    snapShotView.backgroundColor = [UIColor clearColor] ;
    snapShotView.frame = [containerView convertRect:fromVC.imageView.frame fromView:fromVC.imageView.superview] ;
    fromVC.imageView.hidden = YES ;
    
    //初始化后一个VC的位置
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC] ;
    
    //获取toVC中图片的位置
    ZA1CollectionViewCell *cell = (ZA1CollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.indexPath] ;
    cell.imgView.hidden = YES;

    
    
    //顺序很重要，
    [containerView insertSubview:toVC.view belowSubview:fromVC.view] ;
    [containerView addSubview:snapShotView] ;
    
    //发生动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromVC.view.alpha = 0.0f;
                         snapShotView.frame = toVC.finalCellRect;
                     } completion:^(BOOL finished) {
                         [snapShotView removeFromSuperview] ;
                         fromVC.imageView.hidden = NO ;
                         cell.imgView.hidden = NO ;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
    
}

@end
