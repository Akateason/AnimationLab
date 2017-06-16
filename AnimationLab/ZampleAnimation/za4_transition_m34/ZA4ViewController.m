//
//  ZA4ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/15.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA4ViewController.h"
#import "ZA4SecViewController.h"
#import "PushTransition.h"
#import "PushReverseTransition.h"
#import "Masonry.h"
#import "KYPopInteractiveTransition.h"

@interface ZA4ViewController () <UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *imageView ;
@property (nonatomic,strong) UIButton *button ;
@property (nonatomic,strong) UIButton *backButton ;
@end

@implementation ZA4ViewController
{
    KYPopInteractiveTransition *popInteractive ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"transition m34" ;
    [self.navigationController setNavigationBarHidden:YES
                                             animated:NO] ;
    
    self.imageView = ({
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"111"]] ;
        imageview.contentMode = UIViewContentModeScaleAspectFill ;
        [imageview.layer setMasksToBounds:YES] ;
        [self.view addSubview:imageview] ;
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view) ;
        }] ;
        imageview ;
    }) ;
    
    self.button = ({
        UIButton *button = [UIButton new] ;
        [button setTitle:@"push" forState:0] ;
        [button setTitleColor:[UIColor redColor] forState:0] ;
        [self.view addSubview:button] ;
        [button addTarget:self
                   action:@selector(pushOnclick)
         forControlEvents:UIControlEventTouchUpInside] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 40)) ;
            make.center.equalTo(self.view) ;
        }] ;
        button ;
    }) ;
    
    self.backButton = ({
        UIButton *button = [UIButton new] ;
        [button setTitle:@"back" forState:0] ;
        [button setTitleColor:[UIColor blueColor] forState:0] ;
        [self.view addSubview:button] ;
        [button addTarget:self
                   action:@selector(backOnclick)
         forControlEvents:UIControlEventTouchUpInside] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 40)) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
            make.bottom.equalTo(self.view) ;
        }] ;
        button ;
    }) ;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.delegate = self ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backOnclick
{
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (void)pushOnclick
{
    ZA4SecViewController *secVC = [ZA4SecViewController new] ;
    secVC.navigationController.delegate = self ;
    popInteractive = [KYPopInteractiveTransition new] ;
    [popInteractive addPopGesture:secVC] ;
    [self.navigationController pushViewController:secVC
                                         animated:YES] ;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        PushTransition *flip = [PushTransition new];
        return flip;        
    }
    else if (operation == UINavigationControllerOperationPop) {
        PushReverseTransition *flip = [PushReverseTransition new];
        return flip;
    }
    else {
        return nil;
    }
}


- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return popInteractive.interacting ? popInteractive : nil;
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
