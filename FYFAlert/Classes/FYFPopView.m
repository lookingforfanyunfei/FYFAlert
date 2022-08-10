//
//  FYFPopView.m
//  FYFAlert
//
//  Created by 范云飞 on 2021/9/9.
//

#import "FYFPopView.h"
#import <FYFDefines/FYFViewDefine.h>
#import <FYFCategory/UIView+FYFExtension.h>

@interface KSDismissView : UIView

@end

@implementation KSDismissView

@end

@interface FYFPopView ()
/// 弹框容器， 默认keyWindow
@property (nonatomic, weak, readwrite) UIView *parentView;
/// 自定义view
@property (nonatomic, strong, readwrite) UIView *customView;
/// 遮罩
@property (nonatomic, strong, readwrite) KSDismissView *dismissView;
/// pop动画弹窗样式 默认FYFAnimationModeFade
@property (nonatomic, assign, readwrite) FYFAnimationMode animationMode;
/// 记录customView的frame
@property (nonatomic, assign, readwrite) CGRect customViewFrame;
/// 是否弹出键盘
@property (nonatomic, assign,readwrite) BOOL isShowKeyboard;
/// 弹出键盘的高度
@property (nonatomic, assign,readwrite) CGFloat keyboardY;

@end

@implementation FYFPopView
#pragma mark - Setters
- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
    _animationDuration = animationDuration;
}

- (void)setDelayDuration:(NSTimeInterval)delayDuration {
    _delayDuration = delayDuration;
}

- (void)setXAxisOffset:(CGFloat)xAxisOffset {
    _xAxisOffset = xAxisOffset;
    [self updateCustomViewConstraints];
}

- (void)setYAxisOffset:(CGFloat)yAxisOffset {
    _yAxisOffset = yAxisOffset;
    [self updateCustomViewConstraints];
}

- (void)setMaskAlpha:(CGFloat)maskAlpha {
    _maskAlpha = maskAlpha;
}

- (void)setRectCorners:(UIRectCorner)rectCorners {
    _rectCorners = rectCorners;
    [self setCustomViewCorners];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setCustomViewCorners];
}

- (void)setCustomViewCorners {
    BOOL isSetCorner = NO;
    if (self.rectCorners & UIRectCornerTopLeft ||
        self.rectCorners & UIRectCornerTopRight ||
        self.rectCorners & UIRectCornerBottomLeft ||
        self.rectCorners & UIRectCornerBottomRight ||
        self.rectCorners & UIRectCornerAllCorners) {
        isSetCorner = YES;
    }
   
    if (isSetCorner && self.cornerRadius > 0) {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.customView.bounds byRoundingCorners:self.rectCorners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
        CAShapeLayer * layer = [[CAShapeLayer alloc]init];
        layer.frame = self.customView.bounds;
        layer.path = path.CGPath;
        self.customView.layer.mask = layer;
    }
}

#pragma mark - Init
+ (instancetype)initWithCustomView:(UIView * _Nullable)customView parentView:(UIView *_Nullable)parentView animationMode:(FYFAnimationMode)animationMode {
    if (animationMode < FYFAnimationModeNone || animationMode > FYFAnimationModeSpringFromBottom) {
        NSLog(@"暂不支持该类型动画");
        return nil;
    }
    if (!customView) {
        return nil;
    }
    if (![parentView isKindOfClass:[UIView class]] && parentView) {
        return nil;
    }

    CGRect popViewFrame = CGRectZero;
    if (parentView) {
        popViewFrame = parentView.bounds;
    } else {
        popViewFrame = CGRectMake(0, 0, FYFScreenWidth, FYFScreenHeight);
    }
    
    FYFPopView *popView = [[FYFPopView alloc] initWithFrame:popViewFrame];
    popView.backgroundColor = [UIColor clearColor];
    popView.parentView = parentView ? parentView : [UIApplication sharedApplication].keyWindow;
    popView.customView = customView;
    popView.dismissView = [[KSDismissView alloc] initWithFrame:popView.bounds];
    popView.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    popView.animationMode = animationMode;
    
    [popView addSubview:popView.dismissView];
    [popView addSubview:customView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:popView action:@selector(tapDismissView:)];
    [popView.dismissView addGestureRecognizer:tap];
    
    /// 键盘将要显示
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    /// 键盘显示完毕
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    /// 键盘将要收起
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    /// 键盘收起完毕
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    /// 屏幕发生旋转
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    return popView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _animationMode = FYFAnimationModeFade;
        
        _isObserverScreenRotation = YES;
        _dismissWhenClickMaskView = YES;
        
        _animationDuration = 0.3;
        _delayDuration = 0.1;
        _maskAlpha = 0.5;
        
        _xAxisOffset = 0.0;
        _yAxisOffset = 0.0;
        
        _rectCorners = UIRectCornerAllCorners;
        _cornerRadius = 6.0;
        
        _isAvoidKeyboard = YES;
        _avoidKeyboardSpace = 30.0;
        
        _isShowKeyboard = NO;
    }
    return self;
}

