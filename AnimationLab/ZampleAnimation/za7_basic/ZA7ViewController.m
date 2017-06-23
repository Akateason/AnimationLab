//
//  ZA7ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/22.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA7ViewController.h"
#import "Guide1.h"
#import "Guide2.h"
#import "Guide3.h"
#import "Guide4.h"
#import "StartMoveView.h"
#import "Masonry.h"

@interface ZA7ViewController () <StartMoveViewDelegate,UIScrollViewDelegate>
{
    int             m_pre           ;
    CGPoint         pos             ;
    NSMutableArray  *m_guidelist    ;
    UIPageControl   *m_pageCtrl     ;
    UIImageView     *m_imgView      ;
}
@property (nonatomic,strong) UIScrollView *scrollView ;
@end

@implementation ZA7ViewController

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    self.title = @"basic animation" ;
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    [self showScrollView] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    [self.navigationController setNavigationBarHidden:YES animated:NO] ;
}



#define PAGE_NUM        4
#define APPFRAME                [UIScreen mainScreen].bounds

#pragma mark --
#pragma mark - showScrollView
- (void)showScrollView
{
    self.scrollView = [[UIScrollView alloc] init] ;
    [self.view addSubview:self.scrollView] ;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view) ;
    }] ;
    Guide1 *guide1 = (Guide1 *)[[[NSBundle mainBundle] loadNibNamed:@"Guide1View" owner:self options:nil] lastObject] ;
    Guide2 *guide2 = (Guide2 *)[[[NSBundle mainBundle] loadNibNamed:@"Guide2View" owner:self options:nil] lastObject] ;
    Guide3 *guide3 = (Guide3 *)[[[NSBundle mainBundle] loadNibNamed:@"Guide3View" owner:self options:nil] lastObject] ;
    Guide4 *guide4 = (Guide4 *)[[[NSBundle mainBundle] loadNibNamed:@"Guide4View" owner:self options:nil] lastObject] ;
    
    m_guidelist = [@[guide1,guide2,guide3,guide4] mutableCopy] ;
    
    m_pre = 0 ;
    self.scrollView.delegate = self    ;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO ;
    self.scrollView.showsHorizontalScrollIndicator = NO ;
    self.scrollView.bounces = NO ;
    self.scrollView.contentSize = CGSizeMake(APPFRAME.size.width * PAGE_NUM, APPFRAME.size.height) ;
    self.scrollView.backgroundColor = [UIColor colorWithRed:108.0/255.0
                                               green:196.0/255.0
                                                blue:191.0/255.0
                                               alpha:1.0] ;
    
    int _x = 0 ;
    
    for (int i = 1; i <= PAGE_NUM; i++)
    {
        NSString *imgStr      = [NSString stringWithFormat:@"s_0%d",i]                       ;
        CGRect rect           = CGRectMake(_x, 0, APPFRAME.size.width, APPFRAME.size.height) ;
        BOOL  isShow          = (i == 4) ? YES : NO                                          ;
        BOOL  iscloud         = (i < 3) ? NO : YES                                           ;
        BOOL  isFire          = (i > 3) ? YES : NO                                           ;
        
        UIView *tempView = [m_guidelist objectAtIndex:i - 1] ;
        StartMoveView *startV = [[StartMoveView alloc] initWithFrame:rect
                                                       AndWithPicStr:imgStr
                                                   AndWithButtonShow:isShow
                                                        AndWithCloud:iscloud
                                                         AndWithFire:isFire
                                                       AndWithBgView:tempView]              ;
        
        startV.delegate       = self                                                        ;
        [self.scrollView addSubview:startV]                                                        ;
        _x += APPFRAME.size.width                                                           ;
        
    }
    
    m_pageCtrl = [[UIPageControl alloc] init] ;
    m_pageCtrl.numberOfPages = [m_guidelist count] ;
    m_pageCtrl.currentPage = 0 ;
    [self.view addSubview:m_pageCtrl] ;
    m_pageCtrl.center = CGPointMake(APPFRAME.size.width / 2, APPFRAME.size.height - 50) ;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int current = scrollView.contentOffset.x / APPFRAME.size.width;
    m_pageCtrl.currentPage = current ;
    
    m_pre = current ;
    NSLog(@"current,%d",current) ;
    
    switch (current)
    {
        case 0:
        {
            Guide1 *guide1 = m_guidelist[current] ;
            [guide1 startAnimate] ;
        }
            break;
        case 1:
        {
            Guide2 *guide2 = m_guidelist[current] ;
            [guide2 startAnimate] ;
        }
            break;
        case 2:
        {
            Guide3 *guide3 = m_guidelist[current] ;
            [guide3 startAnimate] ;
        }
            break;
        case 3:
        {
            Guide4 *guide4 = m_guidelist[current] ;
            [guide4 startAnimate] ;
        }
        default:
            break;
    }
}

#pragma mark --
#pragma mark - StartMoveViewDelegate <NSObject>
- (void)goHome
{
    [self.navigationController popViewControllerAnimated:YES] ;
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
