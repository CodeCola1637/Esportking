//
//  CCAddImageListView.m
//  esportking
//
//  Created by jaycechen on 2018/3/12.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCAddImageListView.h"
#import "CCAddImageView.h"
#import "CCAccountService.h"
#import "CCUploadImgRequest.h"
#import "CCDeleteCoverRequest.h"

#import "CCNetworkDefine.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define kAddImgViewCount    4

#define kButtonCancelTag    11
#define kButtonDeleteTag    12

@interface CCAddImageListView ()<CCAddImageViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CCUploadImgDelegate>

@property (strong, nonatomic) CCUploadImgRequest *uploadRequest;
@property (strong, nonatomic) CCDeleteCoverRequest *deleteRequest;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *deleteButton;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) NSArray<CCAddImageView *> *addImgViewList;

@end

@implementation CCAddImageListView

- (instancetype)initWithParentVC:(CCBaseViewController *)vc
{
    if (self = [super initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, CCPXToPoint(316))])
    {
        self.parentVC = vc;
        [self setupUI];
        [self setupContent];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.deleteButton];
    for (CCAddImageView *view in self.addImgViewList)
    {
        [self.bottomView addSubview:view];
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LM_SCREEN_WIDTH);
        make.height.mas_equalTo(CCPXToPoint(316));
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(CCPXToPoint(80));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(CCHorMargin);
        make.bottom.equalTo(self.topView).offset(-CCPXToPoint(10));
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView).offset(-CCHorMargin);
        make.bottom.equalTo(self.titleLabel);
        make.width.mas_equalTo(CCPXToPoint(76));
        make.height.mas_equalTo(CCPXToPoint(40));
    }];
    
    CGFloat gap = (LM_SCREEN_WIDTH-CCPXToPoint(64)-kAddImgViewCount*CCPXToPoint(156))/(kAddImgViewCount-1.f);
    CCAddImageView *previousView = self.addImgViewList[0];
    [previousView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView).offset(CCHorMargin);
        make.width.height.mas_equalTo(CCPXToPoint(156));
    }];

    for (int i=1; i<kAddImgViewCount; i++)
    {
        CCAddImageView *currentView = self.addImgViewList[i];
        [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(previousView);
            make.left.equalTo(previousView.mas_right).offset(gap);
            make.width.height.mas_equalTo(previousView);
        }];
        previousView = currentView;
    }
}

- (void)setupContent
{
    NSArray *coverList = CCAccountServiceInstance.coverUrlList;
    
    for (int i=0; i<coverList.count; i++)
    {
        CCAddImageView *addView = self.addImgViewList[i];
        addView.currentStatus = ADDIMGSTATUS_NORMAL;
        [addView setImageWithUrl:coverList[i] placeholder:CCIMG(@"Placeholder_Icon")];
    }
    for (int i=(int)coverList.count; i<kAddImgViewCount; i++)
    {
        CCAddImageView *addView = self.addImgViewList[i];
        addView.currentStatus = ADDIMGSTATUS_EMPTY;
        [addView setImage:CCIMG(@"Add_Icon")];
    }
}

#pragma mark - action
- (void)onClickDeleteButton:(UIButton *)button
{
    if (button.tag == kButtonDeleteTag)
    {
        for (CCAddImageView *addView in self.addImgViewList)
        {
            if (addView.currentStatus != ADDIMGSTATUS_EMPTY)
            {
                addView.currentStatus = ADDIMGSTATUS_DELETE;
            }
        }
        button.tag = kButtonCancelTag;
        [button setTitle:@"取消" forState:UIControlStateNormal];
    }
    else
    {
        for (CCAddImageView *addView in self.addImgViewList)
        {
            if (addView.currentStatus == ADDIMGSTATUS_DELETE)
            {
                addView.currentStatus = ADDIMGSTATUS_NORMAL;
            }
        }
        button.tag = kButtonDeleteTag;
        [button setTitle:@"删除" forState:UIControlStateNormal];

    }
}

#pragma mark - CCAddImageViewDelegate
- (void)onClickAddImgViewWithStatus:(ADDIMGSTATUS)status sender:(id)sender
{
    switch (status)
    {
        case ADDIMGSTATUS_EMPTY:
        {
            [self.deleteButton setTag:kButtonCancelTag];
            [self onClickDeleteButton:self.deleteButton];
            
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.delegate = self;
            imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imgPicker.mediaTypes = @[(NSString *)kUTTypeImage];
            imgPicker.allowsEditing = YES;
            [self.parentVC presentViewController:imgPicker animated:YES completion:nil];
        }
            break;
        case ADDIMGSTATUS_DELETE:
        {
            CCAddImageView *imgView = sender;
            self.deleteRequest = [CCDeleteCoverRequest new];
            self.deleteRequest.coverUrl = imgView.coverUrl;
            [self.deleteRequest startPostRequestWithDelegate:nil];
            imgView.currentStatus = ADDIMGSTATUS_EMPTY;
            imgView.coverUrl = nil;
            [imgView setImage:CCIMG(@"Add_Icon")];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    CCUploadImgRequest *uploadReq = [CCUploadImgRequest new];
    uploadReq.uploadKey = @"cover";
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
    [CCAccountServiceInstance setUserInfo:dict];
    [self setupContent];
    [self.parentVC endLoading];
}

- (void)onUploadFailed:(NSInteger)errCode errMsg:(NSString *)msg
{
    self.uploadRequest = nil;
    [self.parentVC showToast:msg];
    [self.parentVC endLoading];
}

#pragma mark - getter
- (UIView *)topView
{
    if (!_topView)
    {
        _topView = [UIView new];
        [_topView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _topView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_titleLabel setText:@"个人封面"];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton)
    {
        _deleteButton = [UIButton new];
        [_deleteButton setTag:kButtonDeleteTag];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:BgColor_Gray forState:UIControlStateNormal];
        [_deleteButton setBackgroundColor:BgColor_White];
        [_deleteButton.layer setCornerRadius:CCPXToPoint(6)];
        [_deleteButton addTarget:self action:@selector(onClickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [UIView new];
        [_bottomView setBackgroundColor:BgColor_White];
    }
    return _bottomView;
}

- (NSArray<CCAddImageView *> *)addImgViewList
{
    if (!_addImgViewList)
    {
        NSMutableArray *array = [NSMutableArray new];
        for (int i=0; i<kAddImgViewCount; i++)
        {
            CCAddImageView *view = [CCAddImageView new];
            view.delegate = self;
            [array addObject:view];
        }
        _addImgViewList = array;
    }
    return _addImgViewList;
}

@end
