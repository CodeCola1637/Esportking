//
//  CCOrderTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCOrderTableViewCell.h"
#import "CCScoreModel.h"

@interface CCOrderTableViewCell ()

@property (strong, nonatomic) CCOrderModel *dataModel;
@property (weak, nonatomic) id<CCOrderTableViewCellDelegate> delegate;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UILabel *duanLabel;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UIView *topLineView;
@property (strong, nonatomic) UIView *bottomLineView;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *confirmButton;

@end

@implementation CCOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.contentView addSubview:self.topView];
    [self.topView addSubview:self.timeLabel];
    [self.topView addSubview:self.statusLabel];
    [self.topView addSubview:self.topLineView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.locationLabel];
    [self.contentView addSubview:self.duanLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.confirmButton];
    [self.bottomView addSubview:self.cancelButton];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(64));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(CCPXToPoint(32));
        make.centerY.equalTo(self.topView);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView).offset(-CCPXToPoint(32));
        make.centerY.equalTo(self.topView);
    }];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.topView);
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel);
        make.top.equalTo(self.topLineView.mas_bottom).offset(CCPXToPoint(20));
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CCPXToPoint(6));
    }];
    [self.duanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationLabel);
        make.top.equalTo(self.locationLabel.mas_bottom).offset(CCPXToPoint(6));
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.duanLabel);
        make.top.equalTo(self.duanLabel.mas_bottom).offset(CCPXToPoint(6));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topLineView);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(CCPXToPoint(20));
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(80));
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView).offset(-CCPXToPoint(32));
        make.centerY.equalTo(self.bottomView);
        make.height.mas_equalTo(CCPXToPoint(48));
        make.width.mas_offset(CCPXToPoint(96));
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.confirmButton.mas_left).offset(-CCPXToPoint(20));
        make.centerY.height.equalTo(self.confirmButton);
        make.width.mas_offset(CCPXToPoint(96));
    }];
}

