//
//  ZA3SecViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA3SecViewController.h"
#import "PingReverseTransition.h"
#import "Masonry.h"

@interface ZA3SecViewController () <UINavigationControllerDelegate>
{
    UIPercentDrivenInteractiveTransition *percentTransition ;
}
@property (nonatomic,strong) UIButton *button ;

@end

@implementation ZA3SecViewController

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
//  Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.view.backgroundColor = [UIColor orangeColor] ;

//
    self.button = ({
        UIButton *bt = [UIButton new] ;
        bt.backgroundColor = [UIColor blackColor] ;
        bt.layer.cornerRadius = 20 ;
        [bt addTarget:self
               action:@selector(btAction:)
     forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40)) ;
            make.top.equalTo(self.view).offset(30) ;
            make.right.equalTo(self.view).offset(-30) ;
        }] ;
        bt ;
    }) ;

//
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self
                                                                                                 action:@selector(edgePan:)] ;
    edgeGes.edges = UIRectEdgeLeft ;
    [self.view addGestureRecognizer:edgeGes] ;

}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)btAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES] ;
}

#pragma mark -
- (void)edgePan:(UIPanGestureRecognizer *)recognizer
{
    CGFloat per = [recognizer translationInView:self.view].x / (self.view.bounds.size.width) ;
    per = MIN(1.0,(MAX(0.0, per))) ;
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        percentTransition = [[UIPercentDrivenInteractiveTransition alloc] init] ;
        [self.navigationController popViewControllerAnimated:YES] ;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        [percentTransition updateInteractiveTransition:per] ;
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        if (per > 0.3) {
            [percentTransition finishInteractiveTransition] ;
        }
        else {
            [percentTransition cancelInteractiveTransition] ;
        }
        percentTransition = nil ;
    }
}


#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop)
    {
        PingReverseTransition *pingInvert = [PingReverseTransition new];
        return pingInvert;
    }
    else{
        return nil;
    }
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
