//
//  ZA6ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/22.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA6ViewController.h"

@interface ZA6ViewController ()

@end

@implementation ZA6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor] ;
    self.title = @"CAEmitterLayer" ;
    
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, -30);
    snowEmitter.emitterSize  = CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode  = kCAEmitterLayerOutline;
    
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.birthRate	= 1.0;
    snowflake.lifetime	= 120.0;
    snowflake.velocity	= -10;
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 2;
    snowflake.emissionRange = 0.5 * M_PI;
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents  = (id) [[UIImage imageNamed:@"snow"] CGImage];
    snowflake.color	= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.view.layer insertSublayer:snowEmitter atIndex:0];

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
