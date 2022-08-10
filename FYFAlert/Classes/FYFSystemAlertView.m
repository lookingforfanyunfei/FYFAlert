//
//  FYFSystemAlertView.m
//  FYFAlert
//
//  Created by 范云飞 on 2021/9/9.
//

#import "FYFSystemAlertView.h"
#import <FYFDefines/FYFColorDefine.h>

static NSInteger const FYFAlertActionCancelIndex = 0;
static NSInteger const FYFAlertActionDestructiveIndex = 1;
static NSInteger const FYFAlertActionFirstOtherIndex = 2;

@interface FYFSystemAlertView ()

@end

@implementation FYFSystemAlertView
+ (void)fyf_systemAlertInVc:(UIViewController * _Nullable )rootController title:(NSString * _Nullable )title message:(NSString * _Nullable )message confirmButtonTitle:(NSString * _Nullable )confirmButtonTitle confirmHandler:(void(^ _Nullable )(void))confirmHandler {
    [FYFSystemAlertView fyf_systemAlertInVc:rootController title:title message:message cancleButtonTitle:nil confirmButtonTitle:confirmButtonTitle cancelHandler:nil confirmHandler:confirmHandler];
}

+ (void)fyf_systemAlertInVc:(UIViewController * _Nullable )rootController title:(NSString * _Nullable )title message:(NSString * _Nullable )message cancleButtonTitle:(NSString * _Nullable )cancleButtonTitle confirmButtonTitle:(NSString * _Nullable )confirmButtonTitle cancelHandler:(void(^ _Nullable )(void))cancelHandler confirmHandler:(void(^ _Nullable )(void))confirmHandler {
    [FYFSystemAlertView fyf_systemAlertInVc:rootController title:title message:message messageFontSize:14 cancleButtonTitle:cancleButtonTitle cancleButtonTitleColor:nil confirmButtonTitle:confirmButtonTitle confirmButtonTitleColor:nil cancelHandler:cancelHandler confirmHandler:confirmHandler];
}

+ (void)fyf_systemAlertInVc:(UIViewController * _Nullable )rootController title:(NSString * _Nullable )title message:(NSString * _Nullable )message messageFontSize:(CGFloat)messageFontSize cancleButtonTitle:(NSString * _Nullable )cancleButtonTitle cancleButtonTitleColor:(UIColor *_Nullable)cancleButtonTitleColor confirmButtonTitle:(NSString * _Nullable )confirmButtonTitle confirmButtonTitleColor:(UIColor *_Nullable)confirmButtonTitleColor cancelHandler:(void(^ _Nullable )(void))cancelHandler confirmHandler:(void(^ _Nullable )(void))confirmHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancleButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancleButtonTitle.length > 0 ? cancleButtonTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelHandler) {
                cancelHandler();
            }
        }];
        if (cancleButtonTitleColor) {
            [cancelAction setValue:cancleButtonTitleColor forKey:@"_titleTextColor"];
        } else {
            [cancelAction setValue:FYFColorFromRGB(0x2c2c2c) forKey:@"_titleTextColor"];
        }
        [alertController addAction:cancelAction];
    }
    if (confirmButtonTitle) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmButtonTitle.length > 0 ? confirmButtonTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmHandler) {
                confirmHandler();
            }
        }];
        if (confirmButtonTitleColor) {
            [okAction setValue:confirmButtonTitleColor forKey:@"_titleTextColor"];
        }
        [alertController addAction:okAction];
    }
    
    if (message.length > 0) {
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:messageFontSize] range:NSMakeRange(0, message.length)];
        [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    }

    [rootController presentViewController:alertController animated:YES completion:^{
        
    }];
}

+ (void)fyf_systemAlertInVc:(UIViewController * _Nullable )rootController title:(NSString * _Nullable )title message:(NSString *_Nullable)message cancelButtonTitle:(NSString *_Nullable )cancelButtonTitle destructiveButtonTitle:(NSString * _Nullable)destructiveButtonTitle otherButtonTitles:(NSArray * _Nullable)otherButtonTitles handler:(void(^ _Nullable)(UIAlertController * __nonnull alertController, UIAlertAction * __nonnull action, NSInteger buttonIndex))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak UIAlertController *controller = alertController;
    
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action){
                                                                 if (handler) {
                                                                     handler(controller, action, FYFAlertActionCancelIndex);
                                                                 }
                                                             }];
        [controller addAction:cancelAction];
    }
    
    if (destructiveButtonTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                                    style:UIAlertActionStyleDestructive
                                                                  handler:^(UIAlertAction *action){
                                                                      if (handler) {
                                                                          handler(controller, action, FYFAlertActionDestructiveIndex);
                                                                      }
                                                                  }];
        [controller addAction:destructiveAction];
    }
    
    for (NSUInteger i = 0; i < otherButtonTitles.count; i++) {
        NSString *otherButtonTitle = otherButtonTitles[i];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action){
                                                                if (handler) {
                                                                    handler(controller, action, FYFAlertActionFirstOtherIndex + i);
                                                                }
                                                            }];
        [controller addAction:otherAction];
    }
    [rootController presentViewController:alertController animated:YES completion:^{
        
    }];
}

@end