#pragma mark - Pop
- (BOOL)isPoping {
    return [self.superview.subviews containsObject:self];
}

- (void)pop {
    [self popWithAnimationMode:self.animationMode duration:self.animationDuration];
}

- (void)popWithAnimationMode:(FYFAnimationMode)animationMode duration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    if (weakSelf.parentView) {
        [weakSelf.parentView addSubview:weakSelf];
    }
    
    self.customViewFrame = self.customView.frame;
    
    if (animationMode == FYFAnimationModeNone) {
        self.dismissView.alpha = 0.0f;
        self.customView.alpha = 0.0f;
        [UIView animateWithDuration:0.1 animations:^{
            self.dismissView.alpha = self.maskAlpha;
            self.customView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            if (self.popHandler) {
                self.popHandler();
            }
        }];
    } else if (animationMode == FYFAnimationModeFade) {
        self.dismissView.alpha = 0.0f;
        self.customView.alpha = 0.0f;
        [UIView animateWithDuration:duration animations:^{
            self.dismissView.alpha = self.maskAlpha;
            self.customView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            if (self.popHandler) {
                self.popHandler();
            }
        }];
    } else {
        self.dismissView.alpha = 0.0f;
        self.customView.alpha = 0.0f;
        [UIView animateWithDuration:duration animations:^{
            self.dismissView.alpha = self.maskAlpha;
            self.customView.alpha = 1.0f;
        }];
        
        [self handlePopWithAnimationMode:animationMode duration:duration];
    }
}

- (void)handlePopWithAnimationMode:(FYFAnimationMode)animationMode duration:(NSTimeInterval)duration {
    switch (animationMode) {
        case FYFAnimationModeScale:
        {
            self.customView.layer.transform = CATransform3DMakeScale(0.8f, 0.8f, 1.0f);
            [UIView animateWithDuration:duration delay:self.delayDuration options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.customView.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {
                
                if (self.popHandler) {
                    self.popHandler();
                }
            }];
        }
            break;
        case FYFAnimationModeFromTop:
        case FYFAnimationModeFromBottom:
        {
            CGPoint startPosition = self.customView.layer.position;
            if (animationMode == FYFAnimationModeFromTop) {
                self.customView.layer.position = CGPointMake(startPosition.x, -self.customView.fyf_height*0.5);;
            } else if (animationMode == FYFAnimationModeFromBottom) {
                self.customView.layer.position = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + self.customView.fyf_height*0.5);
            }
            
            [UIView animateWithDuration:duration delay:self.delayDuration options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.customView.layer.position = startPosition;
            } completion:^(BOOL finished) {
                
                if (self.popHandler) {
                    self.popHandler();
                }
            }];
        }
            break;
        case FYFAnimationModeSpringFromTop:
        case FYFAnimationModeSpringFromBottom:
        {
            CGPoint startPosition = self.customView.layer.position;
            if (animationMode == FYFAnimationModeSpringFromTop) {
                self.customView.layer.position = CGPointMake(startPosition.x, -self.customView.fyf_height*0.5);
            } else if (animationMode == FYFAnimationModeSpringFromBottom) {
                self.customView.layer.position = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + self.customView.fyf_height*0.5);
            }
            
            CGFloat damping = 1.0;
            if (animationMode == FYFAnimationModeSpringFromTop || animationMode == FYFAnimationModeSpringFromBottom) {
                damping = 0.65;
            }
            
            [UIView animateWithDuration:duration delay:self.delayDuration usingSpringWithDamping:damping initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.customView.layer.position = startPosition;
            } completion:^(BOOL finished) {
                
                if (self.popHandler) {
                    self.popHandler();
                }
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Dismiss
- (void)dismiss {
    [self dismissWithAnimationMode:self.animationMode duration:self.animationDuration];
}

- (void)dismissWithAnimationMode:(FYFAnimationMode)animationMode duration:(NSTimeInterval)duration  {
    if (animationMode == FYFAnimationModeNone) {
        [UIView animateWithDuration:0.1 animations:^{
            self.dismissView.alpha = 0.0f;
            self.customView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
            if (self.dismissHandler) {
                self.dismissHandler();
            }
            
        }];
    } else if (animationMode == FYFAnimationModeFade) {
        [UIView animateWithDuration:duration animations:^{
            self.dismissView.alpha = 0.0f;
            self.customView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
            if (self.dismissHandler) {
                self.dismissHandler();
            }
            
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            self.dismissView.alpha = 0.0f;
            self.customView.alpha = 0.0f;
        }];
        
        [self handleDismissWithAnimationMode:animationMode duration:duration];
    }
}

- (void)handleDismissWithAnimationMode:(FYFAnimationMode)animationMode duration:(NSTimeInterval)duration {
    switch (animationMode) {
        case FYFAnimationModeScale:
        {
            [UIView animateWithDuration:duration delay:self.delayDuration options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.customView.layer.transform = CATransform3DMakeScale(0.6f, 0.6f, 1.0f);
                self.customView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                
                if (self.dismissHandler) {
                    self.dismissHandler();
                }
                
            }];
        }
            break;
        case FYFAnimationModeFromTop:
        case FYFAnimationModeFromBottom:
        case FYFAnimationModeSpringFromTop:
        case FYFAnimationModeSpringFromBottom:
        {
            CGPoint startPosition = self.customView.layer.position;
            CGPoint endPosition = self.customView.layer.position;
            if (animationMode == FYFAnimationModeFromTop || animationMode == FYFAnimationModeSpringFromTop) {
                endPosition = CGPointMake(startPosition.x, -(self.customView.fyf_height*0.5));
            } else if (animationMode == FYFAnimationModeFromBottom || animationMode == FYFAnimationModeSpringFromBottom) {
                endPosition = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + self.customView.fyf_height*0.5);
            } else {
                endPosition = CGPointMake(CGRectGetMaxX(self.frame) + self.customView.fyf_width*0.5, startPosition.y);
            }
            
            [UIView animateWithDuration:duration delay:self.delayDuration usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.customView.layer.position = endPosition;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                self.customView.frame = self.customViewFrame;
                
                if (self.dismissHandler) {
                    self.dismissHandler();
                }
                
            }];
        }
            break;
        default:
            [UIView animateWithDuration:duration animations:^{
                [self removeFromSuperview];
                self.customView.frame = self.customViewFrame;
                
                if (self.dismissHandler) {
                    self.dismissHandler();
                }
                
            }];
            break;
    }
}

