//
//  Zample21Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/6.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "Zample21Controller.h"
#import "DrawView.h"
#import "DrawShapelayerView.h"

@interface Zample21Controller ()

@end

@implementation Zample21Controller

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;

    //1. coregraphic效率低下
//    DrawView *drawview = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)] ;
//    drawview.center = self.view.center ;
//    drawview.backgroundColor = [UIColor lightGrayColor] ;
    
    //2. cashapelayer
    DrawShapelayerView *drawview = [[DrawShapelayerView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)] ;
    drawview.center = self.view.center ;
    drawview.backgroundColor = [UIColor lightGrayColor] ;
    [self.view addSubview:drawview] ;
    
}

- (void)didReceiveMemoryWarning
{
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
