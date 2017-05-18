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
    
    
    //load button image
    UIImage *image = [UIImage imageNamed:@"ccc"];
    
    //set button 1
    [self addStretchableImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.button1.layer];
    //set button 2
    [self addStretchableImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.button2.layer];
}

- (void)layUIs
{
    self.button1 = ({
        UIButton *view = [UIButton new] ;
        view.frame = CGRectMake(10, 10, 100, 100) ;
        [self.view addSubview:view] ;
        view ;
    }) ;
    
    self.button2 = ({
        UIButton *view = [UIButton new] ;
        view.frame = CGRectMake(150, 40, 100, 100) ;
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
