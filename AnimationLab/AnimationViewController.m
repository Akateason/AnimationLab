//
//  AnimationViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/23.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "AnimationViewController.h"
#import "HomeCell.h"
#import <objc/runtime.h>

@interface AnimationViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table.dataSource   = self ;
    self.table.delegate     = self ;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    [self.navigationController setNavigationBarHidden:NO animated:NO] ;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated] ;
//    [self.navigationController setNavigationBarHidden:NO animated:NO] ;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"] ;
    cell.textLabel.text = [NSString stringWithFormat:@"ZA%dViewController",(int)indexPath.row+1] ;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = (HomeCell *)[tableView cellForRowAtIndexPath:indexPath] ;
    NSString *title = cell.textLabel.text ;
    Class cls = objc_getRequiredClass([title UTF8String]) ;
    UIViewController *ctrller = [[cls alloc] init] ;
    ctrller.title = title ;
    [self.navigationController pushViewController:ctrller animated:YES] ;
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
