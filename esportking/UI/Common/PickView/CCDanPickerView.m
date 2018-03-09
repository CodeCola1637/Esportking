//
//  CCDanPickerView.m
//  esportking
//
//  Created by jaycechen on 2018/3/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCDanPickerView.h"

@interface CCDanPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray<NSString *> *firstComponentList;
@property (strong, nonatomic) NSArray<NSArray<NSString *> *> *secondComponentList;
@property (strong, nonatomic) void(^saveBlock)(NSString *content, NSInteger selectIndex);
@property (strong, nonatomic) void(^cancelBlock)(void);

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UIButton *cancelButton;

@end

@implementation CCDanPickerView

- (instancetype)initWithFrame:(CGRect)frame saveBlock:(void(^)(NSString *content, NSInteger selectIndex))saveBlock cancelBlock:(void(^)(void))cancelBlock
{
    if (self = [super initWithFrame:frame])
    {
        self.firstComponentList = Wording_Dan_List;
        self.secondComponentList = Wording_Dan_List_Detail;
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
    [_pickerView selectRow:0 inComponent:1 animated:YES];
    [self.titleLabel setText:self.secondComponentList[0][0]];
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
    NSInteger firstIndex = [self.pickerView selectedRowInComponent:0];
    NSInteger secondIndex = [self.pickerView selectedRowInComponent:1];
    if (self.saveBlock)
    {
        self.saveBlock(self.secondComponentList[firstIndex][secondIndex], (firstIndex+1)*100+secondIndex+1);
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
    if (component == 0)
    {
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
    }
    
    [self.titleLabel setText:self.secondComponentList[[self.pickerView selectedRowInComponent:0]][[self.pickerView selectedRowInComponent:1]]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.firstComponentList[row];
    }
    return self.secondComponentList[[self.pickerView selectedRowInComponent:0]][row];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.firstComponentList.count;
    }
    return self.secondComponentList[[self.pickerView selectedRowInComponent:0]].count;
}

@end
