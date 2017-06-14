//
//  ZA2ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA2ViewController.h"
#import "ZA2SecViewController.h"
#import "ZA2RotationPresentAnimation.h"
#import "ZA2RotationDismissAnimation.h"


#import "Masonry.h"

@interface ZA2ViewController () <ZA2SecViewControllerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) UIButton *button ;
@property(nonatomic,strong) ZA2RotationPresentAnimation *presentAnimation;
@property(nonatomic,strong)ZA2RotationDismissAnimation *dismissAnimation;
@end

@implementation ZA2ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.presentAnimation = [[ZA2RotationPresentAnimation alloc] init] ;
        self.dismissAnimation = [[ZA2RotationDismissAnimation alloc] init] ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"transition presentVC" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.button = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"hit me to transition"
            forState:0] ;
        [bt setTitleColor:[UIColor blueColor] forState:0] ;
        [bt addTarget:self
               action:@selector(btAction:)
     forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.center.equalTo(self.view) ;
        }] ;
        bt ;
    }) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btAction:(id)sender
{
    ZA2SecViewController *secVC = [ZA2SecViewController new] ;
    secVC.delegate = self ;
    secVC.transitioningDelegate = self ;

    [self presentViewController:secVC
                       animated:YES
                     completion:^{
                         
                     }] ;
}

#pragma mark - ZA2SecViewControllerDelegate <NSObject>
- (void)z2willDismiss:(id)controller
{
    [(UIViewController *)controller dismissViewControllerAnimated:YES
                                                       completion:^{
        
    }] ;
}

#pragma mark - UIViewControllerTransitioningDelegate
//3、主控制器实现代理方法。这个方法，我们只需要在呈现VC的时候，给出一个实现了 UIViewControllerAnimatedTransitioning 协议的对象。这里，显然就是继承于RotationPresentAnimation 的presentAnimation。
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    return self.presentAnimation ;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
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
