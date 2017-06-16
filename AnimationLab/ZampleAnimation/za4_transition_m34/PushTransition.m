//
//  PushTransition.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/16.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "PushTransition.h"
#import "ZA4ViewController.h"
#import "ZA4SecViewController.h"

@implementation PushTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6 ;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //1
    //1）通过上下文transitionContext获得前后两个UIView，这也是发生动画的具体对象。同时还需要获得containerView,这也是动画发生的地方。我们需要把后一个视图添加上去。为了保证后一个视图加上去之后不遮住前一个视图的动画，我们还要把后一个视图放到最后：[containerView sendSubviewToBack:toView];
    ZA4ViewController *fromVC = (ZA4ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ZA4SecViewController *toVC = (ZA4SecViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    //2
    //2)为了保证视图产生3D的效果，我们需要设置layer的仿射变换。关于仿射变化和m34的概念，推荐一篇博客：iOS的三维透视投影。
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    //3
    //3）为fromView、toView设置初始frame。
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    
    //4
    //4）重置锚点。锚点就是视图旋转时候的中心，就是那个不动的点。关于锚点以及position的关系，你可以参考这一篇解释：这将是你最后一次纠结position与anchorPoint！。所以我们在设置了锚点的之后，还需要把layer的position也设置到相应位置：
    [self updateAnchorPointAndOffset:CGPointMake(0.0, 0.5) view:fromView];
    //方便记忆，你可以理解锚点会吸附到position上。所以光改变锚点不改变position，那么结果就是锚点确实改了，但是position还是在默认的（0.5，0.5），也就是视图中心。就像这样：

    //5
    //5）给fromView增加左深右浅的阴影。并且一开始的透明度为0，随着翻转的角度变大过渡到1。
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = fromView.bounds;
    gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(0.8, 0.5);
    UIView *shadow = [[UIView alloc]initWithFrame:fromView.bounds];
    shadow.backgroundColor = [UIColor clearColor];
    [shadow.layer insertSublayer:gradient atIndex:1];
    shadow.alpha = 0.0;
    
    [fromView addSubview:shadow];
    
    //6
    //6）开始动画。这这里，我们让fromView翻转90度 fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1.0, 0);。这里要注意向外90度是-M_PI_2，y为1.0表示绕着y轴旋转。
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //旋转fromView 90度
        fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1.0, 0);
        shadow.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        //7
        //7）动画结束，我们需要还原锚点的位置、恢复position的位置、恢复layer的transform为CATransform3DIdentity，并且把阴影层移除。由于一开始我没有没有恢复锚点和position的位置，而且一直没找到原因。知道我查看了视图的层级结构才恍然大悟：
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        fromView.layer.transform = CATransform3DIdentity;
        [shadow removeFromSuperview];
        [transitionContext completeTransition:YES];
        
    }];
    
}

//
//
//

- (void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view
{
    view.layer.anchorPoint = anchorPoint;
    view.layer.position    = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
}



@end
