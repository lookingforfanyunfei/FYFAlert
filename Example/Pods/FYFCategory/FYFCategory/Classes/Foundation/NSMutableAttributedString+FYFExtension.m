//
//  NSMutableAttributedString+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2022/6/29.
//

#import "NSMutableAttributedString+FYFExtension.h"

#import "NSString+FYFExtension.h"

@implementation NSMutableAttributedString (FYFExtension)

- (void)fyf_addColor:(UIColor *)color substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSForegroundColorAttributeName
                     value:color
                     range:range];
    }
}

- (void)fyf_addBackgroundColor:(UIColor *)color substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute:NSBackgroundColorAttributeName
                     value:color
                     range:range];
    }
}

- (void)fyf_addUnderlineForSubstring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute: NSUnderlineStyleAttributeName
                     value:@(NSUnderlineStyleSingle)
                     range:range];
    }
}

- (void)fyf_addStrikeThrough:(int)thickness substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute: NSStrikethroughStyleAttributeName
                     value:@(thickness)
                     range:range];
    }
}

- (void)fyf_addShadowColor:(UIColor *)color width:(int)width height:(int)height radius:(int)radius substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowColor:color];
        [shadow setShadowOffset:CGSizeMake (width, height)];
        [shadow setShadowBlurRadius:radius];
        
        [self addAttribute: NSShadowAttributeName
                     value:shadow
                     range:range];
    }
}

- (void)fyf_addFontWithName:(NSString *)fontName size:(int)fontSize substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && fontName != nil) {
        UIFont * font = [UIFont fontWithName:fontName size:fontSize];
        [self addAttribute: NSFontAttributeName
                     value:font
                     range:range];
    }
}

- (void)fyf_addFont:(UIFont *)font substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && font != nil) {
        [self addAttribute: NSFontAttributeName
                     value:font
                     range:range];
    }
}

- (void)fyf_addAlignment:(NSTextAlignment)alignment substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        NSMutableParagraphStyle* style=[[NSMutableParagraphStyle alloc]init];
        style.alignment = alignment;
        [self addAttribute: NSParagraphStyleAttributeName
                     value:style
                     range:range];
    }
}
@end