- (void)setOrderDict:(CCOrderModel *)model andDelegate:(id<CCOrderTableViewCellDelegate>)del source:(ORDERSOURCE)source
{
    self.dataModel = model;
    self.delegate = del;
    
    [self.timeLabel setText:[NSString stringWithFormat:@"时间：%@", model.createTime]];
    [self.nameLabel setText:[NSString stringWithFormat:@"接单大神：%@", [self getReceiverNameWithModel:model]]];
    [self.locationLabel setText:[NSString stringWithFormat:@"系统区服：%@ %@", [CCScoreModel getSystemStr:model.clientType], [CCScoreModel getPlatformStr:model.platformType]]];
    [self.duanLabel setText:[NSString stringWithFormat:@"段位信息：%@", model.danStr]];
    [self.moneyLabel setText:[NSString stringWithFormat:@"订单金额：¥%.2f", (CGFloat)model.money]];
    
    switch (model.displayStatus)
    {
        case ORDERDISPLAYSTATUS_CANCEL:
        {
            [self.statusLabel setText:@"已取消"];
            [self.cancelButton setHidden:YES];
            [self.confirmButton setHidden:YES];
        }
            break;
        case ORDERDISPLAYSTATUS_BACKMONEY:
        {
            [self.statusLabel setText:@"已退款"];
            [self.cancelButton setHidden:YES];
            [self.confirmButton setHidden:YES];
        }
            break;
        case ORDERDISPLAYSTATUS_WAITPAY:
        {
            [self.statusLabel setText:@"待支付"];
            [self.cancelButton setHidden:NO];
            [self.confirmButton setHidden:NO];
            [self.confirmButton setTitle:@"支付" forState:UIControlStateNormal];
            [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.confirmButton.mas_left).offset(-CCPXToPoint(20));
            }];
            [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(CCPXToPoint(96));
            }];
        }
            break;
        case ORDERDISPLAYSTATUS_FIALPAY:
        {
            [self.statusLabel setText:@"支付失败"];
            [self.cancelButton setHidden:NO];
            [self.confirmButton setHidden:NO];
            [self.confirmButton setTitle:@"支付" forState:UIControlStateNormal];
            [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.confirmButton.mas_left).offset(-CCPXToPoint(20));
            }];
            [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(CCPXToPoint(96));
            }];
        }
            break;
        case ORDERDISPLAYSTATUS_WIATRECV:
        {
            [self.statusLabel setText:@"待接单"];
            if (source == ORDERSOURCE_SEND)
            {
                [self.cancelButton setHidden:NO];
                [self.confirmButton setHidden:YES];
                [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.confirmButton.mas_left).offset(0);
                }];
                [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(0);
                }];
            }
            else
            {
                [self.cancelButton setHidden:YES];
                [self.confirmButton setHidden:NO];
                [self.confirmButton setTitle:@"接单" forState:UIControlStateNormal];
                [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(CCPXToPoint(96));
                }];
            }
            
        }
            break;
        case ORDERDISPLAYSTATUS_ONDOING:
        {
            [self.statusLabel setText:@"进行中"];
            [self.cancelButton setHidden:YES];
            [self.confirmButton setHidden:NO];
            [self.confirmButton setTitle:@"确认完成" forState:UIControlStateNormal];
            [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(CCPXToPoint(144));
            }];
        }
            break;
        case ORDERDISPLAYSTATUS_WAITCOMMENT:
        {
            [self.statusLabel setText:@"待评价"];
            [self.cancelButton setHidden:YES];
            [self.confirmButton setHidden:NO];
            [self.confirmButton setTitle:@"评价" forState:UIControlStateNormal];
            [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(CCPXToPoint(96));
            }];
        }
            break;
        case ORDERDISPLAYSTATUS_COMPLETED:
        {
            [self.statusLabel setText:@"已完成"];
            [self.cancelButton setHidden:YES];
            [self.confirmButton setHidden:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - action
- (void)onClickCancelButton:(UIButton *)button
{
    [self.delegate onCancelOrder:self.dataModel];
}

- (void)onClickConfirmButton:(UIButton *)button
{
    [self.delegate onConfirmOrder:self.dataModel];
}

#pragma mark - private
- (NSString *)getReceiverNameWithModel:(CCOrderModel *)model
{
    NSString *recvStr = model.receiverName;
    if (recvStr && recvStr.length > 0)
    {
        return recvStr;
    }
    else
    {
        return @"暂无";
    }
}

#pragma mark - getters
- (UIView *)topView
{
    if (!_topView)
    {
        _topView = [UIView new];
    }
    return _topView;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
    }
    return _timeLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel)
    {
        _statusLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Yellow];
    }
    return _statusLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _nameLabel;
}

- (UILabel *)locationLabel
{
    if (!_locationLabel)
    {
        _locationLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _locationLabel;
}

- (UILabel *)duanLabel
{
    if (!_duanLabel)
    {
        _duanLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _duanLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _moneyLabel;
}

- (UIView *)topLineView
{
    if (!_topLineView)
    {
        _topLineView = [UIView new];
        [_topLineView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _topLineView;
}

- (UIView *)bottomLineView
{
    if (!_bottomLineView)
    {
        _bottomLineView = [UIView new];
        [_bottomLineView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _bottomLineView;
}

- (UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [UIView new];
    }
    return _bottomView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [UIButton new];
        [_cancelButton setBackgroundColor:[UIColor colorWithRGBHex:0xdedede]];
        [_cancelButton.layer setCornerRadius:CCPXToPoint(12)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:Font_Small];
        [_cancelButton addTarget:self action:@selector(onClickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton)
    {
        _confirmButton = [UIButton new];
        [_confirmButton setBackgroundColor:BgColor_Yellow];
        [_confirmButton.layer setCornerRadius:CCPXToPoint(12)];
        [_confirmButton.titleLabel setFont:Font_Small];
        [_confirmButton setTitle:@"接单" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(onClickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
