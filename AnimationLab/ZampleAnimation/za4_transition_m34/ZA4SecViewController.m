//
//  ZA4SecViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/16.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA4SecViewController.h"
#import "Masonry.h"

@interface ZA4SecViewController ()
@property (nonatomic,strong) UIButton *button ;

@end

@implementation ZA4SecViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    self.button = ({
        UIButton *button = [UIButton new] ;
        [button setTitle:@"pop" forState:0] ;
        [button setTitleColor:[UIColor redColor] forState:0] ;
        [self.view addSubview:button] ;
        [button addTarget:self
                   action:@selector(popOnclick)
         forControlEvents:UIControlEventTouchUpInside] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 40)) ;
            make.center.equalTo(self.view) ;
        }] ;
        button ;
    }) ;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)popOnclick
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
