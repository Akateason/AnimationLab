//
//  ZA10ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2018/7/17.
//  Copyright © 2018年 teaason. All rights reserved.
//

#import "ZA10ViewController.h"
#import <IFTTTJazzHands.h>


#define NUMBER_OF_PAGES 3
#define PageWidth APP_WIDTH //每一页的宽度
#define PageHeight APP_HEIGHT
#define timeForPage(page) (NSInteger)(PageWidth * (page - 1)) //马上下面会说到


@interface ZA10ViewController ()
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) IFTTTAnimator *animator;
@property (strong,nonatomic) UIImageView *point1;
@property (strong,nonatomic) UIImageView *point2;
@property (strong,nonatomic) UIImageView *point3;

@end

@implementation ZA10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];  //设置 View 的位置
    [self setupAnimation]; //添加动画
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.animator animate:scrollView.contentOffset.x] ;
}

-(void)setupView{
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.delegate=self;
    self.scrollView.backgroundColor=[UIColor whiteColor];
    self.scrollView.pagingEnabled=YES;
    self.scrollView.contentSize=CGSizeMake(APP_WIDTH*NUMBER_OF_PAGES,0); //高度为0,不会上下滚动
    self.animator=[IFTTTAnimator new];
    //
    self.point1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sunny"]];
    self.point2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yueliang"]];
    self.point3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"starRight"]];
    //
    self.point1.center=CGPointMake(PageWidth*0.5+80, PageHeight*0.5+80); //第一个点,放在第一页中间偏右下的位置
    self.point2.center=CGPointMake(PageWidth*1.5-80, PageHeight*0.5+80); //第二个点,放在第二页中间偏左的位置
    self.point3.center=CGPointMake(PageWidth*2.5, PageHeight*0.5-80); //第三个点,放在第三页偏上位置.
    //
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.point1];
    [self.scrollView addSubview:self.point2];
    [self.scrollView addSubview:self.point3];
}

-(void)setupAnimation{
    //Point1
    IFTTTFrameAnimation *point1Frame=[IFTTTFrameAnimation animationWithView:self.point1];
    [self.animator addAnimation:point1Frame];
    
    //添加2个帧动画,在 scrollView 从第一页滚动到第二页时,圆点1的位置从它的起始位置移动到圆点2的位置.
    [point1Frame addKeyframeForTime:timeForPage(1) frame:self.point1.frame];
    [point1Frame addKeyframeForTime:timeForPage(2) frame:self.point2.frame];
    
    //timeForPage 方便我们转换,页数 - 时间
    
    //Point2 位移
    IFTTTFrameAnimation *point2Frame=[IFTTTFrameAnimation animationWithView:self.point2];
    [self.animator addAnimation:point2Frame];
    
    //让scrollView 从第一页滚动到第二页时
    //圆点2从圆点一个位置,移动到圆点原来的位置,这样2个圆点叠加起来移动,看起来好像是一个圆点渐变成了另一个圆点了,
    [point2Frame addKeyframeForTime:timeForPage(1) frame:self.point1.frame];
    [point2Frame addKeyframeForTime:timeForPage(2) frame:self.point2.frame];
    
    //Point1 透明度
    IFTTTAlphaAnimation *point1Alpha=[IFTTTAlphaAnimation animationWithView:self.point1];
    [self.animator addAnimation:point1Alpha];
    
    [point1Alpha addKeyframeForTime:timeForPage(1) alpha:1.0];
    [point1Alpha addKeyframeForTime:timeForPage(2) alpha:0.0];
    
    //Point2 透明度
    IFTTTAlphaAnimation *point2Alpha=[IFTTTAlphaAnimation animationWithView:self.point2];
    [self.animator addAnimation:point2Alpha];
    
    [point2Alpha addKeyframeForTime:timeForPage(1) alpha:0.0];
    [point2Alpha addKeyframeForTime:timeForPage(2) alpha:1.0];
    
    //Point3 平移
    IFTTTFrameAnimation *point3Frame=[IFTTTFrameAnimation animationWithView:self.point3];
    [self.animator addAnimation:point3Frame];
    
    [point3Frame addKeyframeForTime:timeForPage(2) frame:self.point2.frame];
    [point3Frame addKeyframeForTime:timeForPage(3) frame:self.point3.frame];
    
    //Point3 透明度
    IFTTTAlphaAnimation *point3Alpha=[IFTTTAlphaAnimation animationWithView:self.point3];
    [self.animator addAnimation:point3Alpha];
    
    [point3Alpha addKeyframeForTime:timeForPage(2) alpha:0.0];
    [point3Alpha addKeyframeForTime:timeForPage(3) alpha:1.0];
    
    //让圆点2跟随圆点3运动并淡出
    [point2Frame addKeyframeForTime:timeForPage(3) frame:self.point3.frame];
    [point2Alpha addKeyframeForTime:timeForPage(3) alpha:0.0];
    
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
