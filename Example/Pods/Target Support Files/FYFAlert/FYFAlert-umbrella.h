#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FYFAlert.h"
#import "FYFAlertConfig.h"
#import "FYFCustomAlertView.h"
#import "FYFPopView.h"
#import "FYFSystemAlertView.h"
#import "FYFToast.h"

FOUNDATION_EXPORT double FYFAlertVersionNumber;
FOUNDATION_EXPORT const unsigned char FYFAlertVersionString[];

