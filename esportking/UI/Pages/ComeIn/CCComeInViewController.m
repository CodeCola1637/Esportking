//
//  CCComeInViewController.m
//  esportking
//
//  Created by CKQ on 2018/3/13.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCComeInViewController.h"
#import "CCComeInStep2ViewController.h"

#import "CCComeInModel.h"
#import "CCScoreModel.h"

#import "CCRefreshTableView.h"
#import "CCTitleTableViewCell.h"
#import "CCPicTableViewCell.h"
#import "CCDevideTableViewCell.h"
#import "CCCommitButton.h"
#import "CCPickerView.h"
#import <zhPopupController.h>
#import <TKAlert&TKActionSheet/TKAlert&TKActionSheet.h>

#import <MobileCoreServices/MobileCoreServices.h>
#import "CCUploadImgRequest.h"
#import "CCNetworkDefine.h"

#define kDevideIndentify    @"devide_identify"
#define kTitleIndentify     @"title_identify"
#define kPicIdentify        @"pic_identify"

typedef enum : NSUInteger {
    ITEMTYPE_DAN=1,
    ITEMTYPE_PLATFORM,
    ITEMTYPE_CLIENT,
    ITEMTYPE_SKILLED,
    ITEMTYPE_HONOUR,
    ITEMTYPE_GENDER
} ITEMTYPE;

@interface CCComeInViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CCUploadImgDelegate>

@property (strong, nonatomic) CCComeInModel *model;
@property (strong, nonatomic) CCUploadImgRequest *uploadReq;
@property (strong, nonatomic) CCRefreshTableView *tableView;
@property (strong, nonatomic) CCCommitButton *commitButton;

@end

@implementation CCComeInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"申请认证"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.commitButton];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.commitButton.mas_top);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(96));
    }];
    [self.commitButton setEnabled:NO];
}

