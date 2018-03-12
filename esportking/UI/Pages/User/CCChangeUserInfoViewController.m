//
//  CCChangeUserInfoViewController.m
//  esportking
//
//  Created by jaycechen on 2018/3/12.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCChangeUserInfoViewController.h"
#import "CCAddImageListView.h"
#import "CCTitleItem.h"
#import "CCChangeHeadView.h"

#import "CCModifyUserInfoRequest.h"
#import "CCAccountService.h"

#import "zhPickerView.h"
#import <zhPopupController.h>
#import <TKAlert&TKActionSheet/TKAlert&TKActionSheet.h>

@interface CCChangeUserInfoViewController ()<CCTitleItemDelegate>

@property (strong, nonatomic) CCAddImageListView *addListView;
@property (strong, nonatomic) CCChangeHeadView *headView;
@property (strong, nonatomic) CCTitleItem   *nameItem;
@property (strong, nonatomic) CCTitleItem   *sexItem;
@property (strong, nonatomic) CCTitleItem   *ageItem;
@property (strong, nonatomic) CCTitleItem   *locationItem;

@property (strong, nonatomic) CCModifyUserInfoRequest *request;

@end

@implementation CCChangeUserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    [self configData];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"个人资料"];
    UIButton *button = [UIButton new];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button.titleLabel setFont:Font_Middle];
    [button setTitleColor:BgColor_Black forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.topbarView layoutRightControls:@[button] spacing:nil];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.addListView];
    [self.contentView addSubview:self.headView];
    [self.contentView addSubview:self.nameItem];
    [self.contentView addSubview:self.sexItem];
    [self.contentView addSubview:self.ageItem];
    [self.contentView addSubview:self.locationItem];
    
    [self.addListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addListView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(180));
    }];
    [self.nameItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.equalTo(self.contentView);
    }];
    [self.sexItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameItem.mas_bottom);
        make.left.right.equalTo(self.contentView);
    }];
    [self.ageItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexItem.mas_bottom);
        make.left.right.equalTo(self.contentView);
    }];
    [self.locationItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ageItem.mas_bottom);
        make.left.right.equalTo(self.contentView);
    }];
}

- (void)configData
{
    NSString *name = CCAccountServiceInstance.name;
    if (name && name.length>0)
    {
        [self.nameItem changeSubTitle:name subTitleColor:FontColor_Black];
    }
    NSString *gender = CCAccountServiceInstance.gender;
    if (gender && gender.length>0)
    {
        [self.sexItem changeSubTitle:gender subTitleColor:FontColor_Black];
    }
    uint32_t age = CCAccountServiceInstance.age;
    if (age>0)
    {
        [self.ageItem changeSubTitle:[NSString stringWithFormat:@"%d", age] subTitleColor:FontColor_Black];
    }
    NSString *area = CCAccountServiceInstance.area;
    if (area && area.length>0)
    {
        [self.locationItem changeSubTitle:area subTitleColor:FontColor_Black];
    }
}

#pragma mark - action
- (void)onClickSaveButton:(UIButton *)button
{
    
}

#pragma mark - CCTitleItemDelegate
- (void)onClickTitleItem:(id)sender
{
    if (sender == self.nameItem)
    {
        [self onClickNameItem];
    }
    else if (sender == self.sexItem)
    {
        [self onClickSexItem];
    }
    else if (sender == self.ageItem)
    {
        [self onClickAgeItem];
    }
    else if (sender == self.locationItem)
    {
        [self onClickLocationItem];
    }
}

- (void)onClickNameItem
{
    TKTextFieldAlertViewController *textFieldAlertView = [[TKTextFieldAlertViewController alloc] initWithTitle:@"昵称" placeholder:@"请输入昵称"];
    
    CCWeakSelf(weakSelf);
    __weak typeof(textFieldAlertView) weakAlertView = textFieldAlertView;
    [textFieldAlertView addButtonWithTitle:@"取消" block:^(NSUInteger index) {
        
    }];
    [textFieldAlertView addButtonWithTitle:@"确定"  block:^(NSUInteger index) {
        if (weakAlertView.textField.text.length != 0)
        {
            [weakSelf.nameItem changeSubTitle:weakAlertView.textField.text subTitleColor:FontColor_Black];
        }
    }];
    [textFieldAlertView show];
}

- (void)onClickSexItem
{
    CCWeakSelf(weakSelf);
    TKActionSheetController *uActionSheet = [TKActionSheetController sheetWithTitle:nil];
    [uActionSheet addButtonWithTitle:@"男" block:^(NSUInteger index) {
        [weakSelf.sexItem changeSubTitle:@"男" subTitleColor:FontColor_Black];
    }];
    [uActionSheet addButtonWithTitle:@"女" block:^(NSUInteger index) {
        [weakSelf.sexItem changeSubTitle:@"女" subTitleColor:FontColor_Black];
    }];
    [uActionSheet setCancelButtonWithTitle:@"取消" block:^(NSUInteger index) {
        
    }];
    [uActionSheet showInViewController:self animated:YES completion:nil];
}

- (void)onClickAgeItem
{
    CCWeakSelf(weakSelf);
    
    CGRect rect = CGRectMake(0, 0, self.view.width, 275);
    zhPickerView *pView = [[zhPickerView alloc] initWithFrame:rect];
    
    pView.saveClickedBlock = ^(zhPickerView *pickerView) {
        [weakSelf.ageItem changeSubTitle:pickerView.selectedTimeString subTitleColor:FontColor_Black];
        [weakSelf.zh_popupController dismiss];
    };
    
    pView.cancelClickedBlock = ^(zhPickerView *pickerView) {
        [weakSelf.zh_popupController dismiss];
    };
    
    self.zh_popupController = [zhPopupController new];
    self.zh_popupController.layoutType = zhPopupLayoutTypeBottom;
    self.zh_popupController.dismissOnMaskTouched = NO;
    [self.zh_popupController presentContentView:pView];
}

- (void)onClickLocationItem
{
    
}

#pragma mark - getter
- (CCAddImageListView *)addListView
{
    if (!_addListView)
    {
        _addListView = [[CCAddImageListView alloc] initWithParentVC:self];
    }
    return _addListView;
}

- (CCChangeHeadView *)headView
{
    if (!_headView)
    {
        _headView = [[CCChangeHeadView alloc] initWithParentVC:self];
    }
    return _headView;
}

- (CCTitleItem *)nameItem
{
    if (!_nameItem)
    {
        _nameItem = [[CCTitleItem alloc] initWithTitle:@"昵称" subTitle:@"请输入" subTitleColor:FontColor_LightGray delegate:self];
    }
    return _nameItem;
}

- (CCTitleItem *)sexItem
{
    if (!_sexItem)
    {
        _sexItem = [[CCTitleItem alloc] initWithTitle:@"性别" subTitle:@"请选择" subTitleColor:FontColor_LightGray delegate:self];
    }
    return _sexItem;
}

- (CCTitleItem *)ageItem
{
    if (!_ageItem)
    {
        _ageItem = [[CCTitleItem alloc] initWithTitle:@"年龄" subTitle:@"请选择" subTitleColor:FontColor_LightGray delegate:self];
    }
    return _ageItem;
}

- (CCTitleItem *)locationItem
{
    if (!_locationItem)
    {
        _locationItem = [[CCTitleItem alloc] initWithTitle:@"地区" subTitle:@"请选择" subTitleColor:FontColor_LightGray delegate:self];
    }
    return _locationItem;
}

@end
