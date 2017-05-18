//
//  Zample2Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/18.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "Zample2Controller.h"

@interface Zample2Controller ()
@property (nonatomic, strong)  UIView *coneView;
@property (nonatomic, strong)  UIView *shipView;
@property (nonatomic, strong)  UIView *iglooView;
@property (nonatomic, strong)  UIView *anchorView;
@end

@implementation Zample2Controller

- (void)layUIs
{
    self.coneView = ({
        UIView *view = [UIView new] ;
        view.frame = CGRectMake(10, 10, 100, 100) ;
        [self.view addSubview:view] ;
        view ;
    }) ;
    
    self.shipView = ({
        UIView *view = [UIView new] ;
        view.frame = CGRectMake(150, 40, 100, 100) ;
        [self.view addSubview:view] ;
        view ;
    }) ;
    self.iglooView = ({
        UIView *view = [UIView new] ;
        view.frame = CGRectMake(10, 200, 100, 100) ;
        [self.view addSubview:view] ;
        view ;
    }) ;
    self.anchorView = ({
        UIView *view = [UIView new] ;
        view.frame = CGRectMake(190, 300, 100, 100) ;
        [self.view addSubview:view] ;
        view ;
    }) ;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.title = @"layer contentsRect" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    [self layUIs] ;
    
//CALayer的contentsRect属性允许我们在图层边框里显示寄宿图的一个子域。这涉及到图片是如何显示和拉伸的，所以要比contentsGravity灵活多了
//和bounds，frame不同，contentsRect不是按点来计算的，它使用了单位坐标，单位坐标指定在0到1之间，是一个相对值（像素和点就是绝对值）。所以他们是相对与寄宿图的尺寸的。iOS使用了以下的坐标系统：+
//默认的contentsRect是{0, 0, 1, 1}，这意味着整个寄宿图默认都是可见的，如果我们指定一个小一点的矩形，图片就会被裁剪（如图2.6）+
    
    UIImage *image = [UIImage imageNamed:@"bbb"];
    //set igloo sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.iglooView.layer];
    //set cone sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.coneView.layer];
    //set anchor sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.anchorView.layer];
    //set spaceship sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.shipView.layer];


}

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer //set image
{
    layer.contents = (__bridge id)image.CGImage;
    
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    //set contentsRect
    layer.contentsRect = rect;
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
