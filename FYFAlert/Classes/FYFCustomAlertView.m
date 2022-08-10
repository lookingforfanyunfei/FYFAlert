//
//  FYFCustomAlertView.m
//  FYFAlert
//
//  Created by 范云飞 on 2021/9/9.
//

#import "FYFCustomAlertView.h"

#import <FYFDefines/FYFDefines.h>
#import <Masonry/Masonry.h>
#import <FYFCategory/FYFCategory.h>
#import "FYFAlertConfig.h"

@interface FYFCustomAlertView ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, strong) NSString *confirmTitle;
@property (nonatomic, strong) NSAttributedString *messageAttributedString;

@property (nonatomic, strong) UIView   *dismissView;
@property (nonatomic, strong) UIView   *containerView;

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *messageLabel;
@property (nonatomic, strong) UIView   *horizontalLineView;
@property (nonatomic, strong) UIView   *verticalLineView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, weak) UIView *parentView;

@end

@implementation FYFCustomAlertView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (void)fyf_customAlertInView:(UIView *_Nullable)view title:(NSString *_Nullable)title messageAttributedString:(NSAttributedString * _Nullable )messageAttributedString cancelTitle:(NSString *_Nullable)cancelTitle confirmTitle:(NSString *_Nullable)confirmTitle cancelHandler:(void(^ _Nullable )(void))cancelHandler confirmHandler:(void(^ _Nullable )(void))confirmHandler {
    if (!view || CGRectEqualToRect(view.bounds, CGRectZero)) {
        view = FYFDefaultParentView;
    }
    FYFCustomAlertView *alertView = [[FYFCustomAlertView alloc] initWithFrame:view.bounds];
    alertView.title = title;
    alertView.messageAttributedString = messageAttributedString;
    alertView.cancelTitle = cancelTitle;
    alertView.confirmTitle = confirmTitle;
    alertView.cancelHandler = cancelHandler;
    alertView.confirmHandler = confirmHandler;
    [alertView showInView:view];
}

+ (void)fyf_customAlertInView:(UIView *_Nullable)view title:(NSString *_Nullable)title message:(NSString *_Nullable)message cancelTitle:(NSString *_Nullable)cancelTitle confirmTitle:(NSString *_Nullable)confirmTitle cancelHandler:(void(^ _Nullable )(void))cancelHandler confirmHandler:(void(^ _Nullable )(void))confirmHandler {
    if (!view || CGRectEqualToRect(view.bounds, CGRectZero)) {
        view = FYFDefaultParentView;
    }
    FYFCustomAlertView *alertView = [[FYFCustomAlertView alloc] initWithFrame:view.bounds];
    alertView.title = title;
    alertView.message = message;
    alertView.cancelTitle = cancelTitle;
    alertView.confirmTitle = confirmTitle;
    alertView.cancelHandler = cancelHandler;
    alertView.confirmHandler = confirmHandler;
    [alertView showInView:view];
}

+ (void)fyf_customAlertInView:(UIView *_Nullable)view title:(NSString *_Nullable)title message:(NSString *_Nullable)message cancelTitle:(NSString *_Nullable)cancelTitle cancelHandler:(void(^ _Nullable )(void))cancelHandler {
    [self fyf_customAlertInView:view title:title message:message cancelTitle:cancelTitle confirmTitle:nil cancelHandler:cancelHandler confirmHandler:nil];
}

+ (void)fyf_customAlertInView:(UIView *_Nullable)view title:(NSString *_Nullable)title message:(NSString *_Nullable)message confirmTitle:(NSString *_Nullable)confirmTitle confirmHandler:(void(^ _Nullable )(void))confirmHandler {
    [self fyf_customAlertInView:view title:title message:message cancelTitle:nil confirmTitle:confirmTitle cancelHandler:nil confirmHandler:confirmHandler];
}

- (void)cancelClick:(UIButton *)sender {
    if (self.cancelHandler) {
        self.cancelHandler();
    }
    [self dismiss:nil];
}

- (void)confirmClick:(UIButton *)sender {
    if (self.confirmHandler) {
        self.confirmHandler();
    }
    [self dismiss:nil];
}

- (void)show {
    [self showInView:self.parentView];
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    self.dismissView.alpha = 0.0f;
    self.containerView.layer.transform = CATransform3DMakeScale(0.8f, 0.8f, 1.0f);
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.dismissView.alpha = [FYFAlertViewConfig shareConfig].alpha;
        self.containerView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [self dismiss:nil];
}

