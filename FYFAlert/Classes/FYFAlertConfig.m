//
//  FYFAlertConfig.m
//  FYFAlert
//
//  Created by 范云飞 on 2022/6/1.
//

#import "FYFAlertConfig.h"
#import <FYFCategory/FYFCategory.h>
#import <FYFDefines/FYFColorDefine.h>
#import <FYFDefines/FYFViewDefine.h>

@interface FYFAlertViewConfig ()
/// 弹框高度，默认FYFViewScale(224)，是根据内容动态计算出来的，无需设置
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation FYFAlertViewConfig

+ (FYFAlertViewConfig *)shareConfig {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupconfig];
    }
    return self;
}


- (void)setupconfig {
    self.titleFont = [UIFont fyf_pingFangSCMediumSize:18];
    self.titleColor = FYFColorFromRGB(0x000000);
    self.titleTopMargin = FYFViewScale(24);
    self.titleLeftRightMargin = FYFViewScale(12);
    
    self.messageFont = [UIFont fyf_pingFangSCRegularSize:14];
    self.messageColor = FYFColorFromRGB(0x000000);
    self.messageTopMargin = FYFViewScale(16);
    self.messageLeftRightMargin = FYFViewScale(24);
    self.messageBottomMargin = FYFViewScale(20);
    
    self.cancelButtonFont = [UIFont fyf_pingFangSCRegularSize:16];
    self.cancelButtonTitleColor = FYFColorFromRGB(0x000000);
    
    self.confirmButtonFont = [UIFont fyf_pingFangSCRegularSize:16];
    self.confirmButtonTitleColor = FYFColorFromRGB(0x266EFF);
    
    self.buttonHeight = FYFViewScale(44);
    
    self.contentWith = FYFDeviceWidth - 2*FYFViewScale(48);
    self.contentHeight = FYFViewScale(224);
    
    self.radius = 4;
    
    self.alpha = 0.5;
}


@end

@implementation FYFAlertConfig

@end
