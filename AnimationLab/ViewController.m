//
//  ViewController.m
//  AnimationLab
//
//  Created by teason23 on 2017/5/17.
//  Copyright © 2017年 teaason. All rights reserved.
//

#import "ViewController.h"
#import "HomeCell.h"
#import <objc/runtime.h>

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table ;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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


@end
