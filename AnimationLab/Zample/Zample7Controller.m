//
//  Zample7Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/19.
//  Copyright © 2017年 teaason. All rights reserved.
//    理想状况下，当你设置了一个图层的透明度，你希望它包含的整个图层树像一个整体一样的透明效果。你可以通过设置Info.plist文件中的UIViewGroupOpacity为YES来达到这个效果，但是这个设置会影响到这个应用，整个app可能会受到不良影响。如果UIViewGroupOpacity并未设置，iOS 6和以前的版本会默认为NO（也许以后的版本会有一些改变）。
//另一个方法就是，你可以设置CALayer的一个叫做shouldRasterize属性（见清单4.7）来实现组透明的效果，如果它被设置为YES，在应用透明度之前，图层及其子图层都会被整合成一个整体的图片，这样就没有透明度混合的问题了（如图4.21）。
//为了启用shouldRasterize属性，我们设置了图层的rasterizationScale属性。默认情况下，所有图层拉伸都是1.0， 所以如果你使用了shouldRasterize属性，你就要确保你设置了rasterizationScale属性去匹配屏幕，以防止出现Retina屏幕像素化的问题。
//当shouldRasterize和UIViewGroupOpacity一起的时候，性能问题就出现了（我们在第12章『速度』和第15章『图层性能』将做出介绍），但是性能碰撞都本地化了（译者注：这句话需要再翻译）。
//清单4.7 使用shouldRasterize属性解决组透明问题


#import "Zample7Controller.h"

@interface Zample7Controller ()
@property (nonatomic,strong) UIButton *buttomCustom ;
@end

@implementation Zample7Controller

- (UIButton *)buttomCustom
{
    if (!_buttomCustom)
    {
        CGRect frame = CGRectMake(0, 0, 150, 50);
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = 10;
        
        //add label
        frame = CGRectMake(20, 10, 110, 30);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = @"Hello World";
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
        
        _buttomCustom = button ;
    }
    return _buttomCustom ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor] ;
    
    self.title = @"shouldRasterize + rasterizationScale" ; // 组透明 光栅化
    [self.view addSubview:self.buttomCustom] ;
    self.buttomCustom.center = self.view.center ;
    
    //
//    self.buttomCustom.layer.opacity = 0.5 ;
    self.buttomCustom.alpha = 0.5 ;
    
    //enable rasterization for the translucent button
    self.buttomCustom.layer.shouldRasterize = YES;
    self.buttomCustom.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
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



















