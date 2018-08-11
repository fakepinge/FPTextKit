/*******************************************************************************
 # File        : FPMatchManager.h
 # Project     : FPTextKit
 # Author      : fakepinge
 # Created     : 2017/7/6
 # Corporation : fakepinge
 # Description :
 正则匹配工具类
 ******************************************************************************/

#import <Foundation/Foundation.h>

@interface FPMatchManager : NSObject

/**
 处理正则表达式
 */
+ (NSArray *)handleRegexs:(NSArray *)limitedRegExs;

/**
 过滤表情
 */
+ (NSString *)disableEmoji:(NSString *)text;

/**
 匹配PriceType
 */
+ (BOOL)matchLimitedTextTypePriceWithComponent:(id)component value:(NSString *)matchStr;

/**
 匹配CustomType regEx.
 */
+ (BOOL)matchLimitedTextTypeCustomWithRegEx:(NSString *)regEx component:(id)component value:(NSString *)matchStr;

/**
 regExs 按 && 正则匹配数组中所有正则.
 */
+ (BOOL)matchLimitedTextTypeCustomWithRegExs:(NSArray *)regExs component:(id)component value:(NSString *)matchStr;

@end
