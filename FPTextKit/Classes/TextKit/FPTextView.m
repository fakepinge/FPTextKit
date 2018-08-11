/*******************************************************************************
 # File        : FPTextView.m
 # Project     : FPTextKit
 # Author      : fakepinge
 # Created     : 2017/8/15
 # Corporation : fakepinge
 # Description :
 输入限制的TextView
 ******************************************************************************/

#import "FPTextView.h"
#import "UITextView+FP_PlaceHolder.h"
#import "FPMatchManager.h"

@interface FPTextView ()

@property (nonatomic, copy) NSString *historyText;

@end

@implementation FPTextView

@synthesize limitedNumber = _limitedNumber;

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createDefaultData];
	}
	return self;
}

- (void)dealloc {
	[self removeNotifications];
}

#pragma mark ----------------------------- 私有方法 ------------------------------
- (void)createDefaultData {
	self.ignoreTextChange = NO;
	[self addNotifications];
	[self addConfigs];
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidBeginEditingNotification:) name:UITextViewTextDidBeginEditingNotification object:self];
}

- (void)addConfigs {
	self.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)removeNotifications {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self];
}

- (void)textViewTextDidBeginEditingNotification:(NSNotification *)notification {
	if (self != notification.object && self.ignoreTextChange) return;
	if (self.historyText.length == 0) return;
	
	UITextView *textView = notification.object;
	NSString *currentText = self.historyText;
	BOOL isMatch = YES;
	switch (self.limitedType) {
        case FPLimitedTextTypeDefault:{
			currentText = [FPMatchManager disableEmoji:currentText];
			break;
        }
        case FPLimitedTextTypePrice:{
			isMatch = [FPMatchManager matchLimitedTextTypePriceWithComponent:textView value:currentText];
			if (!isMatch) {
				currentText = @"";
			}
			break;
        }
		case FPLimitedTextTypeCustom: {
			isMatch = [FPMatchManager matchLimitedTextTypeCustomWithRegExs:self.limitedRegExs component:textView value:currentText];
			if (!isMatch) {
				currentText = @"";
			}
			break;
        }
		default:
			break;
	}
	self.historyText = currentText;
	textView.text = currentText;
    if (self.textDidChangeBlock) {
        self.textDidChangeBlock(self);
    }
}

- (void)textViewTextDidChangeNotification:(NSNotification *)notification {
	if (self != notification.object && self.ignoreTextChange) return;

	UITextView *textView = notification.object;
	NSString *currentText = textView.text;
    NSRange locationRange = textView.selectedRange;
	NSInteger maxLength = self.limitedNumber;
	BOOL isMatch = YES;
	BOOL isHighLight = NO;

	UITextRange *selectRange = [textView markedTextRange];
	UITextPosition *position = [textView positionFromPosition:selectRange.start offset:0];
	isHighLight = position ? YES : NO;
	
	switch (self.limitedType) {
        case FPLimitedTextTypeDefault:{
				currentText = [FPMatchManager disableEmoji:currentText];
			break;
        }
        case FPLimitedTextTypePrice:{
			isMatch = [FPMatchManager matchLimitedTextTypePriceWithComponent:textView value:currentText];
			break;
        }
        case FPLimitedTextTypeCustom:{
			if (!isHighLight) {
				isMatch = [FPMatchManager matchLimitedTextTypeCustomWithRegExs:self.limitedRegExs component:textView value:currentText];
			}
			break;
        }
		default:
            break;
	}
	
	if (!isHighLight) {
		// 未高亮文字（已经输入文字）验证
		if (isMatch) {
			if (currentText.length > maxLength) {
				textView.text = [currentText substringToIndex:maxLength];
			} else {
				textView.text = currentText;
			}
			self.historyText = textView.text;
		}
		
		if (!isMatch) {
			if (currentText.length == 0) {
				self.historyText = @"";
			}
			NSString *historyText = self.historyText;
			if (!historyText.length) {
				textView.text = @"";
			} else {
				textView.text = self.historyText;
                if (locationRange.location > 1) {
                    locationRange.location -= 1;
                }
			}
		}
	}
    if (locationRange.location > textView.text.length) {
        locationRange.location = textView.text.length;
    }
	textView.selectedRange = locationRange;
	if (self.textDidChangeBlock) {
		self.textDidChangeBlock(self);
	}
}

#pragma mark ----------------------------- 公用方法 ------------------------------
- (void)clearCache {
	self.text = @"";
	_historyText = nil;
}

#pragma mark --------------------------- setter&getter -------------------------
- (void)setText:(NSString *)text {
	[super setText:text];
	_historyText = text;
}

- (void)setLimitedNumber:(NSInteger)limitedNumber {
	_limitedNumber = limitedNumber;
}

- (NSInteger)limitedNumber {
	if (_limitedNumber) {
		return _limitedNumber;
	}
	return _limitedNumber = MAX_INPUT;
}

- (void)setLimitedRegEx:(NSString *)limitedRegEx {
	self.limitedRegExs = @[limitedRegEx];
}

- (void)setLimitedRegExs:(NSArray *)limitedRegExs {
	NSArray *realRegExs = [FPMatchManager handleRegexs:limitedRegExs];
	_limitedRegExs = realRegExs;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
	_placeholderText = placeholderText;
	self.FP_placeHolder = _placeholderText;
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
	_placeholderTextColor = placeholderTextColor;
	self.FP_placeHolderColor = _placeholderTextColor;
}

@end
