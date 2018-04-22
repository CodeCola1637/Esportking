//
//  CCOrderSessionViewController.m
//  esportking
//
//  Created by jaycechen on 2018/3/21.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCOrderSessionViewController.h"
#import "CCOrderStageView.h"

@interface CCOrderSessionViewController ()

@property (strong, nonatomic) CCUserModel *receiver;
@property (strong, nonatomic) CCOrderModel *orderModel;

@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UIButton *finishButton;
@property (strong, nonatomic) UIView *centerBGView;
@property (strong, nonatomic) UILabel *tipsLabel;
@property (strong, nonatomic) UIButton *reportButton;
@property (strong, nonatomic) CCOrderStageView *stageView;
@property (strong, nonatomic) NIMSessionViewController *chatVC;

@end

@implementation CCOrderSessionViewController

- (instancetype)initWithSession:(NIMSession *)session orderModel:(CCOrderModel *)model receiver:(CCUserModel *)user
{
    if (self = [super init])
    {
        self.receiver = user;
        self.orderModel = model;
        self.chatVC = [[NIMSessionViewController alloc] initWithSession:session];
        [self addChildViewController:self.chatVC];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    [self renderWithData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.chatVC.tableView reloadData];
    });
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:(self.receiver.name ? : @"聊天")];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:0];
    
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.finishButton];
    [self.contentView addSubview:self.centerBGView];
    [self.centerBGView addSubview:self.tipsLabel];
    [self.centerBGView addSubview:self.reportButton];
    [self.contentView addSubview:self.stageView];
    [self.contentView addSubview:self.chatVC.view];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.top.equalTo(self.contentView);
        make.width.height.mas_equalTo(CCPXToPoint(80));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(CCPXToPoint(16));
        make.top.equalTo(self.headImgView).offset(CCPXToPoint(8));
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descLabel);
        make.top.equalTo(self.descLabel.mas_bottom).offset(CCPXToPoint(16));
    }];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImgView);
        make.right.equalTo(self.contentView).offset(-CCHorMargin);
        make.width.mas_equalTo(CCPXToPoint(120));
        make.height.mas_equalTo(CCPXToPoint(48));
    }];
    [self.stageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView.mas_bottom).offset(CCPXToPoint(10));
        make.left.equalTo(self.contentView);
    }];
    [self.centerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.stageView.mas_bottom).offset(CCPXToPoint(24));
        make.width.mas_equalTo(CCPXToPoint(560));
        make.height.mas_equalTo(CCPXToPoint(40));
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerBGView);
        make.centerY.equalTo(self.centerBGView);
    }];
    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.centerBGView);
        make.left.equalTo(self.tipsLabel.mas_right);
    }];
    
    CGFloat originY = CCPXToPoint(80)+CCPXToPoint(10)+CCPXToPoint(40)+CCPXToPoint(24)+LM_SCREEN_WIDTH/CCIMG(@"Order_Stage_BG").size.width*CCIMG(@"Order_Stage_BG").size.height;
    CGRect frame = self.contentView.bounds;
    
    [self.chatVC.view setFrame:CGRectMake(0, originY, frame.size.width, frame.size.height-originY)];
    [self.chatVC.view setNeedsLayout];
    [self.chatVC.view layoutIfNeeded];
}

- (void)renderWithData
{
    [self.finishButton setHidden:YES];
    [self.headImgView setImageWithUrl:self.receiver.headUrl placeholder:CCIMG(@"Default_Header")];
    [self.descLabel setText:self.orderModel.danStr];
    [self.moneyLabel setText:[NSString stringWithFormat:@"¥%.2f", self.orderModel.money]];
    
    switch (self.orderModel.displayStatus)
    {
        case ORDERDISPLAYSTATUS_ONDOING:
        {
            [self.stageView setOrderStage:ORDERSTAGE_START];
            if (self.orderModel.receiverID != CCAccountServiceInstance.userID)
            {
                [self.finishButton setHidden:NO];
            }
        }
            break;
        case ORDERDISPLAYSTATUS_WAITCOMMENT:
        case ORDERDISPLAYSTATUS_COMPLETED:
        {
            [self.stageView setOrderStage:ORDERSTAGE_FINISH];
        }
            break;
        case ORDERDISPLAYSTATUS_WIATRECV:

        default:
        {
            [self.stageView setOrderStage:ORDERSTAGE_WAIT];
        }
            break;
    }
}

#pragma mark - action
- (void)onClickFinishButton:(UIButton *)button
{
    
}

- (void)onClickReportButton:(UIButton *)button
{
    
}

#pragma mark - getter
- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView scaleFillImageView];
        [_headImgView.layer setCornerRadius:CCPXToPoint(80)/2.f];
    }
    return _headImgView;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_Black];
    }
    return _descLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Red];
    }
    return _moneyLabel;
}

- (UIButton *)finishButton
{
    if (!_finishButton)
    {
        _finishButton = [UIButton new];
        [_finishButton setBackgroundColor:BgColor_Yellow];
        [_finishButton setTitle:@"确认完成" forState:UIControlStateNormal];
        [_finishButton setTitleColor:FontColor_Black forState:UIControlStateNormal];
        [_finishButton.layer setCornerRadius:CCPXToPoint(48)/2.f];
        [_finishButton.titleLabel setFont:Font_Small];
        [_finishButton addTarget:self action:@selector(onClickFinishButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishButton;
}

- (UIView *)centerBGView
{
    if (!_centerBGView)
    {
        _centerBGView = [UIView new];
        [_centerBGView setBackgroundColor:[UIColor colorWithRGBHex:0xf3f3f3]];
    }
    return _centerBGView;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel)
    {
        _tipsLabel = [UILabel createOneLineLabelWithFont:Font_Tiny color:FontColor_DeepDark];
        [_tipsLabel setText:@"如果大神有任何违规行为，您可在订单页面"];
    }
    return _tipsLabel;
}

- (UIButton *)reportButton
{
    if (!_reportButton)
    {
        _reportButton = [UIButton new];
        [_reportButton.titleLabel setFont:Font_Small];
        [_reportButton setTitleColor:FontColor_DeepDark forState:UIControlStateNormal];
        [_reportButton setTitle:@"投诉并申请退款" forState:UIControlStateNormal];
        [_reportButton addTarget:self action:@selector(onClickReportButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reportButton;
}

- (CCOrderStageView *)stageView
{
    if (!_stageView)
    {
        _stageView = [[CCOrderStageView alloc] init];
    }
    return _stageView;
}

@end
