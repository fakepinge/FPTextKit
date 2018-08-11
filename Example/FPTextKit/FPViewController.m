//
//  FPViewController.m
//  FPTextKit
//
//  Created by fakepinge@gmail.com on 08/11/2018.
//  Copyright (c) 2018 fakepinge@gmail.com. All rights reserved.
//

#import "FPViewController.h"
#import "FPTextKitHeader.h"

@interface FPViewController ()

@property (nonatomic, strong) FPTextField *textFiled;
@property (nonatomic, strong) FPTextView *textView;

@end

@implementation FPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textFiled];
    [self.view addSubview:self.textView];
    
    NSArray *titles = @[@"简单的长度限制", @"价格类型的限制", @"自定制的正则限制"];
    CGFloat buttonHeight = 35;
    CGFloat buttonWidth = 180;
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor purpleColor];
        button.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame) + 20 + i * (buttonHeight + 20), buttonWidth, buttonHeight);
        button.center = CGPointMake(self.view.center.x, button.center.y);
        button.tag = 10 + i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClickAction:(UIButton *)button {
    [self reset];
    NSInteger index = button.tag - 10;
    if (index == 0) { // 简单的长度限制
        self.textFiled.limitedType = FPLimitedTextTypeDefault;
        self.textView.limitedType = FPLimitedTextTypeDefault;
        self.textFiled.limitedNumber = 5;
        self.textView.limitedNumber = 5;
    } else if (index == 1) { // 价格类型的限制
        self.textFiled.limitedType = FPLimitedTextTypePrice;
        // 小数点前5位
        self.textFiled.limitedPrefix = 5;
        // 小数点后2位
        self.textFiled.limitedSuffix = 2;
        
        self.textView.limitedType = FPLimitedTextTypePrice;
        // 小数点前5位
        self.textView.limitedPrefix = 5;
        // 小数点后2位
        self.textView.limitedSuffix = 2;
    } else if (index == 2) { // 自定制的正则限制
        self.textFiled.limitedType = FPLimitedTextTypeCustom;
        // 只能输入负整数、正整数
        self.textFiled.limitedRegEx = FPInputLimitedTextIntRegex;
        
        self.textView.limitedType = FPLimitedTextTypeCustom;
        // 只能输入负整数、正整数
        self.textView.limitedRegEx = FPInputLimitedTextIntRegex;
    }
}

- (void)reset {
    self.textFiled.limitedType = FPLimitedTextTypeDefault;
    self.textView.limitedType = FPLimitedTextTypeDefault;
    self.textFiled.limitedNumber = 0;
    self.textView.limitedNumber = 0;
}

- (FPTextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[FPTextField alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
        _textFiled.backgroundColor = [UIColor whiteColor];
        _textFiled.center = CGPointMake(self.view.center.x, _textFiled.center.y);
        _textFiled.textColor = [UIColor blackColor];
        _textFiled.placeholder = @"textField测试输入限制";
    }
    return _textFiled;
}

- (FPTextView *)textView {
    if (!_textView) {
        _textView = [[FPTextView alloc] initWithFrame:CGRectMake(0, 200, 200, 100)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.center = CGPointMake(self.view.center.x, _textView.center.y);
        _textView.textColor = [UIColor blackColor];
        _textView.placeholderText = @"textView测试输入限制";
        _textView.placeholderTextColor = [UIColor purpleColor];
    }
    return _textView;
}
@end
