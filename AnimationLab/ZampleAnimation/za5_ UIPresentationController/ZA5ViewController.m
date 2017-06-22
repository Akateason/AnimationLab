//
//  ZA5ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/18.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA5ViewController.h"
#import "Masonry.h"
#import "ZA5SecController.h"


@interface ZA5ViewController ()
@property (nonatomic,strong) UILabel *titleLabel ;
@property (nonatomic,strong) UIImageView *imageView ;
@property (nonatomic,strong) UIButton *button ;
@property (nonatomic,strong) UIButton *backButton ;
@end

@implementation ZA5ViewController

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO] ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    
    self.titleLabel = ({
        UILabel *label = [UILabel new] ;
        label.text = @"UIPresentationController" ;
        [self.view addSubview:label] ;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(24) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
        }] ;

        label ;
    }) ;
    
    self.imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init] ;
        imageView.contentMode = UIViewContentModeScaleAspectFill ;
        [imageView.layer setMasksToBounds:YES] ;
        imageView.image = [UIImage imageNamed:@"111"] ;
        [self.view addSubview:imageView] ;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat wid = CGRectGetWidth([UIScreen mainScreen].bounds) - 4 * 2 ;
            make.top.equalTo(self.titleLabel.mas_bottom).offset(4) ;
            make.width.mas_equalTo(wid) ;
            make.height.mas_equalTo(wid) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
        }] ;
        imageView ;
    }) ;
    
    self.button = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitleColor:[UIColor blackColor] forState:0] ;
        [bt setTitle:@"present" forState:0] ;
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
    
    self.backButton = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitleColor:[UIColor blackColor] forState:0] ;
        [bt setTitle:@"back" forState:0] ;
        [bt addTarget:self
               action:@selector(backAction:)
     forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(140, 40)) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
            make.bottom.equalTo(self.button.mas_top).offset(-20) ;
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
    ZA5SecController *secVC = [ZA5SecController new] ;
    [self presentViewController:secVC
                       animated:YES
                     completion:^{}] ;
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES] ;
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
