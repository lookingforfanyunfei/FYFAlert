//
//  FYFToastAlertViewController.m
//  FYFAlert_Example
//
//  Created by 范云飞 on 2022/8/10.
//  Copyright © 2022 786452470@qq.com. All rights reserved.
//

#import "FYFToastAlertViewController.h"
#import <FYFAlert/FYFAlertConfig.h>
#import <FYFAlert/FYFCustomAlertView.h>
#import <FYFAlert/FYFSystemAlertView.h>
#import <FYFAlert/FYFToast.h>
#import <FYFAlert/FYFPopView.h>
#import <FYFDefines/FYFViewDefine.h>

@interface FYFToastAlertViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <NSArray <NSString *>*>*dataArray;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) FYFPopView *popviewFade;

@property (nonatomic, strong) UIView *customeView;

@end

@implementation FYFToastAlertViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideAllToasts];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"iOS Alert";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [FYFAlertViewConfig shareConfig].contentWith = 400;
    [FYFAlertViewConfig shareConfig].messageColor = [UIColor redColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"hideToasts" style:UIBarButtonItemStylePlain target:self action:@selector(hideAllToasts)];
    
    self.dataArray = @[@[@"systemAlert",
                         @"singleSystemAlert",
                         @"systemSheetAlert"],
                       
                       @[@"customAlert"],
                       
                       @[@"toast",
                         @"autoHiddenToast"],
                       
                       @[@"loading"],
                       
                       @[@"animationModeFade",
                         @"animationModeFromTop",
                         @"animationModeFromBottom",
                         @"animationModeSpringFromTop",
                         @"animationModeSpringFromBottom",
                         @"animationModeScale",
                         @"animationModeNone",
                         @"animationModeTextFields"]];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"SystemAlert";
    } else if (section == 1) {
        return @"CustomAlert";
    } else if (section == 2) {
        return @"Toast";
    } else if (section == 3) {
        return @"Loading";
    } else {
        return @"PopView";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self systemAlert];
        } else if (indexPath.row == 1) {
            [self singleSystemAlert];
        } else if (indexPath.row == 2) {
            [self systemSheetAlert];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self customAlert];
        } else if (indexPath.row == 1) {
            [self singleCustomAlert];
        }
    } else if ((indexPath.section == 2)) {
        if (indexPath.row == 0) {
            [self toast];
        } else if (indexPath.row == 1) {
            [self autoHiddenToast];
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [self loading];
        }
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            [self popFade];
        } else if (indexPath.row == 1) {
            [self popTop];
        } else if (indexPath.row == 2) {
            [self popBottom];
        } else if (indexPath.row == 3) {
            [self popTopSpring];
        } else if (indexPath.row == 4) {
            [self popBottomSpring];
        } else if (indexPath.row == 5) {
            [self popScale];
        } else if (indexPath.row == 6) {
            [self popNone];
        } else if (indexPath.row == 7) {
            [self popTextFieldView];
        }
    }
    
}

- (void)customAlert {
//    [FYFCustomAlertView fyf_customAlertInView:self.view title:@"自定义alert自定义alert自定义alert自定义alert自定义alert" message:@"自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义haha" cancelTitle:@"取消" confirmTitle:@"确定" cancelHandler:^{
//
//    } confirmHandler:^{
//
//    }];
    
    
//    FYFCustomAlertView *customAlert = [[FYFCustomAlertView alloc] initWithParentView:self.view title:@"自定义alert自定义alert自定义alert自定义alert自定义alert" message:@"自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义haha" cancelTitle:@"ddddddd" confirmTitle:@"确定"];
//    customAlert.confirmHandler = ^{
//
//    };
//
//    customAlert.cancelHandler = ^{
//
//    };
//
//    [customAlert show];
    
    NSMutableString *message = @"本页自选有".mutableCopy;
    NSMutableString *markString = [NSMutableString string];
    message = [message substringWithRange:NSMakeRange(0, message.length-1)].mutableCopy;

    [message appendFormat:@"个合约可替换为新主力合约，确认全部替换？"];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;

    NSMutableAttributedString *messageAttributedString = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAttributedString addAttribute:NSParagraphStyleAttributeName
                            value:paragraphStyle
                            range:NSMakeRange(0, message.length)];
    [messageAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, message.length)];
    [messageAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, markString.length)];
    
    FYFCustomAlertView *customAlert = [[FYFCustomAlertView alloc] initWithParentView:self.view title:@"自定义alert自定义alert自定义alert自定义alert自定义alert" messageAttributedString:messageAttributedString cancelTitle:@"ddddddd" confirmTitle:@"确定"];
    customAlert.confirmHandler = ^{
        
    };
    
    customAlert.cancelHandler = ^{
        
    };
    
    [customAlert show];
    
}

- (void)singleCustomAlert {
    [FYFCustomAlertView fyf_customAlertInView:self.view title:@"单个按钮alert"  message:@"单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert单个按钮alert" confirmTitle:@"确定" confirmHandler:^{
        
    }];
    
}