- (void)dismiss:(id)sender {
    [UIView animateWithDuration:0.15f delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.dismissView.alpha = 0.0f;
        self.containerView.layer.transform = CATransform3DMakeScale(0.5f, 0.5f, 1.0f);
        self.containerView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.dismissView removeFromSuperview];
        [self.containerView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - Setters

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 0.0;
    NSDictionary *attributes = @{NSFontAttributeName:[FYFAlertViewConfig shareConfig].messageFont,
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSKernAttributeName:@(0.0)};
    self.messageLabel.attributedText = [[NSAttributedString alloc]initWithString:message ? message :@"" attributes:attributes];
}

- (void)setMessageAttributedString:(NSAttributedString *)messageAttributedString {
    _messageAttributedString = messageAttributedString;
    self.messageLabel.attributedText = messageAttributedString;
}

- (void)setCancelTitle:(NSString *)cancelTitle {
    _cancelTitle = cancelTitle;
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
}

- (void)setConfirmTitle:(NSString *)confirmTitle {
    _confirmTitle = confirmTitle;
    [self.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
}

#pragma mark - Init
- (instancetype)initWithParentView:(UIView *_Nullable)parentView title:(NSString *_Nullable)title message:(NSString *_Nullable)message cancelTitle:(NSString *_Nullable)cancelTitle confirmTitle:(NSString *_Nullable)confirmTitle {
    if (!parentView || CGRectEqualToRect(parentView.bounds, CGRectZero)) {
        parentView = FYFDefaultParentView;
    }
    FYFCustomAlertView *alertView = [[FYFCustomAlertView alloc] initWithFrame:parentView.bounds];
    alertView.title = title;
    alertView.message = message;
    alertView.cancelTitle = cancelTitle;
    alertView.confirmTitle = confirmTitle;
    alertView.parentView = parentView;
    
    return alertView;
}

- (instancetype)initWithParentView:(UIView *_Nullable)parentView title:(NSString *_Nullable)title messageAttributedString:(NSAttributedString * _Nullable )messageAttributedString cancelTitle:(NSString *_Nullable)cancelTitle confirmTitle:(NSString *_Nullable)confirmTitle {
    FYFCustomAlertView *alertView = [[FYFCustomAlertView alloc] initWithFrame:parentView.bounds];
    alertView.title = title;
    alertView.messageAttributedString = messageAttributedString;
    alertView.cancelTitle = cancelTitle;
    alertView.confirmTitle = confirmTitle;
    alertView.parentView = parentView;
    
    return alertView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self observerScreenRotation];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.dismissView];
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.messageLabel];
    [self.containerView addSubview:self.horizontalLineView];
    [self.containerView addSubview:self.cancelButton];
    [self.containerView addSubview:self.verticalLineView];
    [self.containerView addSubview:self.confirmButton];
    
    [self.dismissView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dismissView.mas_centerX);
        make.centerY.equalTo(self.dismissView.mas_centerY);
        make.width.mas_equalTo([FYFAlertViewConfig shareConfig].contentWith);
        make.height.mas_equalTo([FYFAlertViewConfig shareConfig].contentHeight);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.mas_top).offset([FYFAlertViewConfig shareConfig].titleTopMargin);
        make.left.equalTo(self.containerView.mas_left).offset([FYFAlertViewConfig shareConfig].titleLeftRightMargin);
        make.right.equalTo(self.containerView.mas_right).offset(-[FYFAlertViewConfig shareConfig].titleLeftRightMargin);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset([FYFAlertViewConfig shareConfig].messageTopMargin);
        make.left.equalTo(self.containerView.mas_left).offset([FYFAlertViewConfig shareConfig].messageLeftRightMargin);
        make.right.equalTo(self.containerView.mas_right).offset(-[FYFAlertViewConfig shareConfig].messageLeftRightMargin);
    }];
    
    [self.horizontalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.containerView.mas_bottom).offset(-[FYFAlertViewConfig shareConfig].buttonHeight);
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horizontalLineView.mas_bottom);
        make.left.equalTo(self.containerView.mas_left);
        make.bottom.equalTo(self.containerView.mas_bottom);
        make.right.equalTo(self.containerView.mas_centerX);
    }];
    
    [self.verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horizontalLineView.mas_bottom);
        make.bottom.equalTo(self.containerView.mas_bottom);
        make.centerX.equalTo(self.containerView.mas_centerX);
        make.width.mas_equalTo(0.5);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horizontalLineView.mas_bottom);
        make.left.equalTo(self.containerView.mas_centerX);
        make.right.equalTo(self.containerView.mas_right);
        make.bottom.equalTo(self.containerView.mas_bottom);
    }];
}

#pragma mark - LayoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateContainerViewConstraints];
    [self updateMessageLabelConstraints];
    [self updateButtonsConstraints];
}

- (void)updateContainerViewConstraints {
    [self.containerView fyf_cornerRect:UIRectCornerAllCorners radius:[FYFAlertViewConfig shareConfig].radius];
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([self calculateContentActualHeight]);
    }];
}

- (void)updateMessageLabelConstraints {
    self.titleLabel.hidden = (!self.title || !self.title.length);
    if (self.titleLabel.isHidden) {
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.containerView.mas_top).offset([FYFAlertViewConfig shareConfig].messageTopMargin);
            make.left.equalTo(self.containerView.mas_left).offset([FYFAlertViewConfig shareConfig].messageLeftRightMargin);
            make.right.equalTo(self.containerView.mas_right).offset(-[FYFAlertViewConfig shareConfig].messageLeftRightMargin);
        }];
    }
}

