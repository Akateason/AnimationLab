//
//  Zample11Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/23.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "Zample11Controller.h"
#import "Masonry.h"

@interface Zample11Controller ()
@property (nonatomic, strong) UIView *containerView ;

@end

@implementation Zample11Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"CAShapeLayer" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    
//1
    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100)
                    radius:25
                startAngle:0
                  endAngle:2*M_PI
                 clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.containerView.layer addSublayer:shapeLayer];
    
    
    
    
    
    
    
//2    我们可以通过这个图层路径绘制一个既有直角又有圆角的视图。如果我们想依照此图形来剪裁视图内容，我们可以把CAShapeLayer作为视图的宿主图层，而不是添加一个子视图（图层蒙板的详细解释见第四章『视觉效果』）。+

    //define path parameters
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor yellowColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 5;
    shapeLayer2.lineJoin = kCALineJoinRound;
    shapeLayer2.lineCap = kCALineCapRound;
    shapeLayer2.path = path2.CGPath;
    [self.containerView.layer addSublayer:shapeLayer2];

}


- (UIView *)containerView
{
    if (!_containerView)
    {
        _containerView = [UIView new] ;
        _containerView.backgroundColor = [UIColor lightGrayColor] ;
        [self.view addSubview:_containerView] ;
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 200)) ;
            make.center.equalTo(self.view) ;
        }] ;
    }
    return _containerView ;
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