- (void)systemAlert {
    [FYFSystemAlertView fyf_systemAlertInVc:self title:@"系统alert" message:@"系统内容系统内容系统内容系统内容系统内容系统内容系统内容系统内容" cancleButtonTitle:@"取消" confirmButtonTitle:@"确定" cancelHandler:^{
        
    } confirmHandler:^{
        
    }];
}

- (void)systemSheetAlert {
    [FYFSystemAlertView fyf_systemAlertInVc:self title:@"系统sheetAlert" message:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:@[@"相册",@"拍照",@"录音"] handler:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            NSLog(@"取消");
        }
        if (buttonIndex == 1) {
            NSLog(@"确定");
        }
        if (buttonIndex == 2) {
            NSLog(@"相册");
        }
        if (buttonIndex == 3) {
            NSLog(@"拍照");
        }
        if (buttonIndex == 4) {
            NSLog(@"录音");
        }
    }];
}

- (void)singleSystemAlert {
    [FYFSystemAlertView fyf_systemAlertInVc:self title:@"singleSystemAlert" message:@"单个系统alert单个系统alert单个系统alert单个系统alert单个系统alert单个系统alert单个系统alert单个系统alert单个系统alert单个系统alert单个系统alert" confirmButtonTitle:@"确定" confirmHandler:^{
        
    }];
}

- (void)autoHiddenToast {
    [[FYFToast toast] fyf_showToastAutoHidden:@"测试自动隐藏toast,测试自动隐藏toast,测试自动隐藏toast"];
    [[FYFToast toast] fyf_showToastAutoHidden:@"测试自动隐藏toast,测试自动隐藏toast,测试自动隐藏toast"];
    [[FYFToast toast] fyf_showToastAutoHidden:@"测试自动隐藏toast,测试自动隐藏toast,测试自动隐藏toast"];
    [[FYFToast toast] fyf_showToastAutoHidden:@"测试自动隐藏toast,测试自动隐藏toast,测试自动隐藏toast"];
    [[FYFToast toast] fyf_showToastAutoHidden:@"测试自动隐藏toast,测试自动隐藏toast,测试自动隐藏toast"];
}

- (void)toast {
    [[FYFToast toast] fyf_showToast:@"隐藏指定view上的toast隐藏指定view上的toast隐藏指定view上的toast隐藏指定view上的toast隐藏指定view上的toast隐藏指定view上的toast隐藏指定view上的toast隐藏指定view上的toast隐藏指定view上的toast隐藏指定view上的toast隐藏指定view上的toast" inView:self.view hiddenAfterSeconds:100];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FYFToast toast] fyf_hiddenToastInView:self.view];
    });
}

- (void)loading {
    [[FYFToast toast] fyf_showLoadingWithTitle:@"加载中....." inView:self.view];
    [self loadData:^(BOOL isSuccess) {
//        [FYFAlert fyf_hiddenAllTips];
        [[FYFToast toast] fyf_showToastAutoHidden:@"完成"];
    }];
}


- (void)loadData:(void(^)(BOOL isSuccess))completion {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10000; i++) {
            NSLog(@"%d",i);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(YES);
            }
        });
    });
}

- (void)popFade {
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor whiteColor];
//    CGFloat width = 300;
//    CGFloat height = 400;
//    CGFloat x = 40;
//    CGFloat y = (FYFScreenHeight - 400)/2;
//
//    UIButton *buttong = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
//    buttong.backgroundColor = [UIColor blueColor];
//    [buttong addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:buttong];
//
//    view.frame = CGRectMake(x, y, width,height);
//    view.layer.cornerRadius = 10;
//    view.layer.masksToBounds = YES;
//    _popviewFade = [FYFPopView initWithCustomView:self.customeView parentView:nil animationMode:FYFAnimationModeFade];
//    _popviewFade.xAxisOffset = -40;
    [self.popviewFade pop];
}

- (FYFPopView *)popviewFade {
    if (!_popviewFade) {
        _popviewFade = [FYFPopView initWithCustomView:self.customeView parentView:nil animationMode:FYFAnimationModeFade];
        _popviewFade.xAxisOffset = -40;
    }
    return _popviewFade;
}

- (UIView *)customeView {
    if (!_customeView) {
        _customeView = [[UIView alloc] init];
        _customeView.backgroundColor = [UIColor whiteColor];
        CGFloat width = 300;
        CGFloat height = 400;
        CGFloat x = 40;
        CGFloat y = (FYFScreenHeight - 400)/2;
        
        UIButton *buttong = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
        buttong.backgroundColor = [UIColor blueColor];
        [buttong addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_customeView addSubview:buttong];
        
        _customeView.frame = CGRectMake(x, y, width,height);
        _customeView.layer.cornerRadius = 10;
        _customeView.layer.masksToBounds = YES;
    }
    return _customeView;
}

- (void)dismiss {
    if (_popviewFade) {
        [_popviewFade dismiss];
    }
}

- (void)popTop {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake((FYFScreenWidth - 300)/2, 0, 300 ,300);
    FYFPopView *popView = [FYFPopView initWithCustomView:view parentView:self.view animationMode:FYFAnimationModeFromTop];
    popView.animationDuration = 0.25;
    
    UIButton *buttong = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    buttong.backgroundColor = [UIColor blueColor];
    [buttong addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttong];
    
    [popView pop];
}

