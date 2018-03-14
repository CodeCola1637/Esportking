//
//  CCScoreWaitViewController.m
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCScoreWaitViewController.h"
#import "CCOrderStageView.h"
#import "UIView+Wave.h"
#import "CCUserView.h"

#define kRoundWidth CCPXToPoint(164)

@interface CCScoreWaitViewController ()

@property (strong, nonatomic) CCScoreModel *scoreModel;

@property (strong, nonatomic) UILabel *serviceLabel;
@property (strong, nonatomic) UILabel *systemLabel;
@property (strong, nonatomic) UILabel *danLabel;
@property (strong, nonatomic) UILabel *countLabel;
@property (strong, nonatomic) UILabel *moneyLabel;

@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) CCOrderStageView *stageView;
@property (strong, nonatomic) UILabel *tipsLabel;

@property (strong, nonatomic) UIView *roundView;
@property (strong, nonatomic) UILabel *displayLabel;


@property (strong, nonatomic) CCUserView *userView;
@property (strong, nonatomic) UIButton *contactButton;

@end

@implementation CCScoreWaitViewController

- (instancetype)initWithScoreModel:(CCScoreModel *)model
{
    if (self = [super init])
    {
        self.scoreModel = model;
    }
    return self;
}

- (void)dealloc
{
    [self.roundView stopWaveAnimation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.roundView startWaveAnimationWithDiameter:kRoundWidth+CCPXToPoint(50) color:BgColor_Yellow duration:1.2];
    [self.roundView startWaveAnimationWithDiameter:kRoundWidth+CCPXToPoint(100) color:BgColor_Yellow duration:1.2];
    [self.roundView startWaveAnimationWithDiameter:kRoundWidth+CCPXToPoint(150) color:BgColor_Yellow duration:1.2];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"召唤大神"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.serviceLabel];
    [self.contentView addSubview:self.systemLabel];
    [self.contentView addSubview:self.danLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView addSubview:self.stageView];
    [self.contentView addSubview:self.roundView];
    [self.contentView addSubview:self.displayLabel];
    [self.contentView addSubview:self.tipsLabel];
    [self.contentView addSubview:self.userView];
    [self.contentView addSubview:self.contactButton];
    
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
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.lessThanOrEqualTo(self.contentView).offset(-CCHorMargin);
        make.top.equalTo(self.danLabel.mas_bottom).offset(CCPXToPoint(28));
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.lessThanOrEqualTo(self.contentView).offset(-CCHorMargin);
        make.top.equalTo(self.countLabel.mas_bottom).offset(CCPXToPoint(28));
    }];
    
    [self.stageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(CCPXToPoint(50));
    }];
    
    UIView *bottomView = [UIView new];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.stageView.mas_bottom);
    }];
    
    [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomView);
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
}

#pragma mark - action
- (void)onClickCancelButton:(UIButton *)button
{
    
}

- (void)onClickContactButton:(UIButton *)button
{
    
}

#pragma mark - private
- (void)setDisplayCount:(uint32_t)count
{
    NSMutableAttributedString *artStr = [[NSMutableAttributedString alloc] initWithString:@"已通知\n" attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:BoldFont_Big}];
    [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d\n", count] attributes:@{NSForegroundColorAttributeName:FontColor_Red, NSFontAttributeName:BoldFont_Large}]];
    [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"位大神" attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:BoldFont_Big}]];
    [self.displayLabel setAttributedText:artStr];
}

- (void)changeToGainOrderState
{
    [self.roundView stopWaveAnimation];
    [self.roundView setHidden:YES];
    [self.displayLabel setHidden:YES];
    [self.tipsLabel setHidden:YES];
    
    [self.userView setHidden:NO];
    [self.contactButton setHidden:NO];
}

#pragma mark - getter
- (UILabel *)serviceLabel
{
    if (!_serviceLabel)
    {
        _serviceLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_serviceLabel setTextAlignment:NSTextAlignmentLeft];
        NSMutableAttributedString *artStr = [[NSMutableAttributedString alloc] initWithString:@"发车方式：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
        [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:[CCScoreModel getSytleStr:self.scoreModel.style] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
        [_serviceLabel setAttributedText:artStr];
    }
    return _serviceLabel;
}

- (UILabel *)systemLabel
{
    if (!_systemLabel)
    {
        _systemLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_systemLabel setTextAlignment:NSTextAlignmentLeft];
        NSMutableAttributedString *artStr = [[NSMutableAttributedString alloc] initWithString:@"系统区服：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
        [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", [CCScoreModel getSystemStr:self.scoreModel.system], [CCScoreModel getPlatformStr:self.scoreModel.platform]] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
        [_systemLabel setAttributedText:artStr];
    }
    return _systemLabel;
}

- (UILabel *)danLabel
{
    if (!_danLabel)
    {
        _danLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_danLabel setTextAlignment:NSTextAlignmentLeft];
        if (self.scoreModel.style == SCORESTYLE_GAME)
        {
            NSMutableAttributedString *artStr = [[NSMutableAttributedString alloc] initWithString:@"段位信息：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
            [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:[CCScoreModel getLevelStr:self.scoreModel.level] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
            [_danLabel setAttributedText:artStr];
        }
        else
        {
            NSMutableAttributedString *artStr = [[NSMutableAttributedString alloc] initWithString:@"开始段位：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
            [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:[CCScoreModel getDetailLevelStr:self.scoreModel.startLevel] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
            [_danLabel setAttributedText:artStr];
        }
    }
    return _danLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel)
    {
        _countLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_countLabel setTextAlignment:NSTextAlignmentLeft];
        if (self.scoreModel.style == SCORESTYLE_GAME)
        {
            NSMutableAttributedString *artStr = [[NSMutableAttributedString alloc] initWithString:@"服务局数：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
            [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d局", self.scoreModel.count] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
            [_countLabel setAttributedText:artStr];
        }
        else
        {
            NSMutableAttributedString *artStr = [[NSMutableAttributedString alloc] initWithString:@"目标段位：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
            [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:[CCScoreModel getDetailLevelStr:self.scoreModel.endLevel] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
            [_countLabel setAttributedText:artStr];
        }
    }
    return _countLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_moneyLabel setTextAlignment:NSTextAlignmentLeft];
        NSMutableAttributedString *artStr = [[NSMutableAttributedString alloc] initWithString:@"订单金额：" attributes:@{NSForegroundColorAttributeName:FontColor_DeepDark, NSFontAttributeName:Font_Big}];
        [self.scoreModel calCulateMoney:^(BOOL success, uint32_t money) {
            [artStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%d", money] attributes:@{NSForegroundColorAttributeName:FontColor_Black, NSFontAttributeName:Font_Big}]];
            [_moneyLabel setAttributedText:artStr];
        }];
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
        [_contactButton.layer setBorderColor:[UIColor colorWithRGBHex:0xfb221c].CGColor];
        [_contactButton.layer setBorderWidth:CCOnePoint];
        [_contactButton addTarget:self action:@selector(onClickContactButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactButton;
}

@end
