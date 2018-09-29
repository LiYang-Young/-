//
//  ViewController.m
//  手势解锁
//
//  Created by 李洋 on 2018/7/17.
//  Copyright © 2018年 com.appTest.app. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    LockView * view = [[LockView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50)];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
