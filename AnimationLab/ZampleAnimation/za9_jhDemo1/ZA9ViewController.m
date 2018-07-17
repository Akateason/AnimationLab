//
//  ZA9ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2018/7/17.
//  Copyright © 2018年 teaason. All rights reserved.
//

#import "ZA9ViewController.h"
#import "IFTTTJazzHands.h"
#import <XTlib.h>

@interface ZA9ViewController ()

@property (strong, nonatomic) UIScrollView *scrollView; //和我们交互的scrollView
@property (strong,nonatomic) UIView *v; //蓝色方块 view
@property (strong,nonatomic) IFTTTAnimator *animator; //创建 Animator 来管理页面中的所有动画

@end

@implementation ZA9ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.animator=[[IFTTTAnimator alloc]init];
    
    //初始化 scrollView
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.pagingEnabled=YES;
    self.scrollView.backgroundColor=[UIColor lightGrayColor];
    self.scrollView.contentSize=CGSizeMake(APP_WIDTH*2,0);
    self.scrollView.delegate=self;
    [self.view addSubview:self.scrollView];
    
    //创建蓝色方块 View
    self.v=[[UIView alloc]initWithFrame:CGRectMake(100,200, 50, 50)];
    self.v.backgroundColor=[UIColor blueColor];
    [self.scrollView addSubview:self.v];
    
    [self setupAnimation];
    
}

-(void)setupAnimation{
    //创建一个透明度动画
    IFTTTAlphaAnimation *alpha=[IFTTTAlphaAnimation animationWithView:self.v];
    //将所有动画添加到 animator 中
    [self.animator addAnimation:alpha];
    
    //添加2个帧,在 scrollView 从 0 滚动到 200 时, 淡出我们的 View
    [alpha addKeyframeForTime:0 alpha:1.0];
    [alpha addKeyframeForTime:200 alpha:0.0];
    
    //创建平移动画
    IFTTTTranslationAnimation *tran=[IFTTTTranslationAnimation animationWithView:self.v];
    [self.animator addAnimation:tran];
    
    //添加2个帧,在 scrollView 从 0 滚动到 200 时, view 沿X轴平移150,沿Y平移60.
    [tran addKeyframeForTime:0 translation:CGPointMake(0, 0)];
    [tran addKeyframeForTime:200 translation:CGPointMake(150, 60)];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.animator animate:scrollView.contentOffset.x];
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
