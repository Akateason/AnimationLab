//
//  Zample1Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/17.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "Zample1Controller.h"
#import "Masonry.h"

@interface Zample1Controller ()
@property (nonatomic,strong) UIView *layerView ;
@end

@implementation Zample1Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"layer img" ;
    
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
    
//1 add sub layer in layer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:blueLayer];

//2 寄宿图
    UIImage *image = [UIImage imageNamed:@"aaa"] ;
    //add it directly to our view's layer
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityCenter ; //kCAGravityResizeAspect;
    self.layerView.layer.contentsScale = image.scale ; // scale
//    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layerView.layer.masksToBounds = TRUE ;//mask裁剪



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
