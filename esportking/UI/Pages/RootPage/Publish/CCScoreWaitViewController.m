//
//  CCScoreWaitViewController.m
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCScoreWaitViewController.h"
#import "CCOrderSessionViewController.h"

#import "CCOrderStageView.h"
#import "UIView+Wave.h"
#import "CCUserView.h"
#import "CCShowView.h"

#import "CCScoreModel.h"
#import "CCOrderModel.h"
#import "CCGameModel.h"

#import "CCOrderRequest.h"
#import "CCUserDetailRequest.h"

#define kRoundWidth CCPXToPoint(164)

@interface CCScoreWaitViewController ()<CCRequestDelegate, CCShowViewDelegate>

@property (strong, nonatomic) CCOrderRequest *request;
@property (strong, nonatomic) CCUserDetailRequest *userReq;

@property (strong, nonatomic) CCOrderModel *orderModel;
@property (strong, nonatomic) CCGameModel *userModel;

@property (strong, nonatomic) UILabel *serviceLabel;
@property (strong, nonatomic) UILabel *systemLabel;
@property (strong, nonatomic) UILabel *danLabel;
@property (strong, nonatomic) UILabel *moneyLabel;

@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) CCOrderStageView *stageView;
@property (strong, nonatomic) UILabel *tipsLabel;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIView *roundView;
@property (strong, nonatomic) UILabel *displayLabel;

@property (strong, nonatomic) CCShowView *showView;
@property (strong, nonatomic) CCUserView *userView;
@property (strong, nonatomic) UIButton *contactButton;

@end

@implementation CCScoreWaitViewController

- (void)dealloc
{
    [self.roundView stopWaveAnimation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    
    [self startRequestDoingOrder];
}

- (void)configTopbar
{
    [self addTopbarTitle:@"召唤大神"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.serviceLabel];
    [self.contentView addSubview:self.systemLabel];
    [self.contentView addSubview:self.danLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView addSubview:self.stageView];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.roundView];
    [self.contentView addSubview:self.displayLabel];
    [self.contentView addSubview:self.tipsLabel];
    [self.contentView addSubview:self.userView];
    [self.contentView addSubview:self.contactButton];
    [self.contentView addSubview:self.showView];
    
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.lessThanOrEqualTo(self.contentView).offset(-CCHorMargin);
        make.top.equalTo(self.contentView);
    }];
    [self.systemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.lessThanOrEqualTo(self.contentView).offset(-CCHorMargin);
        make.top.equalTo(self.serviceLabel.mas_bottom).offset(CCPXToPoint(28));
    }];
    [self.danLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.lessThanOrEqualTo(self.contentView).offset(-CCHorMargin);
        make.top.equalTo(self.systemLabel.mas_bottom).offset(CCPXToPoint(28));
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.lessThanOrEqualTo(self.contentView).offset(-CCHorMargin);
        make.top.equalTo(self.danLabel.mas_bottom).offset(CCPXToPoint(28));
    }];
    
    [self.stageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(CCPXToPoint(50));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.stageView.mas_bottom);
    }];
    
    [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bottomView);
        make.width.height.mas_equalTo(kRoundWidth);
    }];
    [self.displayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.roundView);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-CCPXToPoint(90));
    }];
    
    [self.contactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-CCPXToPoint(146));
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(CCPXToPoint(410));
        make.height.mas_equalTo(CCPXToPoint(86));
    }];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contactButton.mas_top).offset(-CCPXToPoint(50));
        make.height.mas_equalTo(UserViewHeight);
    }];
    
    [self.contactButton setHidden:YES];
    [self.userView setHidden:YES];
    
    [self.showView setCurrentStatus:SHOWSTATUS_DOWN location:CGPointMake(self.contentView.width-CCPXToPoint(170), 0) animated:NO];
}

#pragma mark - action
- (void)onClickCancelButton:(UIButton *)button
{
    
}

- (void)onClickContactButton:(UIButton *)button
{
    NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"test_%llu", self.userModel.userModel.userID] type:NIMSessionTypeP2P];
    CCOrderSessionViewController *vc = [[CCOrderSessionViewController alloc] initWithSession:session orderModel:self.orderModel receiver:self.userModel.userModel];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CCShowViewDelegate
