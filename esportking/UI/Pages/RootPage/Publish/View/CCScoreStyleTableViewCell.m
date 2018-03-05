//
//  CCScoreStyleTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCScoreStyleTableViewCell.h"

@interface CCScoreStyleTableViewCell ()

@property (weak  , nonatomic) id<CCScoreStyleTableViewCellDelegate> delegate;
@property (strong, nonatomic) UIButton *scoreButton;
@property (strong, nonatomic) UIButton *gameButton;
@property (strong, nonatomic) UIImageView *scoreSelectView;
@property (strong, nonatomic) UIImageView *gameSelectView;

@end

@implementation CCScoreStyleTableViewCell

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
    
    [self.contentView addSubview:self.scoreButton];
    [self.contentView addSubview:self.gameButton];
    [self.scoreButton addSubview:self.scoreSelectView];
    [self.gameButton  addSubview:self.gameSelectView];
    
    [self.scoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(-CCPXToPoint(151));
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(CCPXToPoint(224));
        make.height.mas_equalTo(CCPXToPoint(64));
    }];
    [self.gameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(CCPXToPoint(151));
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(CCPXToPoint(224));
        make.height.mas_equalTo(CCPXToPoint(64));
    }];
    [self.scoreSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.scoreButton);
        make.width.height.mas_equalTo(CCPXToPoint(32));
    }];
    [self.gameSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.gameButton);
        make.width.height.mas_equalTo(CCPXToPoint(32));
    }];
    [self.gameSelectView setHidden:YES];
}

- (void)setDelegate:(id<CCScoreStyleTableViewCellDelegate>)del
{
    self.delegate = del;
}

#pragma mark - action
- (void)onClickScoreButton:(UIButton *)button
{
    [self.delegate didSelectScoreStyle:SCORESTYLE_SCORE];
}

- (void)onClickGameButton:(UIButton *)button
{
    [self.delegate didSelectScoreStyle:SCORESTYLE_GAME];
}

#pragma mark - getter
- (UIButton *)scoreButton
{
    if (!_scoreButton)
    {
        _scoreButton = [UIButton new];
        [_scoreButton setTitle:@"上分专车" forState:UIControlStateNormal];
        [_scoreButton.layer setCornerRadius:CCPXToPoint(12)];
        [_scoreButton addTarget:self action:@selector(onClickScoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scoreButton;
}

- (UIButton *)gameButton
{
    if (!_gameButton)
    {
        _gameButton = [UIButton new];
        [_gameButton setTitle:@"娱乐专车" forState:UIControlStateNormal];
        [_gameButton.layer setCornerRadius:CCPXToPoint(12)];
        [_gameButton addTarget:self action:@selector(onClickGameButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gameButton;
}

- (UIImageView *)scoreSelectView
{
    if (!_scoreSelectView)
    {
        _scoreSelectView = [UIImageView new];
        [_scoreSelectView setImage:CCIMG(@"")];
    }
    return _scoreSelectView;
}

- (UIImageView *)gameSelectView
{
    if (!_gameSelectView)
    {
        _gameSelectView = [UIImageView new];
        [_gameSelectView setImage:CCIMG(@"")];
    }
    return _gameSelectView;
}

@end
