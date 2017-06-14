//
//  ZA1ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/6/14.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ZA1ViewController.h"
#import "ZA1CollectionViewCell.h"
#import "ZA1SecondController.h"
#import "ZA1PositiveTransition.h"

@interface ZA1ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate>
@end

@implementation ZA1ViewController

static const CGFloat kMagin = 4. ;
#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad] ;
    //
    self.title = @"transition UINavigationControllerDelegate" ;
    self.collectionView = ({
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemWidth = (self.view.frame.size.width - kMagin) / 2;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        flowLayout.minimumLineSpacing = 4;
        flowLayout.minimumInteritemSpacing = 4;

        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout] ;
        collection.dataSource = self ;
        collection.delegate = self ;
        [self.view addSubview:collection] ;
        collection.backgroundColor = [UIColor whiteColor] ;
        [collection registerNib:[UINib nibWithNibName:@"ZA1CollectionViewCell" bundle:nil]
              forCellWithReuseIdentifier:@"ZA1CollectionViewCell"] ;
        collection ;
    }) ;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated] ;
    //
    self.navigationController.delegate = self ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"ZA1CollectionViewCell" forIndexPath:indexPath] ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZA1SecondController *secVC = [ZA1SecondController new] ;
    [self.navigationController pushViewController:secVC animated:YES] ;
}


#pragma mark - <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[ZA1SecondController class]]) {
        ZA1PositiveTransition *transition = [[ZA1PositiveTransition alloc] init] ;
        return transition ;
    }
    else {
        return nil ;
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
