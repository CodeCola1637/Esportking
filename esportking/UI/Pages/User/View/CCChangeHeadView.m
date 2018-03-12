//
//  CCChangeHeadView.m
//  esportking
//
//  Created by jaycechen on 2018/3/12.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCChangeHeadView.h"
#import "CCTitleItem.h"

#import "CCUploadImgRequest.h"
#import "CCNetworkDefine.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface CCChangeHeadView ()<CCTitleItemDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CCUploadImgDelegate>

@property (strong, nonatomic) CCUploadImgRequest *uploadRequest;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) CCTitleItem *headItem;

@end

@implementation CCChangeHeadView

- (instancetype)initWithParentVC:(CCBaseViewController *)vc
{
    if (self = [super initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, CCPXToPoint(180))])
    {
        self.parentVC = vc;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self setBackgroundColor:BgColor_SuperLightGray];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.headItem];
    [self.headItem addSubview:self.headImgView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CCHorMargin);
        make.top.equalTo(self).offset(CCPXToPoint(30));
    }];
    [self.headItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-CCPXToPoint(10));
    }];
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headItem);
        make.right.equalTo(self.headItem.subTitleLabel);
        make.width.height.mas_equalTo(CCPXToPoint(90));
    }];
}

#pragma mark - CCTitleItemDelegate
- (void)onClickTitleItem:(id)sender
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imgPicker.allowsEditing = YES;
    [self.parentVC presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    CCUploadImgRequest *uploadReq = [CCUploadImgRequest new];
    uploadReq.uploadKey = @"files";
    uploadReq.uploadImage = image;
    [uploadReq startUploadWithUrl:[NSString stringWithFormat:@"%@%@", RootAddress, ModifyUser] andDelegate:self];
    self.uploadRequest = uploadReq;
    
    [self.parentVC beginLoading];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CCUploadImgDelegate
- (void)onUploadSuccess:(NSDictionary *)dict
{
    self.uploadRequest = nil;
    CCAccountServiceInstance.headUrl = dict[@"data"][@"picture"];
    [self.headImgView setImageWithUrl:CCAccountServiceInstance.headUrl placeholder:CCIMG(@"Default_Header")];
    [self.parentVC endLoading];
}

- (void)onUploadFailed:(NSInteger)errCode errMsg:(NSString *)msg
{
    self.uploadRequest = nil;
    [self.parentVC showToast:msg];
    [self.parentVC endLoading];
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setText:@"上传证据"];
    }
    return _titleLabel;
}

- (CCTitleItem *)headItem
{
    if (!_headItem)
    {
        _headItem = [[CCTitleItem alloc] initWithTitle:@"编辑头像" subTitle:nil subTitleColor:nil delegate:self];
    }
    return _headItem;
}

- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView scaleFillImageView];
        [_headImgView.layer setCornerRadius:CCPXToPoint(40)];
    }
    return _headImgView;
}

@end
