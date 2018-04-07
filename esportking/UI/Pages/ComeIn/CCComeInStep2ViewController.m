//
//  CCComeInStep2ViewController.m
//  esportking
//
//  Created by CKQ on 2018/4/7.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCComeInStep2ViewController.h"
#import "CCTitleItem.h"
#import "CCCommitButton.h"

#import "CCComeInRequest.h"
#import "CCUploadImgRequest.h"

#import <TKAlert&TKActionSheet/TKAlert&TKActionSheet.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface CCComeInStep2ViewController ()<CCTitleItemDelegate, CCRequestDelegate, CCUploadImgDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) CCComeInModel *model;
@property (strong, nonatomic) CCUploadImgRequest *uploadReq;
@property (strong, nonatomic) CCComeInRequest *request;

@property (strong, nonatomic) UIView *topBgView;
@property (strong, nonatomic) UILabel *imgTipsLabel;
@property (strong, nonatomic) UIImageView *identifyImgView;
@property (strong, nonatomic) UIImageView *addImgView;
@property (strong, nonatomic) UILabel *addTipsLabel;

@property (strong, nonatomic) UILabel *contactTipsLabel;
@property (strong, nonatomic) CCTitleItem *contactItem;
@property (strong, nonatomic) CCCommitButton *commitButton;

@end

@implementation CCComeInStep2ViewController

- (instancetype)initWithComeInModel:(CCComeInModel *)model
{
    if (self = [super init])
    {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"申请认证"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.topBgView];
    [self.contentView addSubview:self.imgTipsLabel];
    [self.contentView addSubview:self.identifyImgView];
    [self.contentView addSubview:self.addImgView];
    [self.contentView addSubview:self.addTipsLabel];
    [self.contentView addSubview:self.contactTipsLabel];
    [self.contentView addSubview:self.contactItem];
    [self.contentView addSubview:self.commitButton];
    
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(550));
    }];
    [self.identifyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBgView).offset(CCPXToPoint(76));
        make.centerX.equalTo(self.topBgView);
        make.height.mas_equalTo(CCPXToPoint(404));
        make.width.mas_equalTo(CCPXToPoint(640));
    }];
    [self.imgTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topBgView).offset(CCHorMargin);
        make.bottom.equalTo(self.identifyImgView.mas_top).offset(-CCPXToPoint(20));
    }];
    [self.addImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.identifyImgView).offset(CCPXToPoint(146));
        make.centerX.equalTo(self.identifyImgView);
        make.width.height.mas_equalTo(CCPXToPoint(56));
    }];
    [self.addTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.addImgView);
        make.top.equalTo(self.addImgView.mas_bottom).offset(CCPXToPoint(24));
    }];
    [self.contactTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topBgView).offset(CCHorMargin);
        make.bottom.equalTo(self.topBgView);
    }];
    [self.contactItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.topBgView.mas_bottom);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(96));
    }];
    [self.commitButton setEnabled:NO];
}

#pragma mark - Action
- (void)onClickCommitButton:(id)sender
{
    if (self.request)
    {
        return;
    }
    self.request = [CCComeInRequest new];
    self.request.model = self.model;
    [self.request startPostRequestWithDelegate:self];
}

- (void)onTapIdentifyImgView:(id)sender
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imgPicker.allowsEditing = YES;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    CCUploadImgRequest *uploadReq = [CCUploadImgRequest new];
    uploadReq.uploadKey = @"identity_card";
    uploadReq.uploadImage = image;
    [uploadReq startUploadWithUrl:[NSString stringWithFormat:@"%@%@", RootAddress, ComeInGame] andDelegate:self];
    self.uploadReq = uploadReq;
    [self beginLoading];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CCTitleItemDelegate
- (void)onClickTitleItem:(id)sender
{
    if (sender == self.contactItem)
    {
        TKTextFieldAlertViewController *textFieldAlertView = [[TKTextFieldAlertViewController alloc] initWithTitle:@"QQ/微信" placeholder:@""];
        
        CCWeakSelf(weakSelf);
        __weak typeof(textFieldAlertView) weakAlertView = textFieldAlertView;
        [textFieldAlertView addButtonWithTitle:@"取消" block:^(NSUInteger index) {
            
        }];
        [textFieldAlertView addButtonWithTitle:@"确定"  block:^(NSUInteger index) {
            if (weakAlertView.textField.text.length != 0)
            {
                weakSelf.model.contact = weakAlertView.textField.text;
                [weakSelf reloadData];
            }
        }];
        [textFieldAlertView show];
    }
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (self.request != sender)
    {
        return;
    }
    
    self.request = nil;
    [self endLoading];
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (self.request != sender)
    {
        return;
    }
    
    self.request = nil;
    [self endLoading];
    [self showToast:msg];
}

#pragma mark - CCUploadImgDelegate
- (void)onUploadSuccess:(NSDictionary *)dict
{
    [self endLoading];
    self.model.identifyImg = self.uploadReq.uploadImage;
    [self reloadData];
}

- (void)onUploadFailed:(NSInteger)errCode errMsg:(NSString *)msg
{
    [self endLoading];
    [self showToast:msg];
}

#pragma mark - Private
- (void)reloadData
{
    if (self.model.contact)
    {
        [self.contactItem changeSubTitle:self.model.contact subTitleColor:FontColor_Black];
    }
    [self.identifyImgView setImage:self.model.identifyImg];
    [self.commitButton setEnabled:[self.model checkStep2InfoComplete]];
}

#pragma mark - Getters
- (UIView *)topBgView
{
    if (!_topBgView)
    {
        _topBgView = [UIView new];
        [_topBgView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _topBgView;
}

- (UILabel *)imgTipsLabel
{
    if (!_imgTipsLabel)
    {
        _imgTipsLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_imgTipsLabel setText:@"请上传身份证正面照"];
    }
    return _imgTipsLabel;
}

- (UIImageView *)identifyImgView
{
    if (!_identifyImgView)
    {
        _identifyImgView = [UIImageView scaleFillImageView];
        [_identifyImgView setBackgroundColor:BgColor_White];
        [_identifyImgView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapIdentifyImgView:)];
        [_identifyImgView addGestureRecognizer:gesture];
    }
    return _identifyImgView;
}

- (UIImageView *)addImgView
{
    if (!_addImgView)
    {
        _addImgView = [UIImageView scaleFillImageView];
        [_addImgView setImage:CCIMG(@"Add_Icon_Black")];
    }
    return _addImgView;
}

- (UILabel *)addTipsLabel
{
    if (!_addTipsLabel)
    {
        _addTipsLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_addTipsLabel setText:@"人像正面照"];
    }
    return _addTipsLabel;
}

- (UILabel *)contactTipsLabel
{
    if (!_contactTipsLabel)
    {
        _contactTipsLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_contactTipsLabel setText:@"联系方式"];
    }
    return _contactTipsLabel;
}

- (CCTitleItem *)contactItem
{
    if (!_contactItem)
    {
        _contactItem = [[CCTitleItem alloc] initWithTitle:@"QQ/微信" subTitle:@"如46453334" subTitleColor:FontColor_SuperLightGray delegate:self];
    }
    return _contactItem;
}

- (CCCommitButton *)commitButton
{
    if (!_commitButton)
    {
        _commitButton = [CCCommitButton new];
        [_commitButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(onClickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

@end
