/*******************************************************************************
 # File        : FPTextView.h
 # Project     : FPTextKit
 # Author      : fakepinge
 # Created     : 2017/8/15
 # Corporation : fakepinge
 # Description :
 输入限制的TextView
 ******************************************************************************/

#import <UIKit/UIKit.h>
#import "FPMatchConst.h"

@interface FPTextView : UITextView

/**占位符*/
@property (nonatomic, copy) NSString *placeholderText;
/**占位符颜色*/
@property (nonatomic, strong) UIColor *placeholderTextColor;


#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSInteger limitedType;
#else
/**限制类型*/
@property (nonatomic, assign) FPLimitedTextType limitedType;
#endif

/**输入最大输入字符*/
@property (assign, nonatomic) IBInspectable NSInteger limitedNumber;


#pragma mark - PriceType
/**整数位数*/
@property (nonatomic, assign) IBInspectable NSInteger limitedPrefix;
/**小数点位数*/
@property (nonatomic, assign) IBInspectable NSInteger limitedSuffix;


#pragma mark - CustomType
/**正则字符串*/
@property (copy, nonatomic) IBInspectable NSString *limitedRegEx;

/**
 自定义正则匹配，设置此属性后，其优先级低的属性将失效，如：limitedType等
 优先级说明：
 limitedRegEx > limitedType > (limitedPrefix = limitedSuffix = limitedNumber)
 */
@property (strong, nonatomic) NSArray *limitedRegExs;

/** 忽略文本改变default NO*/
@property (nonatomic, assign) BOOL ignoreTextChange;

/**文本变化的回调*/
@property (copy, nonatomic) void (^textDidChangeBlock)(FPTextView *);

@end
