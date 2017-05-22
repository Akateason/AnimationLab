//
//  Zample6Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/19.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "Zample6Controller.h"
#import "Masonry.h"

@interface Zample6Controller ()
@property (nonatomic,strong) UIImageView    *imageView ;
@property (nonatomic,strong) UIView         *layerView ;
@end

@implementation Zample6Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"layer mask" ; // 蒙版 (遮罩)
    
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
    
    self.imageView = ({
        UIImageView *imgView = [[UIImageView alloc] init] ;
        imgView.backgroundColor = [UIColor blueColor] ;
        imgView.image = [UIImage imageNamed:@"ccc"] ;
        [self.layerView addSubview:imgView] ;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 200)) ;
            make.center.equalTo(self.view) ;
        }] ;
        imgView ;
    }) ;
    
    //create mask layer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.layerView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"ddd"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    //apply mask to image layer￼
    self.imageView.layer.mask = maskLayer;
    
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