- (void)updateButtonsConstraints {
    if (self.cancelTitle && self.cancelHandler && self.confirmTitle && self.confirmHandler) {
        return;
    }
    self.cancelButton.hidden = !self.cancelTitle || !self.cancelHandler;
    self.confirmButton.hidden = !self.confirmTitle || !self.confirmHandler ;
    self.verticalLineView.hidden = self.cancelButton.isHidden || self.confirmButton.isHidden;
    if (self.cancelButton.isHidden && !self.confirmButton.isHidden) {
        [self.confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.horizontalLineView.mas_bottom);
            make.left.equalTo(self.containerView.mas_left);
            make.right.equalTo(self.containerView.mas_right);
            make.bottom.equalTo(self.containerView.mas_bottom);
        }];
    } else if (!self.cancelButton.isHidden && self.confirmButton.isHidden) {
        [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.horizontalLineView.mas_bottom);
            make.left.equalTo(self.containerView.mas_left);
            make.bottom.equalTo(self.containerView.mas_bottom);
            make.right.equalTo(self.containerView.mas_right);
        }];
    }
}

- (CGFloat)calculateContentActualHeight {
    CGFloat fixedHeight = [FYFAlertViewConfig shareConfig].messageBottomMargin + [FYFAlertViewConfig shareConfig].buttonHeight + 0.5;
    CGFloat titleHeight = [self calculateTitleHeight];
    CGFloat messageHeight = [self calculateMessageHeight];
    return fixedHeight + titleHeight + messageHeight;
}

- (CGFloat)calculateTitleHeight {
    if (!self.title || !self.title.length) {
        return CGFLOAT_MIN;
    }
    CGFloat titleHeight = [self.title fyf_heightWithWidth:CGRectGetWidth(self.containerView.frame) - 2*[FYFAlertViewConfig shareConfig].titleLeftRightMargin font:[FYFAlertViewConfig shareConfig].titleFont lineSpace:0.0 wordSpace:0.0 numberOfLines:0];
    return titleHeight + [FYFAlertViewConfig shareConfig].titleTopMargin;
}

- (CGFloat)calculateMessageHeight {
    NSString *message = self.message;
    __block CGFloat lineSpace = 0.0;
    if (self.messageAttributedString.string.length) {
        [self.messageAttributedString enumerateAttributesInRange:NSMakeRange(0, self.messageAttributedString.string.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            if ([attrs.allKeys containsObject:NSParagraphStyleAttributeName]) {
                NSParagraphStyle *paragraphStyle = attrs[NSParagraphStyleAttributeName];
                lineSpace = paragraphStyle.lineSpacing;
                *stop = YES;
            }
        }];
        message = self.messageAttributedString.string;
    }
    if (!message || !message.length) {
        return CGFLOAT_MIN;
    }
        
    CGFloat messageHeight = [message fyf_heightWithWidth:CGRectGetWidth(self.containerView.frame) - 2*[FYFAlertViewConfig shareConfig].messageLeftRightMargin font:[FYFAlertViewConfig shareConfig].messageFont lineSpace:lineSpace wordSpace:0.0 numberOfLines:0];
    return messageHeight + [FYFAlertViewConfig shareConfig].messageTopMargin;
}

#pragma mark - Getters
- (UIView *)dismissView {
    if (!_dismissView) {
        _dismissView = [[UIView alloc] init];
        _dismissView.backgroundColor = FYFColorFromRGB(0x000000);
        UITapGestureRecognizer *dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [_dismissView addGestureRecognizer:dismissGesture];
    }
    return _dismissView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = FYFColorFromRGB(0xFFFFFF);
    }
    return _containerView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [FYFAlertViewConfig shareConfig].titleFont;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [FYFAlertViewConfig shareConfig].titleColor;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [FYFAlertViewConfig shareConfig].messageFont;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.textColor = [FYFAlertViewConfig shareConfig].messageColor;
        _messageLabel.numberOfLines = 0;
        [_messageLabel sizeToFit];
    }
    return _messageLabel;
}

- (UIView *)horizontalLineView {
    if (!_horizontalLineView) {
        _horizontalLineView = [[UIView alloc] init];
        _horizontalLineView.backgroundColor = FYFColorFromRGB(0xE3E3E3);
    }
    return _horizontalLineView;
}

- (UIView *)verticalLineView {
    if (!_verticalLineView) {
        _verticalLineView = [[UIView alloc] init];
        _verticalLineView.backgroundColor = FYFColorFromRGB(0xE3E3E3);
    }
    return _verticalLineView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[FYFAlertViewConfig shareConfig].cancelButtonTitleColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [FYFAlertViewConfig shareConfig].cancelButtonFont;
        [_cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[FYFAlertViewConfig shareConfig].confirmButtonTitleColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [FYFAlertViewConfig shareConfig].confirmButtonFont;
        [_confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

#pragma mark - Observer Orientation
- (void)observerScreenRotation {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationChange:(NSNotification *)notification {
    CGRect frame = CGRectMake(0, 0, FYFScreenWidth, FYFScreenHeight);
    self.frame = frame;
    [self layoutIfNeeded];
}


@end
