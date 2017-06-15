//
//  ZA3ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA3ViewController.h"
#import "ZA3SecViewController.h"
#import "Masonry.h"
//#import "XTBubbleTransition.h"
#import "PingTransition.h"

@interface ZA3ViewController () <UINavigationControllerDelegate>
@property (nonatomic,strong) UIButton *backBt ;
@end

@implementation ZA3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO] ;
    
    self.title = @"transition circle" ;
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.view.backgroundColor = [UIColor cyanColor] ;
    
    self.button = ({
        UIButton *bt = [UIButton new] ;
        bt.backgroundColor = [UIColor blackColor] ;
        bt.layer.cornerRadius = 20 ;
        [bt addTarget:self
               action:@selector(btAction:)
     forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40)) ;
            make.top.equalTo(self.view).offset(30) ;
            make.right.equalTo(self.view).offset(-30) ;
        }] ;
        bt ;
    }) ;
    
    self.backBt = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"back" forState:0] ;
        [bt addTarget:self
               action:@selector(backAction:)
     forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 40)) ;
            make.bottom.equalTo(self.view).offset(-30) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
        }] ;

        bt ;
    }) ;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (void)btAction:(id)sender
{
    ZA3SecViewController *secVC = [ZA3SecViewController new] ;
    [self.navigationController pushViewController:secVC animated:YES] ;
}


#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        PingTransition *ping = [PingTransition new];
        return ping;
    }
    else {
        return nil;
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
