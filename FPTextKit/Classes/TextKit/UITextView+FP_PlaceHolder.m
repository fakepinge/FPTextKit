/*******************************************************************************
 # File        : UITextView+FP_PlaceHolder.m
 # Project     : FPTextKit
 # Author      : fakepinge
 # Created     : 2017/8/15
 # Corporation : fakepinge
 # Description :
 占位符
 ******************************************************************************/

#import "UITextView+FP_PlaceHolder.h"
#import <objc/runtime.h>

static const void *FP_placeHolderKey;

@interface UITextView ()

@property (nonatomic, readonly) UILabel *FP_placeHolderLabel;

@end

@implementation UITextView (FP_PlaceHolder)

+ (void)load {
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(FP_PlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(FP_PlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(FP_PlaceHolder_swizzled_setText:)));
}
#pragma mark - swizzled
- (void)FP_PlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self FP_PlaceHolder_swizzled_dealloc];
}

- (void)FP_PlaceHolder_swizzling_layoutSubviews {
    if (self.FP_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.FP_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.FP_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self FP_PlaceHolder_swizzling_layoutSubviews];
}

- (void)FP_PlaceHolder_swizzled_setText:(NSString *)text {
    [self FP_PlaceHolder_swizzled_setText:text];
    if (self.FP_placeHolder) {
        [self updatePlaceHolder];
    }
}

#pragma mark - associated
- (NSString *)FP_placeHolder {
    return objc_getAssociatedObject(self, &FP_placeHolderKey);
}

- (void)setFP_placeHolder:(NSString *)FP_placeHolder {
    objc_setAssociatedObject(self, &FP_placeHolderKey, FP_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}

- (UIColor *)FP_placeHolderColor {
    return self.FP_placeHolderLabel.textColor;
}

- (void)setFP_placeHolderColor:(UIColor *)FP_placeHolderColor {
    self.FP_placeHolderLabel.textColor = FP_placeHolderColor;
}

- (NSString *)placeholder {
    return self.FP_placeHolder;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.FP_placeHolder = placeholder;
}

#pragma mark - update
- (void)updatePlaceHolder {
    if (self.text.length) {
        [self.FP_placeHolderLabel removeFromSuperview];
        return;
    }
    self.FP_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.FP_placeHolderLabel.textAlignment = self.textAlignment;
    self.FP_placeHolderLabel.text = self.FP_placeHolder;
    [self insertSubview:self.FP_placeHolderLabel atIndex:0];
}

#pragma mark - lazzing
- (UILabel *)FP_placeHolderLabel {
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(FP_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(FP_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}

- (UIFont *)cacutDefaultFont {
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}

@end
