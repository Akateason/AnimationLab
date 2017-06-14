//
//  ZA2SecViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA2SecViewController.h"
#import "Masonry.h"

@interface ZA2SecViewController ()
@property (nonatomic,strong) UIButton *button ;

@end

@implementation ZA2SecViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor orangeColor] ;
    self.button = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"hit me to back" forState:0] ;
        [bt setTitleColor:[UIColor blueColor] forState:0] ;
        [bt addTarget:self action:@selector(btOnclick:)
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

- (void)btOnclick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(z2willDismiss:)])
    {
        [self.delegate z2willDismiss:self] ;
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
