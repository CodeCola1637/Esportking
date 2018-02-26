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

#import <SCLAlertView.h>
#import "JXTAlertController.h"
#import "PGDatePickManager.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface CCModifyUserInfoViewController ()<CCTitleItemDelegate, PGDatePickerDelegate, CCRequestDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSString    *_nick;
    GENDER      _gender;
    NSString    *_birth;
    UIImage     *_header;
}

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
    SCLAlertView *alert = [SCLAlertView new];
    [alert setHorizontalButtons:YES];
    
    SCLTextView *textField = [alert addTextField:@"请输入昵称"];
    alert.hideAnimationType = SCLAlertViewHideAnimationSlideOutToTop;
    [alert addButton:@"确认" actionBlock:^{
        if (textField.text.length != 0)
        {
            [self.nameItem changeSubTitle:textField.text subTitleColor:FontColor_Black];
        }
    }];
    [alert showEdit:self title:@"昵称" subTitle:nil closeButtonTitle:@"取消" duration:0];
}

- (void)onClickSexItem
{
    [UIAlertController mj_showActionSheetWithTitle:nil message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.addActionDefaultTitle(@"男").addActionDefaultTitle(@"女").addActionDefaultTitle(@"取消");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if (buttonIndex == 0)
        {
            _gender = GENDER_BOY;
            [self.sexItem changeSubTitle:@"男" subTitleColor:FontColor_Black];
        }
        else if (buttonIndex == 1)
        {
            _gender = GENDER_GIRL;
            [self.sexItem changeSubTitle:@"女" subTitleColor:FontColor_Black];
        }
    }];
}

- (void)onClickAgeItem
{
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGPickerViewType1;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    [self presentViewController:datePickManager animated:false completion:nil];
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
    if (_header)
    {
        _request.header = UIImagePNGRepresentation(_header);
    }
    [_request startPostRequestWithDelegate:self];
    [self beginLoading];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    _header = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.headImgView setImage:_header];
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

#pragma mark - PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents
{
    _birth = [NSString stringWithFormat:@"%ld年%ld月%ld日", dateComponents.year, dateComponents.month, dateComponents.day];
    [self.ageItem changeSubTitle:_birth subTitleColor:FontColor_Black];
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

#pragma mark - getters
- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView new];
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
