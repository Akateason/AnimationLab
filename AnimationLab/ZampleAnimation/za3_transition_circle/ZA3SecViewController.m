//
//  ZA3SecViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA3SecViewController.h"
#import "Masonry.h"

@interface ZA3SecViewController ()
@property (nonatomic,strong) UIButton *button ;

@end

@implementation ZA3SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.view.backgroundColor = [UIColor orangeColor] ;
    
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btAction:(id)sender
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
