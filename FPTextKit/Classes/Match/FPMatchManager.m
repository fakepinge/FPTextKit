/*******************************************************************************
 # File        : FPMatchManager.h
 # Project     : FPTextKit
 # Author      : fakepinge
 # Created     : 2017/7/6
 # Corporation : fakepinge
 # Description :
 正则匹配工具类
 ******************************************************************************/

#define FPInputRegExHeader @"SELF MATCHES %@"
#define FPFPLimitedTextTypePriceRegExZero @"^[0][0-9]+$"
#define FPFPLimitedTextTypePriceRegExContentFormat(limitedPrefix, limitedSuffix) [NSString stringWithFormat:@"^\\d{0,%ld}$|^(\\d{0,%ld}[.][0-9]{0,%ld})$", limitedPrefix, limitedPrefix, limitedSuffix]

#import "FPMatchManager.h"

@implementation FPMatchManager

+ (NSArray *)handleRegexs:(NSArray *)limitedRegExs {
	NSString *realRegEx;
	NSMutableArray *realRegExs = [NSMutableArray array];
	for (NSString *regEx in limitedRegExs) {
		realRegEx = [regEx stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
		if (realRegEx.length) {
			[realRegExs addObject:realRegEx];
		}
	}
	return realRegExs.copy;
}

+ (NSString *)disableEmoji:(NSString *)text {
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
	NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
	if (modifiedString.length == 0) {
		modifiedString = @"";
	}
	return modifiedString;
}

+ (BOOL)matchLimitedTextTypePriceWithComponent:(id)component value:(NSString *)matchStr {
    NSInteger limitedPrefix = [[component valueForKeyPath:@"limitedPrefix"] integerValue];
    NSInteger limitedSuffix = [[component valueForKeyPath:@"limitedSuffix"] integerValue];
    // 匹配以0开头的数字
    NSPredicate *matchZero = [NSPredicate predicateWithFormat:FPInputRegExHeader, FPFPLimitedTextTypePriceRegExZero];
    // 匹配两位小数、整数
    NSPredicate *matchValue = [NSPredicate predicateWithFormat:FPInputRegExHeader,FPFPLimitedTextTypePriceRegExContentFormat((long)limitedPrefix, (long)limitedSuffix)];
	// 是否以.开头
	BOOL isPointStart = [matchStr hasPrefix:@"."];
    BOOL isZero = ![matchZero evaluateWithObject:matchStr];
    BOOL isCorrectValue = [matchValue evaluateWithObject:matchStr];
    return (!isPointStart && isZero && isCorrectValue) ? YES : NO;
}

+ (BOOL)matchLimitedTextTypeCustomWithRegEx:(NSString *)regEx component:(id)component value:(NSString *)matchStr {
    NSPredicate *matchValue = [NSPredicate predicateWithFormat:FPInputRegExHeader, regEx];
    return [matchValue evaluateWithObject:matchStr];
}

+ (BOOL)matchLimitedTextTypeCustomWithRegExs:(NSArray *)regExs component:(id)component value:(NSString *)matchStr {
    BOOL results = YES;
    if (!regExs.count) return results;
    
    for (NSString *regEx in regExs) {
        results = results && [self matchLimitedTextTypeCustomWithRegEx:regEx component:component value:matchStr];
    }
    return results;
}

@end
