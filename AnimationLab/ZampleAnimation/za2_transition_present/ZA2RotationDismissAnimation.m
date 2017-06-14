//
//  ZA2RotationDismissAnimation.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA2RotationDismissAnimation.h"
#import <UIKit/UIKit.h>

@implementation ZA2RotationDismissAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.6 ;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect initRect  = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalRect = CGRectOffset(initRect, 0, [[UIScreen mainScreen]bounds].size.height);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:1.f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        fromVC.view.frame = finalRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

}

@end
