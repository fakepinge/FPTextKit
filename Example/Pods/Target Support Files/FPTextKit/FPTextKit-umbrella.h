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

#import "FPTextKitHeader.h"
#import "FPMatchConst.h"
#import "FPMatchManager.h"
#import "FPTextField.h"
#import "FPTextView.h"
#import "UITextView+FP_PlaceHolder.h"

FOUNDATION_EXPORT double FPTextKitVersionNumber;
FOUNDATION_EXPORT const unsigned char FPTextKitVersionString[];

