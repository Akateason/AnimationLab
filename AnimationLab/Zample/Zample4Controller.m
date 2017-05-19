//
//  Zample4Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/18.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "Zample4Controller.h"
#import "Masonry.h"

@interface Zample4Controller () <CALayerDelegate>
@property (nonatomic,strong) UIView *layerView ;
@end

@implementation Zample4Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"layer contentsCenter" ;
    //寄宿图
    
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
    
    
    
    //create sublayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //set controller as layer delegate
    blueLayer.delegate = self;
    
    //ensure that layer backing image uses correct scale
    blueLayer.contentsScale = [UIScreen mainScreen].scale; //add layer to our view
    [self.layerView.layer addSublayer:blueLayer];
    
    //force layer to redraw
    [blueLayer display];
    
    
    
//    现在你理解了CALayerDelegate，并知道怎么使用它。但是除非你创建了一个单独的图层，你几乎没有机会用到CALayerDelegate协议。因为当UIView创建了它的宿主图层时，它就会自动地把图层的delegate设置为它自己，并提供了一个-displayLayer:的实现，那所有的问题就都没了。
//    当使用寄宿了视图的图层的时候，你也不必实现-displayLayer:和-drawLayer:inContext:方法来绘制你的寄宿图。通常做法是实现UIView的-drawRect:方法，UIView就会帮你做完剩下的工作，包括在需要重绘的时候调用-display方法。
    
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
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
