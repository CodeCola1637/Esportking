//
//  LMSearchBarView.m
//  LiveMaster
//
//  Created by Guangcheng Sun on 5/26/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import "LMSearchBarView.h"

@interface LMSearchBarView() <UITextFieldDelegate>

@property (nonatomic, strong) UIView *searchContainerView;
@property (nonatomic, strong) UIImageView *searchIconImageView;

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation LMSearchBarView

-(id)init
{
    return [self initWithLeftView:nil];
}

- (instancetype)initWithLeftView:(UIView *)leftView
{
    if (self = [super initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, LMTopBarHeight)])
    {
        _leftView = leftView;
        _maxTextLength = NSUIntegerMax;
        
        [self initUIs];
        [self makeLayoutConstaints];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textDidChange:) name:UITextFieldTextDidChangeNotification object:self.searchTextField];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initUIs
{
    self.backgroundColor = [UIColor clearColor];
    self.searchContainerView = [[UIView alloc] init];
    self.searchContainerView.backgroundColor = [BgColor_Black colorWithAlphaComponent:0.1f];
    
    self.searchIconImageView = [[UIImageView alloc] init];
    self.searchIconImageView.image = CCIMG(@"LMR_Topbar_Search");
    
    
    self.searchTextField = [[UITextField alloc] init];
    self.searchTextField.font = Font_Small;
    self.searchTextField.textColor = FontColor_White;
    self.searchTextField.backgroundColor = BgColor_Clear;
    self.searchTextField.delegate = self;
    self.searchTextField.keyboardType = UIKeyboardTypeDefault;
    self.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.enablesReturnKeyAutomatically = YES;
    
    self.rightButton = [UIButton new];
    [self.rightButton setImage:CCIMG(@"LMR_Topbar_ClearText") forState:UIControlStateNormal];
    [self.rightButton setImageEdgeInsets:UIEdgeInsetsMake(-CCPXToPoint(12), -CCPXToPoint(12), -CCPXToPoint(12), -CCPXToPoint(12))];
    [self.rightButton addTarget:self action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setHidden:YES];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:FontColor_Black forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = Font_Middle;
    [self.cancelButton addTarget:self action:@selector(onCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //容器关系
    [self.searchContainerView addSubview:self.searchIconImageView];
    [self.searchContainerView addSubview:self.searchTextField];
    [self.searchContainerView addSubview:self.rightButton];
    
    [self addSubview:self.searchContainerView];
    [self addSubview:self.cancelButton];
    
    if (_leftView)
    {
        [self addSubview:_leftView];
    }
    
//    [self debugUIs];
    
}

-(void)debugUIs
{
    [self.leftView setBackgroundColor:[UIColor redColor]];
    
    self.searchContainerView.backgroundColor = [UIColor greenColor];
    
    self.searchIconImageView.backgroundColor = [UIColor blueColor];
    
    self.searchTextField.backgroundColor = [UIColor orangeColor];
    
    self.cancelButton.backgroundColor = [UIColor purpleColor];
}

-(void)makeLayoutConstaints
{
    [self.cancelButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.cancelButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.searchContainerView.layer setCornerRadius:(LMTopBarHeight/2-CCPXToPoint(12))];
    
    if (_leftView) {
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(CCPXToPoint(12));
            make.centerY.width.height.equalTo(self.searchIconImageView);
        }];
        [self.searchContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(CCPXToPoint(12));
            make.left.equalTo(_leftView.mas_right).with.offset(CCPXToPoint(6));
            make.bottom.equalTo(self.mas_bottom).with.offset(-CCPXToPoint(12));
        }];
    } else {
        [self.searchContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(CCPXToPoint(12));
            make.left.equalTo(self.mas_left).with.offset(CCPXToPoint(24));
            make.bottom.equalTo(self.mas_bottom).with.offset(CCPXToPoint(-12));
        }];
    }
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchContainerView.mas_top);
        make.bottom.equalTo(self.searchContainerView.mas_bottom);
        make.right.equalTo(self.mas_right).with.offset(CCPXToPoint(-32));
        make.left.equalTo(self.searchContainerView.mas_right).with.offset(CCPXToPoint(24));
    }];
    
    [self.searchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchContainerView).with.offset(-CCOnePoint);
        make.bottom.equalTo(self.searchContainerView).with.offset(CCOnePoint);;
        make.left.equalTo(self.searchContainerView.mas_left).with.offset(CCPXToPoint(12));
        make.width.equalTo(self.searchIconImageView.mas_height);
    }];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.searchContainerView);
        make.left.equalTo(self.searchIconImageView.mas_right).with.offset(CCPXToPoint(12));
        make.right.equalTo(self.rightButton.mas_left).with.offset(CCPXToPoint(-6));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.searchContainerView).with.offset(-CCPXToPoint(12));
        make.centerY.equalTo(self.searchContainerView);
        make.width.height.mas_equalTo(CCPXToPoint(48));
    }];
}

- (void)setContainerColor:(UIColor *)color
{
    self.searchContainerView.backgroundColor = color;
}

#pragma mark - Public
- (void)setCancelButtonHidden:(BOOL)hidden animaiton:(BOOL)animated
{
    CGFloat offset = 0;
    if (hidden)
    {
        offset = [self.cancelButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.cancelButton.titleLabel.font}].width;
        [self.cancelButton setHidden:hidden];
    }
    else
    {
        offset = CCPXToPoint(-32);
    }
    
    [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(offset);
    }];
    
    if (animated)
    {
        [UIView animateWithDuration:.3f animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.cancelButton setHidden:hidden];
        }];
    }
    else
    {
        [self.cancelButton setHidden:hidden];
        [self layoutIfNeeded];
    }
}

#pragma mark - Seletor
-(void)onCancelButtonClick:(id)sender
{
    self.searchTextField.text = @"";
    [self.rightButton setHidden:YES];
    [self.delegate onCancelSearch];
}

- (void)clearText
{
    self.searchTextField.text = @"";
    [self.rightButton setHidden:YES];
    [self.searchTextField becomeFirstResponder];
    [self.delegate onSearch:self.searchTextField.text];
}

#pragma mark -- UITextFieldDelegate
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (0 == range.location && ([string isEqualToString:@""] || [string isEqualToString:@"\n"]))
    {
        [self.rightButton setHidden:YES];
    }
    else
    {
        [self.rightButton setHidden:NO];
    }
    
    if ([string isEqualToString:@"\n"])
    {
        if (self.searchTextField.text.length == 0)
        {
            return YES;
        }
        else
        {
            [self.searchTextField resignFirstResponder];
            [self.delegate onSearch:self.searchTextField.text];
        }
    }
    return YES;
}

#pragma mark - Notification
-(void)_textDidChange:(NSNotification *)sender
{
    if (sender.object != self.searchTextField)
    {
        return;
    }
    UIView<UITextInput>* v = self.searchTextField;
    UITextRange *markedTextRange = [v markedTextRange];
    // 获取高亮部分
    UITextPosition *position = [v positionFromPosition:markedTextRange.start offset:0];
    // 有高亮选择的字，则直接返回，不做处理
    if (position)
    {
        return;
    }
    
    NSString* newText = self.searchTextField.text;
    
    if([newText length] > _maxTextLength)
    {
        NSRange rangeIndex = [newText rangeOfComposedCharacterSequenceAtIndex:_maxTextLength];
        if (rangeIndex.length == 1)
        {
            newText = [newText substringToIndex:_maxTextLength];
        }
        else
        {
            newText = [newText substringToIndex:rangeIndex.location];
        }
        [self.searchTextField setText:newText];
    }
}

@end
