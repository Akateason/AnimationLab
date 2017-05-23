//
//  BaseVC.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/23.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (UIView *)containerView
{
    if (!_containerView)
    {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)] ;
        _containerView.center = self.view.center ;
        _containerView.backgroundColor = [UIColor lightGrayColor] ;
        [self.view addSubview:_containerView] ;
    }
    return _containerView ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
