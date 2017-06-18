//
//  ZA5SecController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/18.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA5SecController.h"
#import "Masonry.h"
#import "Z5Transition.h"
#import "Z5PresentationController.h"

@interface ZA5SecController ()
{
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
    CGFloat percent;
}
@property (nonatomic,strong) UIButton *button ;
@property (nonatomic,strong) UIImageView *imageView ;
@end

@implementation ZA5SecController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    self.button = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitleColor:[UIColor blackColor] forState:0] ;
        [bt setTitle:@"dismiss" forState:0] ;
        [bt addTarget:self
               action:@selector(btAction:)
     forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(140, 40)) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
            make.bottom.equalTo(self.view) ;
        }] ;
        bt ;
    }) ;
    
    self.imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init] ;
        imageView.contentMode = UIViewContentModeScaleAspectFill ;
        [imageView.layer setMasksToBounds:YES] ;
        imageView.image = [UIImage imageNamed:@"111"] ;
        [self.view addSubview:imageView] ;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat wid = 100 ;
            make.top.equalTo(self.view).offset(4) ;
            make.width.mas_equalTo(wid) ;
            make.height.mas_equalTo(wid) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
        }] ;
        imageView ;
    }) ;

    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self.view addGestureRecognizer:pan];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panGes:(UIPanGestureRecognizer *)gesture
{
    CGFloat yOffset = [gesture translationInView:self.view].y ;
    percent = yOffset / 1800 ;
    //    percent = MAX(0, MIN(1, percent));
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init] ;
        //这句必须加上！！
        [self dismissViewControllerAnimated:YES
                                 completion:nil] ;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        [percentDrivenInteractiveTransition updateInteractiveTransition:percent] ;
    }
    else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded)
    {
        [percentDrivenInteractiveTransition finishInteractiveTransition] ;
        //        if (percent > 0.06) {
        //
        //
        //        }else{
        //            [percentDrivenInteractiveTransition cancelInteractiveTransition];
        //        }
        //这句也必须加上！！
        percentDrivenInteractiveTransition = nil ;
    }
}

- (void)btAction:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
    }] ;
}


#pragma mark - <UIViewControllerTransitioningDelegate>
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source
{
    Z5PresentationController *presentation = [[Z5PresentationController alloc] initWithPresentedViewController:presented
                                                                                      presentingViewController:presenting] ;
    return presentation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    Z5Transition * present = [[Z5Transition alloc] initWithBool:YES] ;
    return present ;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if (dismissed) {
        Z5Transition * present = [[Z5Transition alloc] initWithBool:NO] ;
        return present ;
    }
    else {
        return nil ;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    if (animator) {
        return percentDrivenInteractiveTransition ;
    }
    else {
        return nil ;
    }
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
