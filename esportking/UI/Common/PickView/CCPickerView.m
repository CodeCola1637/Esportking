//
//  CCPickerView.m
//  esportking
//
//  Created by jaycechen on 2018/3/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCPickerView.h"

@interface CCPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray<NSString *> *dataList;
@property (strong, nonatomic) void(^saveBlock)(NSString *content);
@property (strong, nonatomic) void(^cancelBlock)(void);
@property (strong, nonatomic) NSString *selectData;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UIButton *cancelButton;

@end

@implementation CCPickerView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray<NSString *> *)dataList saveBlock:(void(^)(NSString *content))saveBlock cancelBlock:(void(^)(void))cancelBlock
{
    if (self = [super initWithFrame:frame])
    {
        self.dataList = dataList;
        self.saveBlock = saveBlock;
        self.cancelBlock = cancelBlock;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _pickerView= [[UIPickerView alloc] init];
    _pickerView.frame = CGRectMake(0, 0, self.frame.size.width, 216);
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator = YES;
    [self addSubview:_pickerView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_titleLabel];
    
    _saveButton = [[UIButton alloc] init];
    [_saveButton setImage:[UIImage imageNamed:@"icon_select1"] forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveButton];
    
    _cancelButton = [[UIButton alloc] init];
    [_cancelButton setImage:[UIImage imageNamed:@"icon_revocation1"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    [self.titleLabel setText:self.dataList[0]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonWidth = 40, paddingLeft = 10, spacing = 10, paddingTop = 5;
    
    _cancelButton.size = CGSizeMake(buttonWidth, buttonWidth);
    _cancelButton.origin = CGPointMake(paddingLeft, paddingTop);
    
    _saveButton.size = CGSizeMake(buttonWidth, buttonWidth);
    _saveButton.right = self.width - paddingLeft;
    _saveButton.y = paddingTop;
    
    _titleLabel.width = self.width - (buttonWidth + paddingLeft + spacing) * 2;
    _titleLabel.height = buttonWidth;
    _titleLabel.centerX = self.width / 2;
    _titleLabel.y = paddingTop;
    
    CGFloat vSpacing = 10;
    CGFloat height = self.height - _titleLabel.bottom - vSpacing - LMLayoutAreaBottomHeight;
    _pickerView.size = CGSizeMake(self.width, height);
    _pickerView.y = _titleLabel.bottom + vSpacing;
}

#pragma mark - action
- (void)saveClicked
{
    if (self.saveBlock)
    {
        self.saveBlock(self.selectData);
    }
}

- (void)cancelClicked
{
    if (self.cancelBlock)
    {
        self.cancelBlock();
    }
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectData = self.dataList[row];
    [self.titleLabel setText:self.selectData];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataList[row];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataList.count;
}

@end
