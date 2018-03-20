//
//  CCPayViewController.m
//  esportking
//
//  Created by CKQ on 2018/3/14.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCPayViewController.h"
#import "CCScoreWaitViewController.h"

#import "CCTitleItem.h"
#import "CCPayItemView.h"
#import "CCScoreModel.h"

#import "CCPayForOrderRequest.h"

@interface CCPayViewController ()<CCTitleItemDelegate, CCPayItemDelegate, CCRequestDelegate>

@property (strong, nonatomic) CCOrderModel *orderModel;
@property (strong, nonatomic) CCPayForOrderRequest *request;

@property (strong, nonatomic) UIView *topBGView;
@property (strong, nonatomic) UIView *centerBGView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descLabel;

@property (strong, nonatomic) CCTitleItem *styleItem;
@property (strong, nonatomic) CCTitleItem *locationItem;
@property (strong, nonatomic) CCTitleItem *detailItem;

@property (strong, nonatomic) CCPayItemView *wxPayItem;
@property (strong, nonatomic) CCPayItemView *zfbPayItem;
@property (strong, nonatomic) CCPayItemView *zhyePayItem;
@property (strong, nonatomic) CCPayItemView *cardPayItem;

@property (strong, nonatomic) UIButton *bottomButton;

@end

@implementation CCPayViewController

- (instancetype)initWithOrderModel:(CCOrderModel *)model
{
    if (self = [super init])
    {
        self.orderModel = model;
    }
    return self;
}

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
    [self addTopbarTitle:@"支付"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.topBGView];
    [self.contentView addSubview:self.styleItem];
    [self.contentView addSubview:self.locationItem];
    [self.contentView addSubview:self.detailItem];
    [self.contentView addSubview:self.centerBGView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.wxPayItem];
    [self.contentView addSubview:self.zfbPayItem];
    [self.contentView addSubview:self.zhyePayItem];
    [self.contentView addSubview:self.cardPayItem];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.bottomButton];
    
    [self.topBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(16));
    }];
    [self.styleItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBGView.mas_bottom);
        make.left.equalTo(self.contentView).offset(CCPXToPoint(20));
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(20));
    }];
    [self.locationItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.styleItem.mas_bottom);
        make.left.right.equalTo(self.styleItem);
    }];
    [self.detailItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationItem.mas_bottom);
        make.left.right.equalTo(self.styleItem);
    }];
    [self.centerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailItem.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(64));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.centerBGView).offset(-CCPXToPoint(10));
        make.left.equalTo(self.centerBGView).offset(CCHorMargin);
    }];
    [self.wxPayItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerBGView.mas_bottom);
        make.left.right.equalTo(self.contentView);
    }];
    [self.zfbPayItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wxPayItem.mas_bottom);
        make.left.right.equalTo(self.wxPayItem);
    }];
    [self.zhyePayItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zfbPayItem.mas_bottom);
        make.left.right.equalTo(self.wxPayItem);
    }];
    [self.cardPayItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zhyePayItem.mas_bottom);
        make.left.right.equalTo(self.wxPayItem);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardPayItem.mas_bottom);
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.equalTo(self.contentView).offset(-CCHorMargin);
    }];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(90));
    }];
}

- (void)configData
{
    [self.bottomButton setTitle:[NSString stringWithFormat:@"确认支付%d元", self.orderModel.money] forState:UIControlStateNormal];
    [self onSelectPayItem:PAYWAY_WX];
}

#pragma mark - action
- (void)onClickBottomButton:(UIButton *)button
{
    if (self.request)
    {
        return;
    }
    
    self.request = [CCPayForOrderRequest new];
    self.request.orderID = self.orderModel.orderID;
    self.request.money = self.orderModel.money;
    self.request.payPwd = 0;
    [self.request startPostRequestWithDelegate:self];
}

#pragma mark - CCTitleItemDelegate
- (void)onClickTitleItem:(id)sender
{
    
}

#pragma mark - CCPayItemDelegate
- (void)onSelectPayItem:(PAYWAY)way
{
    [self.wxPayItem setSelected:(way == PAYWAY_WX)];
    [self.zfbPayItem setSelected:(way == PAYWAY_ZFB)];
    [self.zhyePayItem setSelected:(way == PAYWAY_ZHYE)];
    [self.cardPayItem setSelected:(way == PAYWAY_CARD)];
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *vcs = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        [vcs removeObject:sender];
        [self.navigationController setViewControllers:vcs];
    });
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

#pragma mark - getter
- (UIView *)topBGView
{
    if (!_topBGView)
    {
        _topBGView = [UIView new];
        [_topBGView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _topBGView;
}

- (UIView *)centerBGView
{
    if (!_centerBGView)
    {
        _centerBGView = [UIView new];
        [_centerBGView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _centerBGView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_titleLabel setText:@"选择支付方式"];
    }
    return _titleLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [UILabel createMultiLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_descLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _descLabel;
}

- (CCTitleItem *)styleItem
{
    if (!_styleItem)
    {
        _styleItem = [[CCTitleItem alloc] initWithTitle:@"服务类型" subTitle:[CCScoreModel getSytleStr:self.orderModel.style] subTitleColor:FontColor_Black delegate:self];
        [_styleItem setArrowHidden:YES];
    }
    return _styleItem;
}

- (CCTitleItem *)locationItem
{
    if (!_locationItem)
    {
        _locationItem = [[CCTitleItem alloc] initWithTitle:@"系统区服" subTitle:[NSString stringWithFormat:@"%@ %@",[CCScoreModel getSystemStr:self.orderModel.clientType], [CCScoreModel getPlatformStr:self.orderModel.platformType]] subTitleColor:FontColor_Black delegate:self];
        [_locationItem setArrowHidden:YES];
    }
    return _locationItem;
}

- (CCTitleItem *)detailItem
{
    if (!_detailItem)
    {
        _detailItem = [[CCTitleItem alloc] initWithTitle:@"服务内容" subTitle:self.orderModel.danStr subTitleColor:FontColor_Black delegate:self];
        [_detailItem setArrowHidden:YES];
    }
    return _detailItem;
}

- (CCPayItemView *)wxPayItem
{
    if (!_wxPayItem)
    {
        _wxPayItem = [[CCPayItemView alloc] initWithPayWay:PAYWAY_WX del:self];
    }
    return _wxPayItem;
}

- (CCPayItemView *)zfbPayItem
{
    if (!_zfbPayItem)
    {
        _zfbPayItem = [[CCPayItemView alloc] initWithPayWay:PAYWAY_ZFB del:self];
    }
    return _zfbPayItem;
}

- (CCPayItemView *)zhyePayItem
{
    if (!_zhyePayItem)
    {
        _zhyePayItem = [[CCPayItemView alloc] initWithPayWay:PAYWAY_ZHYE del:self];
    }
    return _zhyePayItem;
}

- (CCPayItemView *)cardPayItem
{
    if (!_cardPayItem)
    {
        _cardPayItem = [[CCPayItemView alloc] initWithPayWay:PAYWAY_CARD del:self];
    }
    return _cardPayItem;
}

- (UIButton *)bottomButton
{
    if (!_bottomButton)
    {
        _bottomButton = [UIButton new];
        [_bottomButton setBackgroundColor:BgColor_Yellow];
        [_bottomButton addTarget:self action:@selector(onClickBottomButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

@end