#pragma mark - action
- (void)onClickCommitButton:(id)sender
{
    CCComeInStep2ViewController *vc = [[CCComeInStep2ViewController alloc] initWithComeInModel:self.model];
    [self pushViewController:vc andRemoveSelf:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    if (indexPath.row == 7)
    {
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imgPicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imgPicker.allowsEditing = YES;
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
    else
    {
        CCTitleTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        UIView *pickerView = nil;
        CCWeakSelf(weakSelf);
        
        switch (cell.tag) {
            case ITEMTYPE_CLIENT:
            {
                pickerView = [[CCPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275)  data:@[Wording_System_iOS, Wording_System_Andorid] saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    weakSelf.model.clientType = selectIndex;
                    [weakSelf reloadData];
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            case ITEMTYPE_PLATFORM:
            {
                pickerView = [[CCPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275)  data:@[Wording_Platform_QQ, Wording_Platform_WX] saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    weakSelf.model.platformType = selectIndex;
                    [weakSelf reloadData];
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            case ITEMTYPE_DAN:
            {
                pickerView = [[CCPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275)  data:@[Wording_Dan_QingTong, Wording_Dan_BaiYin, Wording_Dan_HuangJin, Wording_Dan_BOJIN, Wording_Dan_ZuanShi, Wording_Dan_XingYao, Wording_Dan_WangZhe] saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    weakSelf.model.maxDan = content;
                    [weakSelf reloadData];
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            case ITEMTYPE_SKILLED:
            {
                TKTextFieldAlertViewController *textFieldAlertView = [[TKTextFieldAlertViewController alloc] initWithTitle:@"擅长英雄" placeholder:@""];
                
                CCWeakSelf(weakSelf);
                __weak typeof(textFieldAlertView) weakAlertView = textFieldAlertView;
                [textFieldAlertView addButtonWithTitle:@"取消" block:^(NSUInteger index) {
                    
                }];
                [textFieldAlertView addButtonWithTitle:@"确定"  block:^(NSUInteger index) {
                    if (weakAlertView.textField.text.length != 0)
                    {
                        weakSelf.model.skilled = weakAlertView.textField.text;
                        [weakSelf reloadData];
                    }
                }];
                [textFieldAlertView show];
            }
                break;
            case ITEMTYPE_HONOUR:
            {
                TKTextFieldAlertViewController *textFieldAlertView = [[TKTextFieldAlertViewController alloc] initWithTitle:@"荣誉成就" placeholder:@""];
                
                CCWeakSelf(weakSelf);
                __weak typeof(textFieldAlertView) weakAlertView = textFieldAlertView;
                [textFieldAlertView addButtonWithTitle:@"取消" block:^(NSUInteger index) {
                    
                }];
                [textFieldAlertView addButtonWithTitle:@"确定"  block:^(NSUInteger index) {
                    if (weakAlertView.textField.text.length != 0)
                    {
                        weakSelf.model.honour = weakAlertView.textField.text;
                        [weakSelf reloadData];
                    }
                }];
                [textFieldAlertView show];
            }
                break;
            case ITEMTYPE_GENDER:
            {
                pickerView = [[CCPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275)  data:@[@"男", @"女"] saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    weakSelf.model.gender = selectIndex;
                    [weakSelf reloadData];
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            default:
                break;
        }
        
        if (pickerView)
        {
            self.zh_popupController = [zhPopupController new];
            self.zh_popupController.layoutType = zhPopupLayoutTypeBottom;
            self.zh_popupController.dismissOnMaskTouched = NO;
            [self.zh_popupController presentContentView:pickerView];
        }
    }
}

#pragma mark - CCUploadImgDelegate
- (void)onUploadSuccess:(NSDictionary *)dict
{
    [self endLoading];
    self.model.danImg = self.uploadReq.uploadImage;
    [self reloadData];
}

- (void)onUploadFailed:(NSInteger)errCode errMsg:(NSString *)msg
{
    [self endLoading];
    [self showToast:msg];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.row == 0)
    {
        height = CCPXToPoint(60);
    }
    else if (indexPath.row == 7)
    {
        height = CCPXToPoint(420);
    }
    else
    {
        height = CCPXToPoint(120);
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *rstCell = nil;
    if (indexPath.row == 0)
    {
        CCDevideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDevideIndentify];
        [cell setContentText:@"本赛季信息"];
        rstCell = cell;
    }
    else if (indexPath.row == 7)
    {
        CCPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPicIdentify];
        [cell.imgView setImage:self.model.danImg?:CCIMG(@"Wangzhe_Placeholder")];
        rstCell = cell;
    }
    else
    {
        CCTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTitleIndentify];
        [self setupTitleCell:cell withType:indexPath.row];
        rstCell = cell;
    }
    
    return rstCell;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    CCUploadImgRequest *uploadReq = [CCUploadImgRequest new];
    uploadReq.uploadKey = @"military_succ";
    uploadReq.uploadImage = image;
    [uploadReq startUploadWithUrl:[NSString stringWithFormat:@"%@%@", RootAddress, ComeInGame] andDelegate:self];
    self.uploadReq = uploadReq;
    [self beginLoading];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private
- (void)reloadData
{
    [self.tableView reloadData];
    [self.commitButton setEnabled:[self.model checkStep1InfoComplete]];
}

- (void)setupTitleCell:(CCTitleTableViewCell *)cell withType:(ITEMTYPE)type
{
    cell.tag = type;
    switch (type) {
        case ITEMTYPE_DAN:
        {
            if (self.model.maxDan)
            {
                [cell setTitle:@"最高段位" subTitle:self.model.maxDan subTitleColor:FontColor_Black];
            }
            else
            {
                [cell setTitle:@"最高段位" subTitle:@"请选择" subTitleColor:FontColor_Gray];
            }
        }
            break;
        case ITEMTYPE_PLATFORM:
        {
            if (self.model.platformType != 0)
            {
                [cell setTitle:@"服务区服" subTitle:[CCScoreModel getPlatformStr:self.model.platformType] subTitleColor:FontColor_Black];
            }
            else
            {
                [cell setTitle:@"服务区服" subTitle:@"请选择" subTitleColor:FontColor_Gray];
            }
        }
            break;
        case ITEMTYPE_CLIENT:
        {
            if (self.model.clientType != 0)
            {
                [cell setTitle:@"手机系统" subTitle:[CCScoreModel getSystemStr:self.model.clientType] subTitleColor:FontColor_Black];
            }
            else
            {
                [cell setTitle:@"手机系统" subTitle:@"请选择" subTitleColor:FontColor_Gray];
            }
        }
            break;
        case ITEMTYPE_SKILLED:
        {
            if (self.model.skilled)
            {
                [cell setTitle:@"擅长英雄" subTitle:self.model.skilled subTitleColor:FontColor_Black];
            }
            else
            {
                [cell setTitle:@"擅长英雄" subTitle:@"如花木兰、李元芳" subTitleColor:FontColor_Gray];
            }
        }
            break;
        case ITEMTYPE_HONOUR:
        {
            if (self.model.honour)
            {
                [cell setTitle:@"荣誉成就" subTitle:self.model.honour subTitleColor:FontColor_Black];
            }
            else
            {
                [cell setTitle:@"荣誉成就" subTitle:@"如国服第一貂蝉" subTitleColor:FontColor_Gray];
            }
        }
            break;
        case ITEMTYPE_GENDER:
        {
            if (self.model.gender != 0)
            {
                [cell setTitle:@"认证性别" subTitle:(self.model.gender==GENDER_BOY?@"男":@"女") subTitleColor:FontColor_Black];
            }
            else
            {
                [cell setTitle:@"认证性别" subTitle:@"请选择" subTitleColor:FontColor_Gray];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - getter
- (CCRefreshTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CCRefreshTableView alloc] initWithFrame:self.view.bounds];
        [_tableView enableFooter:NO];
        [_tableView enableHeader:NO];
        [_tableView.tableView setBounces:NO];
        [_tableView.tableView setDataSource:self];
        [_tableView.tableView setDelegate:self];
        [_tableView.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView.tableView registerClass:[CCDevideTableViewCell class] forCellReuseIdentifier:kDevideIndentify];
        [_tableView.tableView registerClass:[CCTitleTableViewCell class] forCellReuseIdentifier:kTitleIndentify];
        [_tableView.tableView registerClass:[CCPicTableViewCell class] forCellReuseIdentifier:kPicIdentify];
    }
    return _tableView;
}

- (CCCommitButton *)commitButton
{
    if (!_commitButton)
    {
        _commitButton = [CCCommitButton new];
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(onClickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (CCComeInModel *)model
{
    if (!_model)
    {
        _model = [CCComeInModel new];
    }
    return _model;
}

@end
