//
//  CCTextField.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCTextField.h"

@interface CCTextField ()<UITextFieldDelegate>

@end

@implementation CCTextField
{
    NSUInteger _limitNum;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _limitNum = NSUIntegerMax;
        self.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setLimitText:(NSUInteger)limit
{
    _limitNum = limit;
}

#pragma mark -
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        [self resignFirstResponder];
    }
    return YES;
}

- (void)onTextChange:(UITextField *)textField
{
    if (textField != self)
    {
        return;
    }
    
    NSString *text = textField.text;
    if (text.length > _limitNum)
    {
        text = [text substringToIndex:_limitNum];
        [textField setText:text];
    }
}

@end
