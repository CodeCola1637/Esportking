//
//  CCNearbyTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCNearbyTableViewCell.h"
#import "CCGenderOldView.h"

#define kHeadWidth  CCPXToPoint(96)

@interface CCNearbyTableViewCell ()

@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) CCGenderOldView *genderView;
@property (strong, nonatomic) UILabel *orderLabel;

@end

@implementation CCNearbyTableViewCell

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
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.genderView];
    [self.contentView addSubview:self.orderLabel];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCPXToPoint(32));
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(kHeadWidth);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(CCPXToPoint(32));
        make.left.equalTo(self.headImgView.mas_right).offset(CCPXToPoint(28));
        make.right.lessThanOrEqualTo(self.contentView).offset(-CCPXToPoint(32));
    }];
    [self.genderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-CCPXToPoint(32));
        make.left.equalTo(self.nameLabel);
        make.height.mas_equalTo(CCPXToPoint(30));
    }];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(32));
        make.bottom.equalTo(self.nameLabel);
    }];
}

- (void)setGameModel:(CCGameModel *)model
{
    [self.headImgView setImageWithUrl:model.userModel.headUrl placeholder:CCIMG(@"Default_Header")];
    [self.nameLabel setText:model.userModel.name];
    [self.genderView setGender:model.userModel.gender andOld:model.userModel.age];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"接单" attributes:@{NSForegroundColorAttributeName:FontColor_Gray, NSFontAttributeName:BoldFont_Middle}];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lld次", model.totalCount] attributes:@{NSForegroundColorAttributeName:FontColor_Gold, NSFontAttributeName:BoldFont_Middle}]];
    [self.orderLabel setAttributedText:string];
}

#pragma mark - getter
- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView scaleFillImageView];
        [_headImgView.layer setCornerRadius:kHeadWidth/2.f];
    }
    return _headImgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel createOneLineLabelWithFont:BoldFont_Big color:FontColor_Black];
    }
    return _nameLabel;
}

- (CCGenderOldView *)genderView
{
    if (!_genderView)
    {
        _genderView = [[CCGenderOldView alloc] init];
        [_genderView.layer setCornerRadius:CCPXToPoint(15)];
    }
    return _genderView;
}

- (UILabel *)orderLabel
{
    if (!_orderLabel)
    {
        _orderLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
    }
    return _orderLabel;
}

@end
