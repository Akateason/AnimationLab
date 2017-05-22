//
//  Zample8Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/19.
//  Copyright © 2017年 teaason. All rights reserved.


#import "Zample8Controller.h"
#import "Masonry.h"

@interface Zample8Controller ()
@property (nonatomic, strong)  UIView *layerView;

@end

@implementation Zample8Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 仿射变换 .
    self.title = @"layer affineTransform" ; //对应view的transform. CATransform3D .
    
    
    self.view.backgroundColor = [UIColor lightGrayColor] ;
    self.layerView = ({
        UIView *view = [[UIView alloc] init] ;
        view.backgroundColor = [UIColor whiteColor] ;
        [self.view addSubview:view] ;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 200)) ;
            make.center.equalTo(self.view) ;
        }] ;
        view ;
    }) ;
    
    
    // Do any additional setup after loading the view.
    
    //1 一次变化
//    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
//    self.layerView.layer.affineTransform = transform;
    
    //2 混合变换  //  Core Graphics提供了一系列的函数可以在一个变换的基础上做更深层次的变换，如果做一个既要缩放又要旋转的变换，这就会非常有用了。例如下面几个函数：

    CGAffineTransform transform = CGAffineTransformIdentity;
    //scale by 50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    //rotate by 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0);
    //translate by 200 points
    transform = CGAffineTransformTranslate(transform, 200, 0);
    //apply transform to layer
    self.layerView.layer.affineTransform = transform;
    
    //3

}










- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
