//
//  CCModifyUserInfoViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCModifyUserInfoViewController.h"
#import "CCTitleItem.h"
#import "CCBigButton.h"
#import "UILabel+Create.h"
#import "CCModifyUserInfoRequest.h"
#import "CCUploadImgRequest.h"

#import "zhPickerView.h"
#import <zhPopupController.h>
#import <TKAlert&TKActionSheet/TKAlert&TKActionSheet.h>

#import <MobileCoreServices/MobileCoreServices.h>

@interface CCModifyUserInfoViewController ()<CCTitleItemDelegate, CCRequestDelegate, CCUploadImgDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSString      *nick;
@property (strong, nonatomic) NSString      *birth;
@property (strong, nonatomic) UIImage       *header;
@property (assign, nonatomic) GENDER        gender;

@property (assign, nonatomic) MODIFYTYPE    type;
@property (strong, nonatomic) UIImageView   *headImgView;
@property (strong, nonatomic) UILabel       *modifyLabel;
@property (strong, nonatomic) CCTitleItem   *nameItem;
@property (strong, nonatomic) CCTitleItem   *sexItem;
@property (strong, nonatomic) CCTitleItem   *ageItem;
@property (strong, nonatomic) CCBigButton   *finishButton;

@property (strong, nonatomic) CCModifyUserInfoRequest *request;

@end

@implementation CCModifyUserInfoViewController

- (instancetype)initWithType:(MODIFYTYPE)type
{
    if (self = [super init])
    {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"填写资料"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.nameItem];
    [self.contentView addSubview:self.sexItem];
    [self.contentView addSubview:self.ageItem];
    [self.contentView addSubview:self.finishButton];
    [self.headImgView addSubview:self.modifyLabel];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(CCPXToPoint(200));
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(CCPXToPoint(100), CCPXToPoint(100)));
    }];
    [self.nameItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView.mas_bottom).offset(CCPXToPoint(20));
        make.left.right.equalTo(self.contentView);
    }];
    [self.sexItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameItem.mas_bottom);
        make.left.right.equalTo(self.nameItem);
    }];
    [self.ageItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexItem.mas_bottom);
        make.left.right.equalTo(self.nameItem);
    }];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ageItem.mas_bottom).offset(CCPXToPoint(100));
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.modifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headImgView);
        make.bottom.equalTo(self.headImgView).offset(-CCPXToPoint(20));
    }];
}

#pragma mark - actions
- (void)onTapHeaderImgView:(UIGestureRecognizer *)gesture
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imgPicker.allowsEditing = YES;
    [self presentViewController:imgPicker animated:YES completion:nil];
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
            weakSelf.nick = weakAlertView.textField.text;
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
        weakSelf.gender = GENDER_BOY;
        [weakSelf.sexItem changeSubTitle:@"男" subTitleColor:FontColor_Black];
    }];
    [uActionSheet addButtonWithTitle:@"女" block:^(NSUInteger index) {
        weakSelf.gender = GENDER_GIRL;
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
        weakSelf.birth = pickerView.selectedTimeString;
        [weakSelf.ageItem changeSubTitle:weakSelf.birth subTitleColor:FontColor_Black];
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

- (void)onClickFinishButton:(UIButton *)button
{
    if (_request)
    {
        return;
    }
    _request = [[CCModifyUserInfoRequest alloc] init];
    _request.name = _nick;
    _request.gender = _gender;
    _request.birth = _birth;
    [_request startPostRequestWithDelegate:self];
    [self beginLoading];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    _header = [info objectForKey:UIImagePickerControllerEditedImage];
    CCUploadImgRequest *uploadReq = [CCUploadImgRequest new];
    uploadReq.uploadKey = @"files";
    uploadReq.uploadImage = _header;
    [uploadReq startUploadWithUrl:[NSString stringWithFormat:@"%@%@", RootAddress, ModifyUser] andDelegate:self];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender != _request)
    {
        return;
    }
    _request = nil;
    [self endLoading];
    
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender != _request)
    {
        return;
    }
    _request = nil;
    [self endLoading];
}

#pragma mark - CCUploadImgDelegate
- (void)onUploadSuccess:(NSDictionary *)dict
{
    [self.headImgView setImage:_header];
    [self endLoading];
}

- (void)onUploadFailed:(NSInteger)errCode errMsg:(NSString *)msg
{
    [self showToast:msg];
    [self endLoading];
}

#pragma mark - getters
- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView new];
        [_headImgView setImage:CCIMG(@"Default_Header")];
        [_headImgView.layer setCornerRadius:CCPXToPoint(50)];
        [_headImgView setUserInteractionEnabled:YES];
        [_headImgView setContentMode:UIViewContentModeScaleAspectFill];
        [_headImgView setClipsToBounds:YES];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapHeaderImgView:)];
        [_headImgView addGestureRecognizer:gesture];
    }
    return _headImgView;
}

- (UILabel *)modifyLabel
{
    if (!_modifyLabel)
    {
        _modifyLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_White];
        [_modifyLabel setText:@"点击修改"];
        [_modifyLabel setContentMode:UIViewContentModeCenter];
        [_modifyLabel setBackgroundColor:BgColor_Yellow];
    }
    return _modifyLabel;
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

- (CCBigButton *)finishButton
{
    if (!_finishButton)
    {
        _finishButton = [CCBigButton new];
        [_finishButton setTitle:@"完成注册" forState:UIControlStateNormal];
        [_finishButton addTarget:self action:@selector(onClickFinishButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishButton;
}

@end