- (void)didClickShowView:(SHOWSTATUS)status
{
    //修改push方向
    CATransition* transition = [CATransition animation];
    transition.type          = kCATransitionReveal;//可更改为其他方式
    transition.subtype       = kCATransitionFromBottom;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (self.request == sender)
    {
        if (self.request.orderList && self.request.orderList.count>0)
        {
            CCAccountServiceInstance.hasDoingOrder = YES;
        }
        else
        {
            CCAccountServiceInstance.hasDoingOrder = NO;
            [self didClickShowView:SHOWSTATUS_DOWN];
            [self showToast:@"暂无正在进行订单"];
            return;
        }
        
        self.orderModel = [self.request.orderList firstObject];
        [self refreshUIData];
        
        if (self.orderModel.receiverID != 0)
        {
            if (self.orderModel.receiverID != CCAccountServiceInstance.userID)
            {
                self.userReq = [CCUserDetailRequest new];
                self.userReq.userID = self.orderModel.receiverID;
                self.userReq.gameID = GAMEID_WANGZHE;
                [self.userReq startPostRequestWithDelegate:self];
            }
            else
            {
                self.userReq = [CCUserDetailRequest new];
                self.userReq.userID = self.orderModel.senderID;
                self.userReq.gameID = GAMEID_WANGZHE;
                [self.userReq startPostRequestWithDelegate:self];
            }
        }
        
        self.request = nil;
    }
    else if (self.userReq == sender)
    {
        self.userModel = [CCGameModel new];
        [self.userModel setGameInfo:dict[@"data"][@"user"]];
        [self refreshUIData];
        self.userReq = nil;
    }
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (self.request == sender)
    {
        self.request = nil;
        [self showToast:msg];
    }
    else if (self.userReq == sender)
    {
        self.userReq = nil;
        [self showToast:msg];
    }
}

#pragma mark - private
- (void)startRequestDoingOrder
{
    if (self.request)
    {
        return;
    }
    
    self.request = [CCOrderRequest new];
    self.request.type = ORDERSOURCE_DOING;
    self.request.gameID = GAMEID_WANGZHE;
    self.request.pageNum = 1;
    self.request.pageSize = 20;
    self.request.status = 2;
    [self.request startPostRequestWithDelegate:self];
}

