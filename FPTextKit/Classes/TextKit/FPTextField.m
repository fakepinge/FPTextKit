/*******************************************************************************
 # File        : CommonTextField.m
 # Project     : FPTextKit
 # Author      : fakepinge
 # Created     : 2017/7/6
 # Corporation : fakepinge
 # Description :
 输入限制的TextField
 ******************************************************************************/

#import "FPTextField.h"
#import "FPMatchManager.h"

@interface FPTextField ()

@property (nonatomic, copy) NSString *historyText;

@end

@implementation FPTextField

@synthesize limitedNumber = _limitedNumber;

- (void)awakeFromNib {
	[super awakeFromNib];
	[self createDefaultData];
}

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
#pragma mark - 初始化默认数据
- (void)createDefaultData {
	self.ignoreTextChange = NO;
	[self addNotifications];
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidBeginEditingNotification:) name:UITextFieldTextDidBeginEditingNotification object:self];
}

- (void)removeNotifications {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:self];
}

- (void)textFieldTextDidBeginEditingNotification:(NSNotification *)notification {
	if (self != notification.object && self.ignoreTextChange) return;
	if (self.historyText.length == 0) return;
	
	UITextField *textField = notification.object;
	NSString *currentText = self.historyText;
	BOOL isMatch = YES;
    switch (self.limitedType) {
        case FPLimitedTextTypeDefault:{
            currentText = [FPMatchManager disableEmoji:currentText];
            break;
        }
        case FPLimitedTextTypePrice:{
            isMatch = [FPMatchManager matchLimitedTextTypePriceWithComponent:textField value:currentText];
            if (!isMatch) {
                currentText = @"";
            }
            break;
        }
        case FPLimitedTextTypeCustom: {
            isMatch = [FPMatchManager matchLimitedTextTypeCustomWithRegExs:self.limitedRegExs component:textField value:currentText];
            if (!isMatch) {
                currentText = @"";
            }
            break;
        }
        default:
            break;
    }
	self.historyText = currentText;
	textField.text = currentText;
    if (self.textDidChangeBlock) {
        self.textDidChangeBlock(self);
    }
}

- (void)textFieldTextDidChangeNotification:(NSNotification *)notification {
	if (self != notification.object && self.ignoreTextChange) return;
	
	UITextField *textField = notification.object;
	NSString *currentText = textField.text;
    NSRange locationRange = self.selectedRange;
	NSInteger maxLength = self.limitedNumber;
	BOOL isMatch = YES;
	BOOL isHighLight = NO;

	UITextRange *selectRange = [textField markedTextRange];
	UITextPosition *position = [textField positionFromPosition:selectRange.start offset:0];
	isHighLight = position ? YES: NO;
	
    switch (self.limitedType) {
        case FPLimitedTextTypeDefault:{
            currentText = [FPMatchManager disableEmoji:currentText];
            break;
        }
        case FPLimitedTextTypePrice:{
            isMatch = [FPMatchManager matchLimitedTextTypePriceWithComponent:textField value:currentText];
            break;
        }
        case FPLimitedTextTypeCustom: {
            if (!isHighLight) {
                // 高亮文字通过，未高亮文字（已经输入文字）验证
                isMatch = [FPMatchManager matchLimitedTextTypeCustomWithRegExs:self.limitedRegExs component:textField value:currentText];
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
				textField.text = [currentText substringToIndex:maxLength];
			} else {
				textField.text = currentText;
			}
			self.historyText = textField.text;
		}
		
		if (!isMatch) {
			if (currentText.length == 0) {
				self.historyText = @"";
			}
			NSString *historyText = self.historyText;
			if (!historyText.length) {
				textField.text = @"";
			} else {
				textField.text = self.historyText;
                if (locationRange.location > 1) {
                    locationRange.location -= 1;
                }
			}
		}
	}
    if (locationRange.location > textField.text.length) {
        locationRange.location = textField.text.length;
    }
    [self setSelectedRange:locationRange];
    
	if (self.textDidChangeBlock) {
		self.textDidChangeBlock(self);
	}
}

- (NSRange)selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
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

@end
