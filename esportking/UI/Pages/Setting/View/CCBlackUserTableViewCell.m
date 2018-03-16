//
//  CCBlackUserTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBlackUserTableViewCell.h"

#define kHeadWidth  CCPXToPoint(96)

@interface CCBlackUserTableViewCell()

@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *nickLabel;

@end

@implementation CCBlackUserTableViewCell

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
    
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.nickLabel];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(kHeadWidth);
    }];
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.headImgView.mas_right).offset(CCPXToPoint(8));
    }];
}

- (void)setUserModel:(CCUserModel *)model
{
    [self.headImgView setImageWithUrl:model.headUrl placeholder:CCIMG(@"Default_Header")];
    [self.nickLabel setText:model.name];
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

- (UILabel *)nickLabel
{
    if (!_nickLabel)
    {
        _nickLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
    }
    return _nickLabel;
}

@end
