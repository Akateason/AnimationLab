//
//  Zample3Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/18.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "Zample3Controller.h"

@interface Zample3Controller ()
@property (nonatomic, strong)  UIView *button1;
@property (nonatomic, strong)  UIView *button2;

@end

@implementation Zample3Controller


- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer
{
    //set image
    layer.contents = (__bridge id)image.CGImage;
//    layer.contentsGravity = kCAGravityResizeAspectFill ;
    
    //set contentsCenter
    layer.contentsCenter = rect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.title = @"layer contentsCenter" ;
    [self layUIs] ;
    //寄宿图
//    默认情况下，contentsCenter是{0, 0, 1, 1}，这意味着如果大小（由conttensGravity决定）改变了,那么寄宿图将会均匀地拉伸开。但是如果我们增加原点的值并减小尺寸。我们会在图片的周围创造一个边框。图2.9展示了contentsCenter设置为{0.25, 0.25, 0.5, 0.5}的效果。+
    

    //load button image
    UIImage *image = [UIImage imageNamed:@"ccc"] ;
    
    //set button 1
    [self addStretchableImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.1, 0.1) toLayer:self.button1.layer] ;
    //set button 2
    [self addStretchableImage:image withContentCenter:CGRectMake(0.2, 0.2, 0.3, 0.3) toLayer:self.button2.layer] ;
}

- (void)layUIs
{
    self.button1 = ({
        UIButton *view = [UIButton new] ;
        view.frame = CGRectMake(10, 10, 50, 200) ;
        [self.view addSubview:view] ;
        view ;
    }) ;
    
    self.button2 = ({
        UIButton *view = [UIButton new] ;
        view.frame = CGRectMake(20, 300, 200, 50) ;
        [self.view addSubview:view] ;
        view ;
    }) ;
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