- (void)refreshUIData
{
    if (!self.orderModel)
    {
        return ;
    }
    
    NSMutableAttributedString *svrStr = [[NSMutableAttributedString alloc] initWithString:@"发车方式：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
    [svrStr appendAttributedString:[[NSAttributedString alloc] initWithString:[CCScoreModel getSytleStr:self.orderModel.style] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
    [_serviceLabel setAttributedText:svrStr];
    
    NSMutableAttributedString *sysStr = [[NSMutableAttributedString alloc] initWithString:@"系统区服：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
    [sysStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", [CCScoreModel getSystemStr:self.orderModel.clientType], [CCScoreModel getPlatformStr:self.orderModel.platformType]] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
    [_systemLabel setAttributedText:sysStr];
    
    NSMutableAttributedString *danStr = [[NSMutableAttributedString alloc] initWithString:@"服务详情：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
    [danStr appendAttributedString:[[NSAttributedString alloc] initWithString:self.orderModel.danStr attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
    [_danLabel setAttributedText:danStr];
    
    NSMutableAttributedString *monStr = [[NSMutableAttributedString alloc] initWithString:@"订单金额：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
    [monStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%d", self.orderModel.money] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
    [_moneyLabel setAttributedText:monStr];
    
    switch (self.orderModel.displayStatus)
    {
        case ORDERDISPLAYSTATUS_WIATRECV:
        {
            if (self.orderModel.receiverID != 0)
            {
                [self changeToWaitStatus];
            }
            else
            {
                [self changeToSearchStatus];
            }
        }
            break;
        case ORDERDISPLAYSTATUS_ONDOING:
        {
            [self changeToDoingStatus];
        }
            break;
        case ORDERDISPLAYSTATUS_WAITCOMMENT:
        {
            [self changeToDoingStatus];
        }
            break;
        case ORDERDISPLAYSTATUS_COMPLETED:
        {
            [self changeToCompleteStatus];
        }
            break;
        default:
            break;
    }
}

- (void)changeToSearchStatus
{
    NSMutableAttributedString *artStr = [[NSMutableAttributedString alloc] initWithString:@"已通知\n" attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:BoldFont_Big}];
    [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d\n", arc4random()%30] attributes:@{NSForegroundColorAttributeName:FontColor_Red, NSFontAttributeName:BoldFont_Large}]];
    [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"位大神" attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:BoldFont_Big}]];
    [self.displayLabel setAttributedText:artStr];
    
    [self.roundView startWaveAnimationWithDiameter:kRoundWidth+CCPXToPoint(50) color:BgColor_Yellow duration:1.2];
    [self.roundView startWaveAnimationWithDiameter:kRoundWidth+CCPXToPoint(100) color:BgColor_Yellow duration:1.2];
    [self.roundView startWaveAnimationWithDiameter:kRoundWidth+CCPXToPoint(150) color:BgColor_Yellow duration:1.2];
    [self.stageView setOrderStage:ORDERSTAGE_SEARCH];
}

- (void)changeToWaitStatus
{
    [self.roundView stopWaveAnimation];
    [self.bottomView setHidden:YES];
    [self.displayLabel setHidden:YES];
    [self.tipsLabel setHidden:YES];
    
    [self.userView setUserInfo:self.userModel.userModel businessCount:self.userModel.totalCount starCount:self.userModel.auth];
    [self.userView setHidden:NO];
    [self.contactButton setHidden:NO];
    [self.stageView setOrderStage:ORDERSTAGE_WAIT];
}

- (void)changeToDoingStatus
{
    [self.roundView stopWaveAnimation];
    [self.bottomView setHidden:YES];
    [self.displayLabel setHidden:YES];
    [self.tipsLabel setHidden:YES];
    
    [self.userView setUserInfo:self.userModel.userModel businessCount:self.userModel.totalCount starCount:self.userModel.auth];
    [self.userView setHidden:NO];
    [self.contactButton setHidden:NO];
    [self.stageView setOrderStage:ORDERSTAGE_START];
}

- (void)changeToCompleteStatus
{
    [self.roundView stopWaveAnimation];
    [self.bottomView setHidden:YES];
    [self.displayLabel setHidden:YES];
    [self.tipsLabel setHidden:YES];
    
    [self.userView setUserInfo:self.userModel.userModel businessCount:self.userModel.totalCount starCount:self.userModel.auth];
    [self.userView setHidden:NO];
    [self.contactButton setHidden:NO];
    [self.stageView setOrderStage:ORDERSTAGE_FINISH];
}

#pragma mark - getter
- (UILabel *)serviceLabel
{
    if (!_serviceLabel)
    {
        _serviceLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_serviceLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _serviceLabel;
}

- (UILabel *)systemLabel
{
    if (!_systemLabel)
    {
        _systemLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_systemLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _systemLabel;
}

- (UILabel *)danLabel
{
    if (!_danLabel)
    {
        _danLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_danLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _danLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_moneyLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _moneyLabel;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [UIButton new];
        [_cancelButton setBackgroundColor:BgColor_Yellow];
        [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:FontColor_Black forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(onClickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (CCOrderStageView *)stageView
{
    if (!_stageView)
    {
        _stageView = [[CCOrderStageView alloc] init];
    }
    return _stageView;
}

- (UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [UIView new];
    }
    return _bottomView;
}

- (UIView *)roundView
{
    if (!_roundView)
    {
        _roundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRoundWidth, kRoundWidth)];
        [_roundView.layer setCornerRadius:kRoundWidth/2.f];
        [_roundView setBackgroundColor:BgColor_Yellow];
    }
    return _roundView;
}

- (UILabel *)displayLabel
{
    if (!_displayLabel)
    {
        _displayLabel = [UILabel createMultiLineLabelWithFont:Font_Large color:FontColor_Black];
    }
    return _displayLabel;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel)
    {
        _tipsLabel = [UILabel createMultiLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_tipsLabel setText:@"若60秒内没有大神接单，订单将自动取消"];
    }
    return _tipsLabel;
}

- (CCShowView *)showView
{
    if (!_showView)
    {
        _showView = [CCShowView new];
        [_showView setDelegate:self];
    }
    return _showView;
}

- (CCUserView *)userView
{
    if (!_userView)
    {
        _userView = [CCUserView new];
    }
    return _userView;
}

- (UIButton *)contactButton
{
    if (!_contactButton)
    {
        _contactButton = [UIButton new];
        [_contactButton setTitle:@"联系小伙伴" forState:UIControlStateNormal];
        [_contactButton setTitleColor:FontColor_Black forState:UIControlStateNormal];
        [_contactButton.layer setCornerRadius:CCPXToPoint(86)/2.f];
        [_contactButton.layer setBorderColor:[UIColor colorWithRGBHex:0xe8e7e7].CGColor];
        [_contactButton.layer setBorderWidth:CCOnePoint];
        [_contactButton addTarget:self action:@selector(onClickContactButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactButton;
}

@end
