# FPTextKit

[![CI Status](https://img.shields.io/travis/fakepinge@gmail.com/FPTextKit.svg?style=flat)](https://travis-ci.org/fakepinge@gmail.com/FPTextKit)
[![Version](https://img.shields.io/cocoapods/v/FPTextKit.svg?style=flat)](https://cocoapods.org/pods/FPTextKit)
[![License](https://img.shields.io/cocoapods/l/FPTextKit.svg?style=flat)](https://cocoapods.org/pods/FPTextKit)
[![Platform](https://img.shields.io/cocoapods/p/FPTextKit.svg?style=flat)](https://cocoapods.org/pods/FPTextKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Introduce

这是继承于UITextField和UITextView的输入控件，针对输入做的封装，当前控件默认不能输入表情，对控件做的输入限制，使用起来非常方便，可以限制长度，也可以自定制正则表达式来限制，该库也提供了一些常用正则的表达式！

Usage
==============

### init 使用FPTextField和FPTextView默认不能输入表情
```objc
// FPTextField (similar to FPTextField)
FPTextField *textFiled = [[FPTextField alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
textFiled.backgroundColor = [UIColor whiteColor];
textFiled.center = CGPointMake(self.view.center.x, textFiled.center.y);
textFiled.textColor = [UIColor blackColor];
textFiled.placeholder = @"textField输入限制";

// FPTextView (similar to FPTextView)
FPTextView *textView = [[FPTextView alloc] initWithFrame:CGRectMake(0, 200, 200, 100)];
textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
textView.center = CGPointMake(self.view.center.x, textView.center.y);
textView.textColor = [UIColor blackColor];
textView.placeholderText = @"textView输入限制";
textView.placeholderTextColor = [UIColor purpleColor];
```

### FPLimitedTextTypeDefault 简单的长度限制
```objc
// FPTextField (similar to FPTextField)
textFiled.limitedType = FPLimitedTextTypeDefault;
// 限制输入长度
textFiled.limitedNumber = 5;

// FPTextView (similar to FPTextView)
textView.limitedType = FPLimitedTextTypeDefault;
// 限制输入长度
textView.limitedNumber = 5;
```

### FPLimitedTextTypePrice 价格类型的限制
```objc
// FPTextField (similar to FPTextField)
textFiled.limitedType = FPLimitedTextTypePrice;
// 小数点前5位
textFiled.limitedPrefix = 5;
// 小数点后2位
textFiled.limitedSuffix = 2;

// FPTextView (similar to FPTextView)
textView.limitedType = FPLimitedTextTypePrice;
// 小数点前5位
textView.limitedPrefix = 5;
// 小数点后2位
textView.limitedSuffix = 2;
```

### FPLimitedTextTypeCustom 自定制的正则限制
```objc
// FPTextField (similar to FPTextField)
textFiled.limitedType = FPLimitedTextTypeCustom;
// 只能输入负整数、正整数
textFiled.limitedRegEx = FPInputLimitedTextIntRegex;

// FPTextView (similar to FPTextView)
textView.limitedType = FPLimitedTextTypeCustom;
// 只能输入负整数、正整数
textView.limitedRegEx = FPInputLimitedTextIntRegex;
```

### 输入变化的监听
```objc
textFiled.textDidChangeBlock = ^(FPTextField *textField) {
    NSLog(@"%@", textField.text);
};
textView.textDidChangeBlock = ^(FPTextView *textView) {
    NSLog(@"%@", textView.text);
};
```

## Requirements

## Installation

FPTextKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FPTextKit'
```

## Author

fakepinge, fakepinge@gmail.com

## License

FPTextKit is available under the MIT license. See the LICENSE file for more info.
