/*******************************************************************************
 # File        : FPMatchConst.h
 # Project     : FPTextKit
 # Author      : fakepinge
 # Created     : 2017/7/6
 # Corporation : fakepinge
 # Description :
 常用限制的正则
 ******************************************************************************/

#import <UIKit/UIKit.h>


/**
 限制类型

 - FPLimitedTextTypeDefault: 默认限制 限制表情
 - FPLimitedTextTypePrice:   价格类型限制
 - FPLimitedTextTypeCustom:  自定义正则限制
 */
typedef NS_ENUM (NSInteger, FPLimitedTextType) {
    FPLimitedTextTypeDefault,
    FPLimitedTextTypePrice,
    FPLimitedTextTypeCustom
};


/**只能输入数字 纯数字*/
UIKIT_EXTERN NSString * const FPInputLimitedTextNumberOnlyRegex;
/**只能输入数字 第一位不能为0 正整数*/
UIKIT_EXTERN NSString * const FPInputLimitedTextFirstNotZeroNumRegex;
/**只能输入0或者非0数字 0和正整数*/
UIKIT_EXTERN NSString * const FPInputLimitedTextZeroOrNonRegex;
/**输入整数 负整数和正整数 不能输0*/
UIKIT_EXTERN NSString * const FPInputLimitedTextIntRegex;
/**只能输入中文*/
UIKIT_EXTERN NSString * const FPInputLimitedTextChineseOnlyRegex;
/**只能输入英文*/
UIKIT_EXTERN NSString * const FPInputLimitedTextEnglishOnlyRegex;
/**输入数字或者字母*/
UIKIT_EXTERN NSString * const FPInputLimitedTextNumberOrEnglisRegex;
/**负整数和正整数和字母数字*/
UIKIT_EXTERN NSString * const FPInputLimitedTextIntOrEnglisRegex;
/**输入汉字或数字或者字母*/
UIKIT_EXTERN NSString * const FPInputLimitedTextChineseOrNumOrEngRegex;
/**所有字符 非中文*/
UIKIT_EXTERN NSString * const FPInputLimitedTextAllCharRegex;
/**输入身份证格式*/
UIKIT_EXTERN NSString * const FPInputLimitedTextIDCardRegex;
/**输入整数或者浮点数*/
UIKIT_EXTERN NSString * const FPInputLimitedTextIntAndDoubleRegex;



/**验证身份证*/
UIKIT_EXTERN NSString * const FPVerifyIDCardRegex;
/**验证11位手机号*/
UIKIT_EXTERN NSString * const FPVerifyMobilePhoneRegex;
/**验证邮箱*/
UIKIT_EXTERN NSString * const FPVerifyEmailRegex;

