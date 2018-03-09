//
//  CCGameItemCollectionViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGameItemCollectionViewCell.h"
#import "CCGameModel.h"
#import "UILabel+Create.h"

@interface CCGameItemCollectionViewCell()

@property (strong, nonatomic) UIImageView   *imgView;
@property (strong, nonatomic) UILabel       *nickLabel;
@property (strong, nonatomic) UILabel       *gameLabel;

@end

@implementation CCGameItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.nickLabel];
    [self.contentView addSubview:self.gameLabel];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.gameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-CCPXToPoint(16));
        make.left.equalTo(self.contentView).offset(CCPXToPoint(26));
    }];
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.gameLabel.mas_top).offset(-CCPXToPoint(10));
        make.left.equalTo(self.gameLabel);
    }];
}

- (void)setGameModel:(CCGameModel *)model
{
    [self.imgView setImageWithUrl:model.userModel.headUrl placeholder:CCIMG(@"Placeholder_Icon")];
    [self.nickLabel setText:model.userModel.name];
    [self.gameLabel setText:@"王者荣耀"];
}

- (UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [UIImageView new];
        [_imgView setContentMode:UIViewContentModeScaleAspectFill];
        [_imgView setClipsToBounds:YES];
        [_imgView.layer setCornerRadius:CCPXToPoint(10)];
    }
    return _imgView;
}

- (UILabel *)nickLabel
{
    if (!_nickLabel)
    {
        _nickLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
        [_nickLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _nickLabel;
}

- (UILabel *)gameLabel
{
    if (!_gameLabel)
    {
        _gameLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_Black];
        [_gameLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _gameLabel;
}

@end
