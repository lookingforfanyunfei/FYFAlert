//
//  FYFViewController.m
//  FYFAlert
//
//  Created by 786452470@qq.com on 08/10/2022.
//  Copyright (c) 2022 786452470@qq.com. All rights reserved.
//

#import "FYFViewController.h"
#import "FYFToastAlertViewController.h"

@interface FYFViewController ()

@end

@implementation FYFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *testAlertAndToastButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
    [testAlertAndToastButton setTitle:@"AlertAndToastAndPop" forState:UIControlStateNormal];
    [testAlertAndToastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testAlertAndToastButton addTarget:self action:@selector(testAlertAndToast) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testAlertAndToastButton];
}

- (void)testAlertAndToast {
    FYFToastAlertViewController *vc = [[FYFToastAlertViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
