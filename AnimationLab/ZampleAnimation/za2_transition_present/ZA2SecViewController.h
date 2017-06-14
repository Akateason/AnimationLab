//
//  ZA2SecViewController.h
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZA2SecViewControllerDelegate <NSObject>
@required
- (void)z2willDismiss:(id)controller ;
@end

@interface ZA2SecViewController : UIViewController
@property (nonatomic,weak) id <ZA2SecViewControllerDelegate> delegate ;
@end
