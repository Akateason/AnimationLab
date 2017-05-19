//
//  Zample5Controller.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/18.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "Zample5Controller.h"
#import "Masonry.h"

@interface Zample5Controller ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation Zample5Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Hit Testing" ;
    
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
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:self.blueLayer];
}


/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get touch position relative to main view
    CGPoint point = [[touches anyObject] locationInView:self.view] ;
    
    //convert point to the white layer's coordinates
    point = [self.layerView.layer convertPoint:point
                                     fromLayer:self.view.layer] ;
    
    //get layer using containsPoint:
    if ([self.layerView.layer containsPoint:point])
    {
        //convert point to blueLayer’s coordinates
        point = [self.blueLayer convertPoint:point
                                   fromLayer:self.layerView.layer] ;
        
        if ([self.blueLayer containsPoint:point])
        {
            [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }
}
 */


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get touch position
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //get touched layer
    CALayer *layer = [self.layerView.layer hitTest:point];
    //get layer using hitTest
    if (layer == self.blueLayer)
    {
        [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    else if (layer == self.layerView.layer)
    {
        [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}



//注意当调用图层的-hitTest:方法时，测算的顺序严格依赖于图层树当中的图层顺序（和UIView处理事件类似）。之前提到的zPosition属性可以明显改变屏幕上图层的顺序，但不能改变事件传递的顺序。+
//
//这意味着如果改变了图层的z轴顺序，你会发现将不能够检测到最前方的视图点击事件，这是因为被另一个图层遮盖住了，虽然它的zPosition值较小，但是在图层树中的顺序靠前。我们将在第五章详细讨论这个问题。







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
