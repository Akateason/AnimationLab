//
//  Zample9Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/19.
//  Copyright © 2017年 teaason. All rights reserved.
//
//CG的前缀告诉我们，CGAffineTransform类型属于Core Graphics框架，Core Graphics实际上是一个严格意义上的2D绘图API，并且CGAffineTransform仅仅对2D变换有效。
//在第三章中，我们提到了zPosition属性，可以用来让图层靠近或者远离相机（用户视角），transform属性（CATransform3D类型）可以真正做到这点，即让图层在3D空间内移动或者旋转。
//和CGAffineTransform类似，CATransform3D也是一个矩阵，但是和2x3的矩阵不同，CATransform3D是一个可以在3维空间内做变换的4x4的矩阵（图5.6）。


#import "Zample9Controller.h"
#import "Masonry.h"

@interface Zample9Controller ()
@property (nonatomic, strong)  UIView *layerView;
@end

@implementation Zample9Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"3D变换" ;
    
    
    self.view.backgroundColor = [UIColor lightGrayColor] ;
    self.layerView = ({
        UIView *view = [[UIView alloc] init] ;
        view.backgroundColor = [UIColor whiteColor] ;
        [self.view addSubview:view] ;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 200)) ;
            make.center.equalTo(self.view) ;
        }] ;
        UIImage *image = [UIImage imageNamed:@"aaa"] ;
        //add it directly to our view's layer
        view.layer.contents = (__bridge id)image.CGImage;
        view.layer.contentsGravity = kCAGravityCenter ; //kCAGravityResizeAspect;
        view.layer.contentsScale = image.scale ; // scale
        //    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
        view.layer.masksToBounds = TRUE ;//mask裁剪

        view ;
    }) ;

    
    
//  1
//    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
//    self.layerView.layer.transform = transform;
//    //看起来图层并没有被旋转，而是仅仅在水平方向上的一个压缩，是哪里出了问题呢？
//    //其实完全没错，视图看起来更窄实际上是因为我们在用一个斜向的视角看它，而不是透视。+
//    

    
    
    
//  2
//    为了做一些修正，我们需要引入投影变换（又称作z变换）来对除了旋转之外的变换矩阵做一些修改，Core Animation并没有给我们提供设置透视变换的函数，因此我们需要手动修改矩阵值，幸运的是，很简单：
//    CATransform3D的透视效果通过一个矩阵中一个很简单的元素来控制：m34。m34（图5.9）用于按比例缩放X和Y的值来计算到底要离视角多远。
//    图5.9
//    
//    图5.9 CATransform3D的m34元素，用来做透视
//    m34的默认值是0，我们可以通过设置m34为-1.0 / d来应用透视效果，d代表了想象中视角相机和屏幕之间的距离，以像素为单位，那应该如何计算这个距离呢？实际上并不需要，大概估算一个就好了。
//    因为视角相机实际上并不存在，所以可以根据屏幕上的显示效果自由决定它的防止的位置。通常500-1000就已经很好了，但对于特定的图层有时候更小后者更大的值会看起来更舒服，减少距离的值会增强透视效果，所以一个非常微小的值会让它看起来更加失真，然而一个非常大的值会让它基本失去透视效果，对视图应用透视的代码见清单5.5，结果见图5.10。

    CATransform3D transform = CATransform3DIdentity;
    //apply perspective
    transform.m34 = - 1.0 / 500.0;
    //rotate by 45 degrees along the Y axis
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    //apply to layer
    self.layerView.layer.transform = transform;

    
    
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