- (void)popBottom {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blueColor];
    view.frame = CGRectMake(0, FYFScreenHeight - 400, FYFScreenWidth,400);
    FYFPopView *popView = [FYFPopView initWithCustomView:view parentView:self.view animationMode:FYFAnimationModeFromBottom];
    popView.animationDuration = 0.25;
    popView.maskAlpha = 0.5;
    
    UIButton *buttong = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    buttong.backgroundColor = [UIColor redColor];
    [buttong addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttong];
    
    [popView pop];
}

- (void)popTopSpring {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, FYFScreenWidth,400-FYFNavigationBarFullHeight);
    FYFPopView *popView = [FYFPopView initWithCustomView:view parentView:self.view animationMode:FYFAnimationModeSpringFromTop];
    popView.animationDuration = 0.25;
    
    UIButton *buttong = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    buttong.backgroundColor = [UIColor blueColor];
    [buttong addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttong];
    
    [popView pop];
}

- (void)popBottomSpring {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blueColor];
    view.frame = CGRectMake(0, FYFScreenHeight - 400, FYFScreenWidth,400);
    FYFPopView *popView = [FYFPopView initWithCustomView:view parentView:self.view animationMode:FYFAnimationModeSpringFromBottom];
    popView.animationDuration = 0.25;
    
    UIButton *buttong = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    buttong.backgroundColor = [UIColor redColor];
    [buttong addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttong];
    
    [popView pop];
}

- (void)popScale {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat width = FYFScreenWidth - 80;
    CGFloat height = 400;
    CGFloat x = 40;
    CGFloat y = 0;
    
    view.frame = CGRectMake(x, y, width,height);
    FYFPopView *popview = [FYFPopView initWithCustomView:view parentView:nil animationMode:FYFAnimationModeScale];
    popview.yAxisOffset = -100;
    popview.rectCorners = UIRectCornerTopLeft | UIRectCornerTopRight;
    popview.cornerRadius = 6;
    
    UIButton *buttong = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    buttong.backgroundColor = [UIColor redColor];
    [buttong addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttong];
    
    [popview pop];
    

//    UIView *view1 = [[UIView alloc] init];
//    view1.backgroundColor = [UIColor whiteColor];
//    CGFloat width1 = FYFScreenWidth - 80;
//    CGFloat height1 = 200;
//    CGFloat x1 = 40;
//    CGFloat y1 = 200;
//
//    view1.frame = CGRectMake(x1, y1, width1,height1);
//    view1.layer.cornerRadius = 10;
//    view1.layer.masksToBounds = YES;
//    FYFPopView *popview1 = [FYFPopView initWithCustomView:view1 parentView:nil animationMode:FYFAnimationModeScale];
//    [popview1 pop];
}

- (void)popNone {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat width = FYFScreenWidth - 80;
    CGFloat height = 400;
    CGFloat x = 40;
    CGFloat y = 0;
    
    view.frame = CGRectMake(x, y, width,height);
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    FYFPopView *popview = [FYFPopView initWithCustomView:view parentView:nil animationMode:FYFAnimationModeNone];
    popview.yAxisOffset = -100;
    
    UIButton *buttong = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    buttong.backgroundColor = [UIColor redColor];
    [buttong addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttong];
    
    [popview pop];
}

- (void)popTextFieldView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat width = FYFScreenWidth - 80;
    CGFloat height = 300;
    CGFloat x = 40;
    CGFloat y = 400;
    
    view.frame = CGRectMake(x, y, width,height);
    FYFPopView *popview = [FYFPopView initWithCustomView:view parentView:nil animationMode:FYFAnimationModeScale];
    popview.rectCorners = UIRectCornerAllCorners;
    popview.cornerRadius = 6;
    popview.avoidKeyboardSpace = 30;
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    textfield.backgroundColor = [UIColor redColor];
    [view addSubview:textfield];
    
    [popview pop];
    
//    UIView *view1 = [[UIView alloc] init];
//    view1.backgroundColor = [UIColor whiteColor];
//    CGFloat width1 = FYFScreenWidth - 80;
//    CGFloat height1 = 300;
//    CGFloat x1 = 40;
//    CGFloat y1 = 0;
//
//    view1.frame = CGRectMake(x1, y1, width1,height1);
//
//    FYFPopView *popview1 = [FYFPopView initWithCustomView:view1 parentView:nil animationMode:FYFAnimationModeScale];
//    popview1.yAxisOffset = 0;
//    popview1.rectCorners = UIRectCornerAllCorners;
//    popview1.cornerRadius = 6;
//    popview1.avoidKeyboardSpace = 30;
//
//    UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
//    textfield1.backgroundColor = [UIColor redColor];
//    [view1 addSubview:textfield1];
//
//    [popview1 pop];
}

- (void)hideAllToasts {
    [[FYFToast toast] fyf_hiddenAllToasts];
}

@end
