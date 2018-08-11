/*******************************************************************************
 # File        : UITextView+FP_PlaceHolder.h
 # Project     : FPTextKit
 # Author      : fakepinge
 # Created     : 2017/8/15
 # Corporation : fakepinge
 # Description :
 占位符
 ******************************************************************************/

#import <UIKit/UIKit.h>

@interface UITextView (FP_PlaceHolder)
/** 
 *  UITextView+FP_PlaceHolder
 */
@property (nonatomic, copy) NSString *FP_placeHolder;
/** 
 *  IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeholder;
/** 
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *FP_placeHolderColor;

@end
