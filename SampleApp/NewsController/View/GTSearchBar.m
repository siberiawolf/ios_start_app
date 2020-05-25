//
//  GTSearchBar.m
//  SampleApp
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTSearchBar.h"
#import "GTScreen.h"

@interface GTSearchBar()<UITextFieldDelegate>

@property(nonatomic, strong, readwrite) UITextField *textField;

@end
@implementation GTSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(UI(10), UI(5), frame.size.width - UI(10) * 2, frame.size.height - UI(5) * 2)];
            _textField.backgroundColor = [UIColor whiteColor];
            _textField.delegate = self;
            _textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
            _textField.leftViewMode = UITextFieldViewModeAlways;
            _textField.clearButtonMode = UITextFieldViewModeAlways;
            _textField.placeholder = @"今日热点推荐";
            _textField;
        })];
    }
    return self;
}

// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"");
}
// 结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder]; // 收起键盘
    return YES;
}

@end
