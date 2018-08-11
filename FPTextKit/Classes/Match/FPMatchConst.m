/*******************************************************************************
 # File        : FPMatchConst.h
 # Project     : FPTextKit
 # Author      : fakepinge
 # Created     : 2017/7/6
 # Corporation : fakepinge
 # Description :
 常用限制的正则
 ******************************************************************************/

#import "FPMatchConst.h"



NSString * const FPInputLimitedTextNumberOnlyRegex 	        = @"^[0-9]*$";
NSString * const FPInputLimitedTextFirstNotZeroNumRegex     = @"^[1-9][0-9]*$";
NSString * const FPInputLimitedTextZeroOrNonRegex 		    = @"^(0|[1-9][0-9]*)$";
NSString * const FPInputLimitedTextIntRegex 			    = @"^-|-?[1-9]\\d*$";
NSString * const FPInputLimitedTextChineseOnlyRegex 	    = @"^[\u4e00-\u9fa5]{0,}$";
NSString * const FPInputLimitedTextEnglishOnlyRegex 	    = @"^[A-Za-z]+$";
NSString * const FPInputLimitedTextNumberOrEnglisRegex      = @"^[A-Za-z0-9]+$";
NSString * const FPInputLimitedTextIntOrEnglisRegex         = @"^(-|-?[1-9]\\d*)|([A-Za-z1-9]|[A-Za-z1-9][A-Za-z0-9]+)$";
NSString * const FPInputLimitedTextChineseOrNumOrEngRegex   = @"^[a-zA-Z0-9\u4e00-\u9fa5]+$";
NSString * const FPInputLimitedTextAllCharRegex 		    = @"^[^\u4e00-\u9fa5]{0,}$";
NSString * const FPInputLimitedTextIDCardRegex 		        = @"^[xX0-9]+$";
NSString * const FPInputLimitedTextIntAndDoubleRegex 	    = @"^[0-9]+([.]{1}[0-9]+){0,1}$";



NSString * const FPVerifyIDCardRegex						= @"^(\\d{15})|((\\d{17})(\\d|[xX])$)";
NSString * const FPVerifyMobilePhoneRegex				    = @"(1\\d{10})";
NSString * const FPVerifyEmailRegex				    	    = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";



