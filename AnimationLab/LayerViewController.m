//
//  LayerViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/23.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "LayerViewController.h"
#import "HomeCell.h"
#import <objc/runtime.h>


@interface LayerViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation LayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table.dataSource   = self ;
    self.table.delegate     = self ;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"] ;
    cell.textLabel.text = [NSString stringWithFormat:@"Zample%dController",(int)indexPath.row+1] ;
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