- (void)tapDismissView:(UIGestureRecognizer *)gesture {
    if (!self.dismissWhenClickMaskView) {
        return;
    }
    
    [self dismiss];
}

#pragma mark - Keyboard
- (void)keyboardWillShow:(NSNotification *)notification {
    self.isShowKeyboard = YES;
      
    if (!self.isAvoidKeyboard) {
        return;
    }
    self.isAvoidKeyboard = YES;
    
    CGFloat customViewMaxY = self.customView.fyf_bottom + self.avoidKeyboardSpace;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardMaxY = keyboardEndFrame.origin.y;
    CGFloat avoidKeyboardOffset = customViewMaxY - keyboardMaxY;
    self.keyboardY = keyboardEndFrame.origin.y;
    //键盘遮挡到弹窗
    if ((keyboardMaxY < customViewMaxY) || ((self.customViewFrame.origin.y + self.customView.fyf_height) > keyboardMaxY)) {
        [UIView animateWithDuration:duration animations:^{
            self.customView.fyf_top = self.customView.fyf_top - avoidKeyboardOffset;
        }];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification{
    self.isShowKeyboard = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification{
    self.isShowKeyboard = NO;
    if (!self.isAvoidKeyboard) {
        return;
    }
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.customView.fyf_top = self.customViewFrame.origin.y;
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification{
    self.isShowKeyboard = NO;
}

#pragma mark - Orientation
- (void)statusBarOrientationChange:(NSNotification *)notification {
    if (self.isObserverScreenRotation) {
        CGRect originRect = self.customView.frame;
        self.frame = CGRectMake(0, 0, FYFScreenWidth, FYFScreenHeight);
        self.dismissView.frame = self.bounds;
        self.customView.frame = originRect;
        [self updateCustomViewConstraints];
    }
}

- (void)updateCustomViewConstraints {
    switch (self.animationMode) {
        case FYFAnimationModeNone:
        case FYFAnimationModeFade:
        case FYFAnimationModeScale:
        {
            // 中间位置
            self.customView.fyf_top = self.fyf_centerY - self.customView.fyf_height*0.5 + self.yAxisOffset;
            self.customView.fyf_left = self.fyf_centerX - self.customView.fyf_width*0.5 + self.xAxisOffset;
        }
            break;
        case FYFAnimationModeFromTop:
        case FYFAnimationModeSpringFromTop:
        {
            // 贴顶位置
            self.customView.fyf_top = self.yAxisOffset;
            self.customView.fyf_left = self.fyf_centerX - self.customView.fyf_width*0.5 + self.xAxisOffset;
        }
            break;
        case FYFAnimationModeFromBottom:
        case FYFAnimationModeSpringFromBottom:
        {
            // 贴底位置
            self.customView.fyf_top = self.fyf_height - self.customView.fyf_height + self.yAxisOffset;
            self.customView.fyf_left = self.fyf_centerX - self.customView.fyf_width*0.5 + self.xAxisOffset;
        }
            break;
        default:
            break;
    }
        
    CGFloat originBottom = CGRectGetMaxY(self.customViewFrame) + self.avoidKeyboardSpace;
    if (self.isShowKeyboard && (originBottom > self.keyboardY)) {
        //键盘已经显示
        CGFloat y = self.keyboardY - self.customView.fyf_height - self.avoidKeyboardSpace;
        self.customView.fyf_top = y;
        CGRect newFrame = self.customViewFrame;
        newFrame.size = CGSizeMake(self.customViewFrame.size.width, self.customView.fyf_height);
        self.customViewFrame = newFrame;
    } else {
        //没有键盘显示
        self.customViewFrame = self.customView.frame;
    }
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
